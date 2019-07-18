using AutoMapper;
using Hangfire;
using Hangfire.Storage;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;

namespace POS.UI.Sync
{
    public class NavSync
    {

        private readonly EntityCore _context;
        private readonly EntityCore _contextInsert;
        private readonly IMapper _mapper;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private IMemoryCache _cache;



        public NavSync(EntityCore context, IMapper mapper, UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager, IMemoryCache memoryCache)
        {
            _context = context;
            _mapper = mapper;
            _userManager = userManager;
            _roleManager = roleManager;
            _cache = memoryCache;
            _contextInsert = context;
            _context.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
        }



        public bool StopAllScheduler()
        {
            var recurringJobs = Hangfire.JobStorage.Current.GetConnection().GetRecurringJobs();

            foreach (var item in recurringJobs)
            {
                RecurringJob.RemoveIfExists(item.Id);
            }

            //update status
            Config config = ConfigJSON.Read();
            config.SchedulerDuration.Status = "Not Started";
            ConfigJSON.Write(config);
            return true;
        }


        //sync tables
        public bool StartAllScheduler()
        {

            Config config = ConfigJSON.Read();


            //Item Category
            RecurringJob.AddOrUpdate(() => ItemCategorySync(), "*/" + config.SchedulerDuration.ItemCategory + " * * * *");

            //Product Group
            RecurringJob.AddOrUpdate(() => ProductGroupSync(), "*/" + config.SchedulerDuration.ProductGroup + " * * * *");


            //Item Type
            //RecurringJob.AddOrUpdate(() => ItemTypeSync(), "*/" + config.SchedulerDuration.ItemType + " * * * *");

            //Items
            RecurringJob.AddOrUpdate(() => ItemSync(), "*/" + config.SchedulerDuration.Item + " * * * *");

            //ItemBarCode
            RecurringJob.AddOrUpdate(() => ItemBarCodeSync(), "*/" + config.SchedulerDuration.ItemBarCode + " * * * *");


            //ItemPrice
            RecurringJob.AddOrUpdate(() => ItemPriceSync(), "*/" + config.SchedulerDuration.ItemPrice + " * * * *");

            //Customer
            RecurringJob.AddOrUpdate(() => CustomerSync(), "*/" + config.SchedulerDuration.Customer + " * * * *");


            //denomination auto save at midnight if not saved
            RecurringJob.AddOrUpdate(() => DenominationScheduler(), "0 0 * * *");

            //update status
            config.SchedulerDuration.Status = "Running...";
            ConfigJSON.Write(config);
            return true;

        }




        public bool CompanySync()
        {
            Config config = ConfigJSON.Read();
            string url = config.NavApiBaseUrl + "/" + config.NavPath + "/companies";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            IRestResponse<CompanyApiModel> response = client.Execute<CompanyApiModel>(request);

            if (response.StatusCode == HttpStatusCode.OK)
            {
                IList<Company> company = response.Data.value;
                var missingRecords = company.Where(x => !_context.Company.Any(y => y.id == x.id)).ToList();
                _context.Company.AddRange(missingRecords);
                _context.SaveChanges();
                return true;
            }
            else
                return false;
        }
        public IList<Company> GetCompanySync()
        {
            Config config = ConfigJSON.Read();
            string url = config.NavApiBaseUrl + "/" + config.NavPath + "/companies";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            IRestResponse<CompanyApiModel> response = client.Execute<CompanyApiModel>(request);

            if (response.StatusCode == HttpStatusCode.OK)
                return response.Data.value;
            else
                return new List<Company>();
        }


        public bool StoreSync()
        {
            bool IsStoreSyncIsInProcess = false;
            _cache.TryGetValue("IsStoreSyncIsInProcess", out IsStoreSyncIsInProcess);
            if (!IsStoreSyncIsInProcess)
            {
                try
                {
                    Config config = ConfigJSON.Read();
                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Store");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$filter=Code eq '" + config.Location + "'";
                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavStoreInfo>> response = client.Execute<SyncModel<NavStoreInfo>>(request);


                    if (response.StatusCode == HttpStatusCode.OK)
                    {

                        Store item = _mapper.Map<List<Store>>(response.Data.value).FirstOrDefault();
                        if (item != null)
                        {
                            Store store = _context.Store.FirstOrDefault();

                            store.NAME = item.NAME;
                            store.INITIAL = item.INITIAL;
                            store.COMPANY_NAME = item.COMPANY_NAME;
                            store.ADDRESS = item.ADDRESS;
                            store.PHONE = item.PHONE;
                            store.PHONE_ALT = item.PHONE_ALT;
                            store.FAX = item.FAX;
                            store.EMAIL = item.EMAIL;
                            store.WEBSITE = item.WEBSITE;
                            store.CustomerPriceGroup = item.CustomerPriceGroup;

                            //update update number
                            if (response.Data.value.Count() > 0)
                            {
                                services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                                services.LastSyncDate = DateTime.Now;
                            }
                        }
                        CompanyVatNumberSync();
                        _context.SaveChanges();
                        _cache.Set("IsStoreSyncIsInProcess", false);
                        return true;
                    }
                    else
                    {
                        _cache.Set("IsStoreSyncIsInProcess", false);
                        return false;
                    }
                }
                catch (Exception ex)
                {
                    //log
                    return false;
                }
            }
            else
                return true;


        }
        public bool CompanyVatNumberSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "CompanyInfo");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";

            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavCompanyInfo>> response = client.Execute<SyncModel<NavCompanyInfo>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                NavCompanyInfo item = response.Data.value.FirstOrDefault();
                if (item != null)
                {
                    Store store = _context.Store.FirstOrDefault();
                    store.VAT = item.taxRegistrationNumber;


                    _context.SaveChanges();
                }
                return true;
            }
            else
                return false;
        }
        public bool ItemCategorySync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item Category");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NAVItemCategory>> response = client.Execute<SyncModel<NAVItemCategory>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                List<ItemCategory> item = _mapper.Map<List<ItemCategory>>(response.Data.value);
                _context.ItemCategory.RemoveRange(_context.ItemCategory.Where(x => item.Any(y => y.Code == x.Code)));
                _context.SaveChanges();
                _context.ItemCategory.AddRange(item);

                //update update number
                if (response.Data.value.Count() > 0)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                }
                _context.SaveChanges();
                return true;
            }
            else
                return false;
        }
        public bool ProductGroupSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Product Group");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NAVProductGroup>> response = client.Execute<SyncModel<NAVProductGroup>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                List<ItemGroup> item = _mapper.Map<List<ItemGroup>>(response.Data.value);

                _context.ItemGroup.RemoveRange(_context.ItemGroup.Where(x => item.Any(y => y.Code == x.Code)));
                _context.SaveChanges();
                _context.ItemGroup.AddRange(item);

                //update update number
                if (response.Data.value.Count() > 0)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                }
                _context.SaveChanges();
                return true;
            }
            else
                return false;

        }
        public bool ItemTypeSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "ItemType");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<ItemType>> response = client.Execute<SyncModel<ItemType>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {
                IList<ItemType> item = response.Data.value;
                var missingRecords = item.Where(x => !_context.Item.Any(y => y.Code == x.Code)).ToList();
                _context.ItemType.AddRange(missingRecords);
                _context.SaveChanges();
                return true;
            }
            else
                return false;
        }
        public bool ItemSync()
        {
            bool IsItemSyncIsInProcess = false;
            _cache.TryGetValue("IsItemSyncIsInProcess", out IsItemSyncIsInProcess);
            if (!IsItemSyncIsInProcess)
            {
                try
                {
                    Config config = ConfigJSON.Read();
                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=1000&$filter=Update_No gt " + services.LastUpdateNumber;
                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavItem>> response = client.Execute<SyncModel<NavItem>>(request);


                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        List<Item> item = _mapper.Map<List<Item>>(response.Data.value);
                        _context.Item.RemoveRange(_context.Item.Where(x => item.Any(y => y.Code == x.Code)));
                        _context.SaveChanges();
                        _context.Item.AddRange(item);

                        ////using new extension
                        //_context.Item.AddOrUpdate(ref item, x => new { x.Code });
                        _context.SaveChanges();
                        //update update number
                        if (response.Data.value.Count() > 0)
                        {
                            services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                            services.LastSyncDate = DateTime.Now;
                        }
                        _context.SaveChanges();

                        if (response.Data.value.Count() > 0 && response.Data.value.Count() < 1000)
                        {
                            //update cache
                            _cache.Set("IsItemCacheInProcess", false);
                            _cache.Remove("ItemViewModel");
                            BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());
                        }

                        if (response.Data.value.Count() >= 1000)
                            return ItemSync();

                        //also sync itemfoc
                        // ItemFOCSync();
                        _cache.Set("IsItemSyncIsInProcess", false);
                        return true;
                    }
                    else
                    {
                        _cache.Set("IsItemSyncIsInProcess", false);
                        return false;
                    }
                }
                catch (Exception ex)
                {
                    return ItemSync();
                }
            }
            else
                return true;

        }
        public bool CustomerSync()
        {
            bool IsCustomerSyncIsInProcess = false;
            _cache.TryGetValue("IsCustomerSyncIsInProcess", out IsCustomerSyncIsInProcess);
            if (!IsCustomerSyncIsInProcess)
            {
                try
                {
                    Config config = ConfigJSON.Read();
                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Customer");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=100&$filter=Update_No gt " + services.LastUpdateNumber;

                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavCustomer>> response = client.Execute<SyncModel<NavCustomer>>(request);


                    if (response.StatusCode == HttpStatusCode.OK)
                    {

                        List<Customer> item = _mapper.Map<List<Customer>>(response.Data.value);
                        var customerIds = item.Select(x => x.Membership_Number);
                       
                        _context.Customer.RemoveRange(_context.Customer.Where(x => customerIds.Contains(x.Barcode)));
                        _context.SaveChanges();
                        _context.Customer.AddRange(item);

                        _context.SaveChanges();
                        //update update number
                        if (response.Data.value.Count() > 0)
                        {
                            services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                            services.LastSyncDate = DateTime.Now;
                        }
                        _context.SaveChanges();

                        if (response.Data.value.Count() > 0 && response.Data.value.Count() < 100)
                        {
                            //update cache
                            _cache.Set("IsCustomerCacheInProcess", true);
                            BackgroundJob.Enqueue(() => UpdateCacheCustomer());
                        }

                        if (response.Data.value.Count() >= 100)
                            return CustomerSync();

                        _cache.Set("IsCustomerSyncIsInProcess", false);
                        return true;

                    }
                    else
                    {
                        _cache.Set("IsCustomerSyncIsInProcess", false);
                        return false;
                    }
                }
                catch (Exception ex)
                {
                    return CustomerSync();
                }
            }
            else
            {
                return true;
            }


        }
        public bool ItemBarCodeSync()
        {
            bool IsItemBarCodeSyncIsInProcess = false;
            _cache.TryGetValue("IsItemBarCodeSyncIsInProcess", out IsItemBarCodeSyncIsInProcess);
            if (!IsItemBarCodeSyncIsInProcess)
            {
                try
                {
                    _cache.Set("IsItemBarCodeSyncIsInProcess", true);
                    Config config = ConfigJSON.Read();
                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Barcode");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=1000&$filter=Update_No gt " + services.LastUpdateNumber;
                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavBarCode>> response = client.Execute<SyncModel<NavBarCode>>(request);


                    if (response.StatusCode == HttpStatusCode.OK)
                    {

                        List<ItemBarCode> item = _mapper.Map<List<ItemBarCode>>(response.Data.value).ToList();
                        if (item.Count() > 0)
                        {
                            var ids = item.Select(x => x.BarCode).ToArray();
                            var idsStr = String.Join("','", ids);
                            string sql = "delete from ITEM_BARCODE where barcode in ('" + idsStr + "')";
                            using (var tran = _context.Database.BeginTransaction())
                            {
                                var a = _context.Database.ExecuteSqlCommand(sql);
                                tran.Commit();
                            }
                            ItemBarCode itemBarcode = new ItemBarCode();
                            _context.Entry(itemBarcode).State = EntityState.Detached;
                            var d = item.GroupBy(a => a.BarCode).Where(grp => grp.Count() > 1).Select(grp => grp.Key).Select(a => a);
                            List<string> lstBarcode = new List<string>();
                            foreach (var i in item)
                            {
                                _context.Entry(i).State = EntityState.Detached;
                                if (!lstBarcode.Contains(i.BarCode))
                                {
                                    lstBarcode.Add(i.BarCode);
                                    _context.ItemBarCode.Add(i);
                                }
                            }
                            // _context.ItemBarCode.AddRange(item);
                            _context.SaveChanges();
                        }

                        //foreach (var i in response.Data.value)
                        //{
                        //    try
                        //    {
                        //        _context.Entry(_mapper.Map<ItemBarCode>(i)).State = EntityState.Unchanged;
                        //        services.LastUpdateNumber = i.Update_No;
                        //        services.LastSyncDate = DateTime.Now;
                        //        _context.SaveChanges();


                        //        _context.ItemBarCode.Add(_mapper.Map<ItemBarCode>(i));
                        //        _context.SaveChanges();

                        //    }
                        //    catch(Exception ex)
                        //    {

                        //    }
                        //}
                        //foreach(var t in item)
                        //{
                        //    try
                        //    {
                        //        _context.ItemBarCode.Add(t);
                        //    }
                        //    catch { }
                        //}

                        //_context.SaveChanges();
                        ////update update number
                        if (response.Data.value.Count() > 0)
                        {
                            services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                            services.LastSyncDate = DateTime.Now;


                        }
                        _context.SaveChanges();
                        //update cache
                        // List<string> itemCodes = item.Select(x => x.ItemCode).ToList();
                        BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());
                        if (response.Data.value.Count() >= 1000)
                        {
                            _cache.Set("IsItemBarCodeSyncIsInProcess", false);
                            return ItemBarCodeSync();
                        }

                        _cache.Set("IsItemBarCodeSyncIsInProcess", false);
                        return true;

                    }
                    else
                    {
                        _cache.Set("IsItemBarCodeSyncIsInProcess", false);
                        return false;
                    }
                }
                catch (Exception ex)
                {
                    _cache.Set("IsItemBarCodeSyncIsInProcess", false);
                    return ItemBarCodeSync();
                }
            }
            else
                return true;


        }
        public bool ItemPriceSync()
        {
            bool IsItemPriceSyncIsInProcess = false;
            _cache.TryGetValue("IsItemPriceSyncIsInProcess", out IsItemPriceSyncIsInProcess);
            if (!IsItemPriceSyncIsInProcess)
            {
                try
                {
                    Config config = ConfigJSON.Read();
                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item Price");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=1000&$filter=Update_No gt " + services.LastUpdateNumber;
                    url += " and Available_for_Import eq true";
                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavItemPrice>> response = client.Execute<SyncModel<NavItemPrice>>(request);


                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        List<ItemPrice> item = _mapper.Map<List<ItemPrice>>(response.Data.value);
                        _context.ItemPrice.RemoveRange(_context.ItemPrice.Where(x => item.Any(y => y.Id == x.Id)));
                        _context.SaveChanges();

                        _context.ItemPrice.AddRange(item);
                        _context.SaveChanges();
                        //update update number
                        if (response.Data.value.Count() > 0)
                        {
                            services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                            services.LastSyncDate = DateTime.Now;


                        }
                        _context.SaveChanges();
                        if (response.Data.value.Count() > 0 && response.Data.value.Count() < 1000)
                        {
                            //update cache
                            _cache.Set("IsItemCacheInProcess", false);
                            BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());
                        }

                        if (response.Data.value.Count() >= 1000)
                            return ItemPriceSync();


                        _cache.Set("IsItemPriceSyncIsInProcess", false);
                        return true;

                    }
                    else
                    {
                        _cache.Set("IsItemPriceSyncIsInProcess", false);
                        return false;
                    }
                }
                catch
                {
                    return ItemPriceSync();
                }
            }
            else
                return true;


        }
        public bool ItemDiscountSync()
        {
            try
            {
                Config config = ConfigJSON.Read();
                NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "ItemDiscount");
                string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                //access update number data only
                url += "?$top=1000&$filter=Update_No gt " + services.LastUpdateNumber;
                url += " and Available_for_Import eq true";
                url += $" and (Location_Code eq '' or Location_Code eq '{config.Location}')";
                var client = NAV.NAVClient(url, config);
                var request = new RestRequest(Method.GET);

                // IRestResponse response = client.Execute(request);
                IRestResponse<SyncModel<NavItemDiscount>> response = client.Execute<SyncModel<NavItemDiscount>>(request);


                if (response.StatusCode == HttpStatusCode.OK)
                {

                    List<ItemDiscount> item = _mapper.Map<List<ItemDiscount>>(response.Data.value);
                    _context.ItemDiscount.RemoveRange(_context.ItemDiscount.Where(x => item.Any(y => y.Id == x.Id)));
                    _context.SaveChanges();

                    _context.ItemDiscount.AddRange(item);
                    //update update number
                    _context.SaveChanges();
                    if (response.Data.value.Count() > 0)
                    {
                        services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                        services.LastSyncDate = DateTime.Now;
                    }
                    _context.SaveChanges();

                    if (response.Data.value.Count() > 0 && response.Data.value.Count() < 1000)
                    {
                        //update cache
                        _cache.Set("IsItemCacheInProcess", false);
                        BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());
                    }

                    if (response.Data.value.Count() >= 1000)
                        return ItemDiscountSync();
                    return true;
                }
                else
                    return false;
            }
            catch
            {
                return ItemDiscountSync();
            }

        }
        public bool TerminalSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Terminal");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            url += " and Location_Code eq '" + config.Location + "'";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavTerminal>> response = client.Execute<SyncModel<NavTerminal>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                List<Terminal> item = _mapper.Map<List<Terminal>>(response.Data.value);
                _context.Terminal.RemoveRange(_context.Terminal.Where(x => item.Any(y => y.Initial == x.Initial)));
                _context.SaveChanges();

                _context.Terminal.AddRange(item);

                //update update number
                if (response.Data.value.Count() > 0)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                }
                _context.SaveChanges();
                return true;

            }
            else
                return false;

        }
        public bool UserSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "User");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            url += " and Default_Location_Code eq '" + config.Location + "'";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavUser>> response = client.Execute<SyncModel<NavUser>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {
                foreach (var ur in response.Data.value)
                {
                    ur.User_ID = ur.User_ID.Substring(ur.User_ID.IndexOf("\\") + 1);
                    var user = new ApplicationUser { UserName = ur.User_ID, Email = ur.User_ID + "@saleways.com" };
                    var checkUserExist = _userManager.FindByNameAsync(ur.User_ID);
                    if (checkUserExist.Result == null)
                    {
                        var task = _userManager.CreateAsync(user, "1234");
                        var result = task.Result;
                        if (result.Succeeded)
                        {
                            //update update number
                            if (response.Data.value.Count() > 0)
                            {
                                services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                                services.LastSyncDate = DateTime.Now;
                            }

                        }
                    }
                    IdentityUser user1 = _userManager.FindByNameAsync(ur.User_ID).Result;
                    if (user1 != null && !string.IsNullOrEmpty(ur.Role_ID))
                    {
                        var roles = _userManager.GetRolesAsync(user1).Result;
                        var userRoles = _userManager.RemoveFromRolesAsync(user1, roles.ToArray());
                        userRoles.Wait();
                        var userNewRoles = _userManager.AddToRoleAsync(user1, ur.Role_ID);
                        userNewRoles.Wait();

                    }

                }
                _context.SaveChanges();
                return true;

            }
            else
                return false;

        }
        public bool RoleSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Role");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavRole>> response = client.Execute<SyncModel<NavRole>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {
                // _roleManager.Create(new IdentityRole("Administrator"));
                //List<AspNetRoles> item = _mapper.Map<List<AspNetRoles>>(response.Data.value);
                //_context.AspNetRole.RemoveRange(_context.AspNetRole.Where(x => item.Any(y => y.Id == x.Id)));
                //_context.SaveChanges();
                //_context.AspNetRole.AddRange(item);


                foreach (var ro in response.Data.value)
                {
                    var roleCheck = _roleManager.RoleExistsAsync(ro.Name);
                    if (!roleCheck.Result)
                    {
                        //create the roles and seed them to the database
                        var roleCreate = _roleManager.CreateAsync(new IdentityRole(ro.Name));
                        var result = roleCreate.Result;
                    }


                    RoleWisePermission permission = _mapper.Map<RoleWisePermission>(ro);
                    _context.RoleWisePermission.RemoveRange(_context.RoleWisePermission.Where(x => x.RoleId == ro.Name));
                    permission.RoleId = ro.Name;
                    _context.RoleWisePermission.Add(permission);

                }
                //update update number
                if (response.Data.value.Count() > 0)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                }
                _context.SaveChanges();
                return true;

            }
            else
                return false;

        }
        public bool MenuSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Menu");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavMenu>> response = client.Execute<SyncModel<NavMenu>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {
                List<Menu> item = _mapper.Map<List<Menu>>(response.Data.value);
                _context.Menu.RemoveRange(_context.Menu.Where(x => item.Any(y => y.Id == x.Id)));
                _context.SaveChanges();
                _context.Menu.AddRange(item);


                //update update number
                if (response.Data.value.Count() > 0)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                }
                _context.SaveChanges();
                return true;
            }
            else
                return false;
        }
        public bool MenuPermissionSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "RolewiseMenu");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavMenuPermission>> response = client.Execute<SyncModel<NavMenuPermission>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {
                List<RoleWiseMenuPermission> item = _mapper.Map<List<RoleWiseMenuPermission>>(response.Data.value);
                _context.RoleWiseMenuPermission.RemoveRange(_context.RoleWiseMenuPermission.Where(x => item.Any(y => y.RoleId == x.RoleId)));
                _context.SaveChanges();
                _context.RoleWiseMenuPermission.AddRange(item);


                //update update number
                if (response.Data.value.Count() > 0)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                }
                _context.SaveChanges();
                return true;
            }
            else
                return false;
        }
        public bool ItemFOCSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "ItemFOC");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            //url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavItemFOC>> response = client.Execute<SyncModel<NavItemFOC>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {
                List<ItemFOC> item = _mapper.Map<List<ItemFOC>>(response.Data.value);
                _context.ItemFOC.RemoveRange(_context.ItemFOC.Where(x => item.Any(y => y.ItemForFOC == x.ItemForFOC)));
                _context.SaveChanges();
                _context.ItemFOC.AddRange(item);


                //update update number
                if (response.Data.value.Count() > 0)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                }
                _context.SaveChanges();
                return true;
            }
            else
                return false;
        }


        //public void SyncSetup<T>(string type, Type model) where T : new()
        //{
        //    try
        //    {
        //        Config config = ConfigJSON.Read();
        //        PostIntegrationService services = _context.PostIntegrationService.FirstOrDefault(x => x.IntegrationType == type);
        //        string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
        //        var client = NAV.NAVClient(url, config);
        //        var request = new RestRequest(Method.GET);


        //        // IRestResponse response = client.Execute(request);
        //        IRestResponse<SyncModel<T>> response = client.Execute<SyncModel<T>>(request);


        //        if (response.StatusCode == HttpStatusCode.OK)
        //        {
        //            var employee = Activator.CreateInstance(model);
        //            T t = employee.GetType();
        //            List<t> item = _mapper.Map<List<employee.GetType()>> (response.Data.value);
        //            _context.Customer.RemoveRange(item.Where(x => _context.Customer.Any(y => y.Code == x.Code)));
        //            _context.SaveChanges();
        //            _context.Customer.AddRange(item);
        //            _context.SaveChanges();

        //        }


        //    }
        //    catch (Exception ex)
        //    {
        //        // return false;
        //    }
        //}



        public void DenominationScheduler()
        {

            var allUnPostedSettlement = _context.Settlement.Where(x => x.Status == "Open").ToList();
            allUnPostedSettlement.ForEach(x => x.Status = "Closed");
            _context.SaveChanges();
        }

        public void UpdateCacheItemViewModel()
        {
            bool IsItemCacheInProcess = false;
            IList<ItemViewModel> itemsTotal = new List<ItemViewModel>();
            IList<ItemViewModel> itemsTemp = new List<ItemViewModel>();
            _cache.TryGetValue("IsItemCacheInProcess", out IsItemCacheInProcess);

            if (!IsItemCacheInProcess)
            {
                _cache.Set("IsItemCacheInProcess", true);
                //update cache

                //split data to 1lakh and save to cache
                int count = 10000, skip = 0;
                _context.ChangeTracker.AutoDetectChangesEnabled = false;
                for (; ; )
                {
                    try
                    {
                        itemsTemp = _context.ItemViewModel.AsNoTracking().Skip(skip).Take(count).ToList();
                        if (itemsTemp.Count() == 0 && itemsTotal.Count() > 0)
                        {
                            _cache.Set("ItemViewModel", itemsTotal);
                            break;
                        }

                        itemsTotal = itemsTotal.Concat(itemsTemp).ToList();
                        skip = skip + count;
                    }
                    catch
                    {

                    }
                }

            }


        }
        public void UpdateCacheCustomer()
        {
            bool IsCustomerCacheInProcess = false;
            IList<Customer> itemsTotal = new List<Customer>();
            IList<Customer> itemsTemp = new List<Customer>();
            _cache.TryGetValue("IsCustomerCacheInProcess", out IsCustomerCacheInProcess);

            if (!IsCustomerCacheInProcess)
            {
                _cache.Set("IsCustomerCacheInProcess", true);
                //update cache

                //split data to 1lakh and save to cache
                int count = 100000, skip = 0;
                _context.ChangeTracker.AutoDetectChangesEnabled = false;
                for (; ; )
                {
                    try
                    {
                        itemsTemp = _context.Customer.AsNoTracking().Skip(skip).Take(count).ToList();
                        if (itemsTemp.Count() == 0 && itemsTotal.Count() > 0)
                        {
                            _cache.Set("Customer", itemsTotal);
                            break;
                        }

                        itemsTotal = itemsTotal.Concat(itemsTemp).ToList();
                        skip = skip + count;
                    }
                    catch
                    {

                    }
                }

            }


        }

    }
}

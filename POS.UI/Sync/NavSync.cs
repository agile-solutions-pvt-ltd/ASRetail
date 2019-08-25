using AutoMapper;
using Hangfire;
using Hangfire.Storage;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
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
        private readonly IMapper _mapper;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private IMemoryCache _cache;
        public IConfiguration Configuration { get; }


        public NavSync(EntityCore context, IMapper mapper, UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager, IMemoryCache memoryCache, IConfiguration configuration)
        {
            _context = context;
            _mapper = mapper;
            _userManager = userManager;
            _roleManager = roleManager;
            _cache = memoryCache;
            Configuration = configuration;
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

        public string TestNavConnection()
        {
            Config config = ConfigJSON.Read();
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/poslocations";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            IRestResponse<CompanyApiModel> response = client.Execute<CompanyApiModel>(request);

            if (response.StatusCode == HttpStatusCode.OK)
                return "Success";
            else
                return response.Content;
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
                            _context.Entry(store).State = EntityState.Modified;
                            //update update number
                            if (response.Data.value.Count() > 0)
                            {
                                services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                                services.LastSyncDate = DateTime.Now;
                                _context.Entry(services).State = EntityState.Modified;
                            }
                            _context.SaveChanges();
                        }


                        CompanyVatNumberSync();

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

                    _context.Entry(store).State = EntityState.Modified;
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
                Config config = ConfigJSON.Read();
                try
                {

                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=10&$filter=Update_No gt " + services.LastUpdateNumber;
                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavItem>> response = client.Execute<SyncModel<NavItem>>(request);


                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        List<Item> item = _mapper.Map<List<Item>>(response.Data.value);

                        var listOfItemCodeToRemove = item.Select(x => x.Code).ToList();
                        var listOfItemToRemove = _context.Item.Where(x => listOfItemCodeToRemove.Contains(x.Code));
                        foreach (var i in listOfItemToRemove)
                        {
                            try
                            {
                                _context.Item.Remove(i);
                            }
                            catch
                            {
                                item.Remove(i);
                                _context.Entry(i).State = EntityState.Detached;
                            }
                        }

                        //var listOfItemsToUpdate = _context.Item.Where(x => item.Any(y => y.Code == x.Code));

                        //foreach (var i in listOfItemsToUpdate)
                        //{
                        //    var newItem = item.FirstOrDefault(x => x.Code == i.Code);
                        //    i.Name = newItem.Name;
                        //    i.DiscountGroup = newItem.DiscountGroup;
                        //    i.Bar_Code = newItem.Bar_Code;
                        //    i.Code = newItem.Code;
                        //    i.Discount = newItem.Discount;
                        //    i.Is_Active = newItem.Is_Active;
                        //    i.Is_Discountable = newItem.Is_Discountable;
                        //    i.Is_Vatable = newItem.Is_Vatable;
                        //    i.KeyInWeight = newItem.KeyInWeight;
                        //    i.No_Discount = newItem.No_Discount;
                        //    i.Parent_Code = newItem.Parent_Code;
                        //    i.Rate = newItem.Rate;
                        //    i.Remarks = newItem.Remarks;
                        //    i.Type = newItem.Type;
                        //    i.Unit = newItem.Unit;
                        //    i.VendorNumber = newItem.VendorNumber;
                        //    _context.Entry(i).State = EntityState.Modified;


                        //}
                        //var listOfItemsCodesToUpdate = item.Select(x => x.Code).ToList();
                        //var listOfItemsToAdd = item.Where(x => !listOfItemsCodesToUpdate.Contains(x.Code));
                        //_context.Item.AddRange(listOfItemsToAdd);
                        _context.SaveChanges();
                        //update update number
                        if (response.Data.value.Count() > 0)
                        {
                            //var maxUpdateNuber
                            //NavIntegrationService services1 = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item");
                            services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                            services.LastSyncDate = DateTime.Now;
                            _context.Entry(services).State = EntityState.Modified;
                            _context.SaveChanges();
                            _context.Entry(services).State = EntityState.Detached;
                        }


                        if (response.Data.value.Count() > 0 && response.Data.value.Count() < 10)
                        {
                            config.SyncLog.Item = "Last Sync :" + DateTime.Now.ToShortDateString();
                            ConfigJSON.Write(config);
                            //update cache
                            _cache.Set("IsItemCacheInProcess", false);
                            _cache.Remove("ItemViewModel");
                            BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());
                        }

                        if (response.Data.value.Count() >= 10)
                            return ItemSync();

                        //also sync itemfoc
                        // ItemFOCSync();
                        _cache.Set("IsItemSyncIsInProcess", false);
                        config.SyncLog.Item = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                        ConfigJSON.Write(config);
                        return true;
                    }
                    else
                    {
                        config.SyncLog.Item = "Error :" + response.Content;
                        ConfigJSON.Write(config);
                        _cache.Set("IsItemSyncIsInProcess", false);
                        return false;
                    }
                }
                catch (Exception ex)
                {
                    config.SyncLog.Item = "Error :" + ex.InnerException == null ? ex.Message : ex.InnerException.Message;
                    ConfigJSON.Write(config);
                    return false;
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
                Config config = ConfigJSON.Read();
                try
                {

                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Customer");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=10&$filter=Update_No gt " + services.LastUpdateNumber;

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

                        if (response.Data.value.Count() > 0 && response.Data.value.Count() < 10)
                        {
                            config.SyncLog.Item = "Last Sync :" + DateTime.Now.ToShortDateString();
                            ConfigJSON.Write(config);
                            //update cache
                            _cache.Set("IsCustomerCacheInProcess", true);
                            BackgroundJob.Enqueue(() => UpdateCacheCustomer());
                        }

                        if (response.Data.value.Count() >= 10)
                            return CustomerSync();

                        _cache.Set("IsCustomerSyncIsInProcess", false);
                        config.SyncLog.Customer = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                        ConfigJSON.Write(config);
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
                    config.SyncLog.Customer = "Error :" + ex.InnerException.Message;
                    ConfigJSON.Write(config);
                    return false;
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
                Config config = ConfigJSON.Read();
                try
                {
                    _cache.Set("IsItemBarCodeSyncIsInProcess", true);

                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Barcode");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=10&$filter=Update_No gt " + services.LastUpdateNumber;
                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavBarCode>> response = client.Execute<SyncModel<NavBarCode>>(request);

                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        List<ItemBarCode> item = _mapper.Map<List<ItemBarCode>>(response.Data.value);
                        var listOfItemCodeToRemove = item.Select(x => x.ItemCode).ToList();
                        var listOfItemToRemove = _context.ItemBarCode.Where(x => listOfItemCodeToRemove.Contains(x.ItemCode));
                        foreach (var i in listOfItemToRemove)
                        {
                            try
                            {
                                _context.ItemBarCode.Remove(i);
                            }
                            catch
                            {
                                item.Remove(i);
                                _context.Entry(i).State = EntityState.Detached;
                            }
                        }
                        // _context.ItemPrice.RemoveRange(listOfItemToRemove);
                        _context.SaveChanges();

                        _context.ItemBarCode.AddRange(item);
                        _context.SaveChanges();
                        //update update number
                        if (response.Data.value.Count() > 0)
                        {
                            // var _services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item Price");
                            services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                            services.LastSyncDate = DateTime.Now;
                            _context.Entry(services).State = EntityState.Modified;
                            _context.SaveChanges();
                            _context.Entry(services).State = EntityState.Detached;

                        }

                        if (response.Data.value.Count() > 0 && response.Data.value.Count() < 10)
                        {
                            //update cache
                            _cache.Set("IsItemCacheInProcess", false);
                            BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());
                        }

                        if (response.Data.value.Count() >= 10)
                        {
                            _cache.Set("IsItemBarCodeSyncIsInProcess", false);
                            return ItemBarCodeSync();
                        }


                        _cache.Set("IsItemBarCodeSyncIsInProcess", false);
                        config.SyncLog.ItemBarCode = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                        ConfigJSON.Write(config);
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
                    config.SyncLog.ItemBarCode = "Error :" + ex.InnerException.Message;
                    _cache.Set("IsItemBarCodeSyncIsInProcess", false);
                    ConfigJSON.Write(config);
                    return false;
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

                    _cache.Set("IsItemPriceSyncIsInProcess", true);
                    Config config = ConfigJSON.Read();
                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item Price");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=10&$filter=Update_No gt " + services.LastUpdateNumber;
                    //url += " and Available_for_Import eq true";
                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavItemPrice>> response = client.Execute<SyncModel<NavItemPrice>>(request);


                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        List<ItemPrice> item = _mapper.Map<List<ItemPrice>>(response.Data.value);
                        var listOfItemCodeToRemove = item.Select(x => x.ItemCode).ToList();
                        var listOfItemToRemove = _context.ItemPrice.Where(x => listOfItemCodeToRemove.Contains(x.ItemCode));
                        foreach(var i in listOfItemToRemove)
                        {
                            try
                            {
                                _context.ItemPrice.Remove(i);
                            }
                            catch {
                                item.Remove(i);
                                _context.Entry(i).State = EntityState.Detached;
                            }
                        }
                       // _context.ItemPrice.RemoveRange(listOfItemToRemove);
                        _context.SaveChanges();

                        _context.ItemPrice.AddRange(item);
                        _context.SaveChanges();
                        //update update number
                        if (response.Data.value.Count() > 0)
                        {
                           // var _services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item Price");
                            services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                            services.LastSyncDate = DateTime.Now;
                            _context.Entry(services).State = EntityState.Modified;
                            _context.SaveChanges();
                            _context.Entry(services).State = EntityState.Detached;

                        }
                       
                        if (response.Data.value.Count() > 0 && response.Data.value.Count() < 10)
                        {
                            //update cache
                            _cache.Set("IsItemCacheInProcess", false);
                            BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());
                        }

                        if (response.Data.value.Count() >= 10)
                        {
                            _cache.Set("IsItemPriceSyncIsInProcess", false);
                            return ItemPriceSync();
                        }


                        _cache.Set("IsItemPriceSyncIsInProcess", false);
                        config.SyncLog.ItemPrice = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                        ConfigJSON.Write(config);
                        return true;

                    }
                    else
                    {
                        _cache.Set("IsItemPriceSyncIsInProcess", false);
                        return false;
                    }
                }
                catch(Exception ex)
                {
                    _cache.Set("IsItemPriceSyncIsInProcess", false);
                    return false;
                }
            }
            else
                return true;


        }
        public bool ItemDiscountSync()
        {
            bool IsItemDiscountSyncIsInProcess = false;
            _cache.TryGetValue("IsItemDiscountSyncIsInProcess", out IsItemDiscountSyncIsInProcess);
            if (!IsItemDiscountSyncIsInProcess)
            {
                try
                {
                    _cache.Set("IsItemPriceSyncIsInProcess", true);
                    Config config = ConfigJSON.Read();
                    NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "ItemDiscount");
                    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    //access update number data only
                    url += "?$top=10&$filter=Update_No gt " + services.LastUpdateNumber;
                    //url += " and Available_for_Import eq true";
                    url += $" and (Location_Code eq '' or Location_Code eq '{config.Location}')";
                    var client = NAV.NAVClient(url, config);
                    var request = new RestRequest(Method.GET);

                    // IRestResponse response = client.Execute(request);
                    IRestResponse<SyncModel<NavItemDiscount>> response = client.Execute<SyncModel<NavItemDiscount>>(request);


                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        List<ItemDiscount> item = _mapper.Map<List<ItemDiscount>>(response.Data.value);
                        var listOfItemCodeToRemove = item.Select(x => x.ItemCode).ToList();
                        var listOfItemToRemove = _context.ItemDiscount.Where(x => listOfItemCodeToRemove.Contains(x.ItemCode));
                        foreach (var i in listOfItemToRemove)
                        {
                            try
                            {
                                _context.ItemDiscount.Remove(i);
                            }
                            catch
                            {
                                item.Remove(i);
                                _context.Entry(i).State = EntityState.Detached;
                            }
                        }
                        // _context.ItemPrice.RemoveRange(listOfItemToRemove);
                        _context.SaveChanges();

                        _context.ItemDiscount.AddRange(item);
                        _context.SaveChanges();
                        //update update number
                        if (response.Data.value.Count() > 0)
                        {
                            // var _services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item Price");
                            services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                            services.LastSyncDate = DateTime.Now;
                            _context.Entry(services).State = EntityState.Modified;
                            _context.SaveChanges();
                            _context.Entry(services).State = EntityState.Detached;

                        }

                        if (response.Data.value.Count() > 0 && response.Data.value.Count() < 10)
                        {
                            //update cache
                            _cache.Set("IsItemCacheInProcess", false);
                            BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());
                        }

                        if (response.Data.value.Count() >= 10)
                        {
                            _cache.Set("IsItemDiscountSyncIsInProcess", false);
                            return ItemDiscountSync();
                        }


                        _cache.Set("IsItemDiscountSyncIsInProcess", false);
                        config.SyncLog.ItemDiscount = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                        ConfigJSON.Write(config);
                        return true;

                    }
                    else
                    {
                        _cache.Set("IsItemDiscountSyncIsInProcess", false);
                        return false;
                    }
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
            else
            {
                return true;
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
                var listOfItemCodeToRemove = item.Select(x => x.Initial).ToList();
                var listOfItemToRemove = _context.Terminal.Where(x => listOfItemCodeToRemove.Contains(x.Initial));
                _context.Terminal.RemoveRange(listOfItemToRemove);
                _context.SaveChanges();

                _context.Terminal.AddRange(item);
                _context.SaveChanges();
                //update update number
                if (response.Data.value.Count() > 0)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                    _context.SaveChanges();
                    _context.Entry(services).State = EntityState.Detached;
                }
                config.SyncLog.Terminal = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                ConfigJSON.Write(config);
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
                bool isError = false;
                foreach (var ur in response.Data.value)
                {
                    try
                    {
                        _context.Database.OpenConnection();
                        ur.User_ID = ur.User_ID.Substring(ur.User_ID.IndexOf("\\") + 1);
                        var user = new ApplicationUser { UserName = ur.User_ID, Email = ur.User_ID + "@saleways.com" };
                        var checkUser = _userManager.FindByNameAsync(ur.User_ID).Result;
                        if (checkUser == null)
                        {
                            var task = _userManager.CreateAsync(user, "1234");
                            var result = task.Result;
                            if (result.Succeeded)
                            {
                                //continue

                            }
                        }
                        if (checkUser == null)
                            checkUser = _userManager.FindByNameAsync(ur.User_ID).Result;
                        if (checkUser != null && !string.IsNullOrEmpty(ur.Role_ID))
                        {
                            var roles = _userManager.GetRolesAsync(checkUser).Result;
                            if (roles.Count() > 0)
                            {
                                var userRoles = _userManager.RemoveFromRolesAsync(checkUser, roles.ToArray());
                                userRoles.Wait();

                            }

                            var userNewRoles = _userManager.AddToRoleAsync(checkUser, ur.Role_ID);
                            userNewRoles.Wait();
                            _context.Database.CloseConnection();

                        }
                    }catch(Exception ex)
                    {
                        isError = true;
                        _context.Database.CloseConnection();
                    }
                   
                }
               

                    if (response.Data.value.Count() > 0 && isError == false)
                {
                    services.LastUpdateNumber = response.Data.value.Max(x => x.Update_No);
                    services.LastSyncDate = DateTime.Now;
                    _context.Entry(services).State = EntityState.Modified;
                    _context.SaveChanges();
                    _context.Entry(services).State = EntityState.Detached;
                   
                }
                // _context.SaveChanges();
                config.SyncLog.User = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                ConfigJSON.Write(config);
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
                    _context.Entry(services).State = EntityState.Modified;
                    _context.SaveChanges();
                    _context.Entry(services).State = EntityState.Detached;
                }
                config.SyncLog.UserRole = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                ConfigJSON.Write(config);

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
                    _context.Entry(services).State = EntityState.Modified;
                    _context.SaveChanges();
                    _context.Entry(services).State = EntityState.Detached;
                }

                config.SyncLog.Menu = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                ConfigJSON.Write(config);

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
                    _context.Entry(services).State = EntityState.Modified;
                    _context.SaveChanges();
                    _context.Entry(services).State = EntityState.Detached;
                }
                config.SyncLog.MenuPermission = "Last Sync : " + DateTime.Now.ToString("dd MMM, yyyy hh:mm tt");
                ConfigJSON.Write(config);
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

            _cache.TryGetValue("IsItemCacheInProcess", out IsItemCacheInProcess);

            if(!IsItemCacheInProcess)
            {
                _cache.Set("IsItemCacheInProcess", true);
                //update cache
                Config config = ConfigJSON.Read();
                //split data to 1lakh and save to cache
                int count = 100000, skip = 0, errorCount = 0;
                DateTime startDate = DateTime.Now;
                //_context.ChangeTracker.AutoDetectChangesEnabled = false;
                for (; ; )
                {
                    try
                    {
                        IList<ItemViewModel> itemsTotal = new List<ItemViewModel>();
                        _context.Database.SetCommandTimeout(TimeSpan.FromHours(1));
                        //IList<ItemViewModel> itemsTemp = _context.ItemViewModel.FromSql("SPItemViewModel @p0, @p1", count, skip).ToList();
                        IList<ItemViewModel> itemsTemp = _context.ItemViewModel.Skip(skip).Take(count).ToList();
                        if (itemsTemp.Count() > 0)
                        {
                            _cache.TryGetValue("ItemViewModel", out itemsTotal);
                            if (itemsTotal == null)
                            {
                                itemsTotal = new List<ItemViewModel>();
                            }
                            itemsTotal = itemsTotal.Concat(itemsTemp).ToList();
                            _cache.Set("ItemViewModel", itemsTotal);

                        }
                        else
                        {
                            double totalTimeTake = (DateTime.Now - startDate).TotalMinutes;
                            config.Environment = "Total Time take " + totalTimeTake + " Mins";
                            ConfigJSON.Write(config);
                            break;
                        }
                        config.Environment = itemsTotal.Count() + " item cached";
                        // itemsTotal = itemsTotal.Concat(itemsTemp).ToList();
                        skip = skip + count;
                        // config.Environment = itemsTotal.Count() + " item cached";
                        ConfigJSON.Write(config);

                    }
                    catch (Exception ex)
                    {
                        if (errorCount > 5)
                            break;
                        errorCount += 1;


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
                            _cache.Set("Customers", itemsTotal);
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

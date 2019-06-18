using AutoMapper;
using Hangfire;
using Hangfire.SqlServer;
using Hangfire.Storage;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Nito.AsyncEx;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using RestSharp;
using RestSharp.Authenticators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace POS.UI.Sync
{
    public class NavSync
    {

        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        public NavSync(EntityCore context, IMapper mapper, UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            _context = context;
            _mapper = mapper;
            _userManager = userManager;
            _roleManager = roleManager;
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
        //public bool PostIntegrationServiceSync()
        //{
        //    Config config = ConfigJSON.Read();
        //    string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/posintegrationservices";
        //    var client = NAV.NAVClient(url, config);
        //    var request = new RestRequest(Method.GET);




        //    IRestResponse response = client.Execute(request);
        //    IRestResponse<PostIntegrationApiModel> response = client.Execute<PostIntegrationApiModel>(request);


        //    if (response.StatusCode == HttpStatusCode.OK)
        //    {
        //        _context.NavIntegrationService.AddRange(response.Data.value);
        //        _context.SaveChanges();
        //        return true;
        //    }
        //    else
        //        return false;
        //}

        public bool StoreSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Store");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            url += " and Code eq '" + config.Location + "'";
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
                return true;
            }
            else
                return false;
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
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
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
        public bool CustomerSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Customer");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavCustomer>> response = client.Execute<SyncModel<NavCustomer>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                List<Customer> item = _mapper.Map<List<Customer>>(response.Data.value);
                _context.Customer.RemoveRange(_context.Customer.Where(x => item.Any(y => y.Membership_Number == x.Membership_Number)));
                _context.SaveChanges();
                foreach(var i in item)
                {
                    i.IsNavSync = true;
                    i.NavSyncDate = DateTime.Now;
                    i.Registration_Date = i.Registration_Date.Value.Year == 1 ? DateTime.Now : i.Registration_Date;
                }
                _context.Customer.AddRange(item);
               

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
        public bool ItemBarCodeSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Barcode");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavBarCode>> response = client.Execute<SyncModel<NavBarCode>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                List<ItemBarCode> item = _mapper.Map<List<ItemBarCode>>(response.Data.value);
                _context.ItemBarCode.RemoveRange(_context.ItemBarCode.Where(x => item.Any(y => y.BarCode == x.BarCode)));
                _context.SaveChanges();
                _context.ItemBarCode.AddRange(item);
               
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
        public bool ItemPriceSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Item Price");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavItemPrice>> response = client.Execute<SyncModel<NavItemPrice>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                List<ItemPrice> item = _mapper.Map<List<ItemPrice>>(response.Data.value);
                _context.ItemPrice.RemoveRange(_context.ItemPrice.Where(x => item.Any(y => y.ItemCode == x.ItemCode)));
                _context.SaveChanges();
                foreach (var i in item)
                {
                    i.StartDate = i.StartDate.Value.ToShortDateString() == "01/01/01" ? i.StartDate = null : i.StartDate.Value;
                    i.EndDate = i.EndDate.Value.ToShortDateString() == "01/01/01" ? i.EndDate = null : i.EndDate.Value;
                }
                _context.ItemPrice.AddRange(item);
               
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
        public bool ItemDiscountSync()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "ItemDiscount");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            //access update number data only
            url += "?$filter=Update_No gt " + services.LastUpdateNumber;
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            // IRestResponse response = client.Execute(request);
            IRestResponse<SyncModel<NavItemDiscount>> response = client.Execute<SyncModel<NavItemDiscount>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                List<ItemDiscount> item = _mapper.Map<List<ItemDiscount>>(response.Data.value);
                _context.ItemDiscount.RemoveRange(_context.ItemDiscount.Where(x => item.Any(y => y.ItemCode == x.ItemCode)));
                _context.SaveChanges();
                foreach (var i in item)
                {
                    i.StartDate = i.StartDate.Value.ToShortDateString() == "01/01/01" ? i.StartDate = null : i.StartDate.Value;
                    i.EndDate = i.EndDate.Value.ToShortDateString() == "01/01/01" ? i.EndDate = null : i.EndDate.Value;
                }
                _context.ItemDiscount.AddRange(item);
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
                    var task = _userManager.CreateAsync(user, ur.User_ID + "@123");
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
    }
}

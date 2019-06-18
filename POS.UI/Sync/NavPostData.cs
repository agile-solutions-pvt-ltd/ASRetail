using AutoMapper;
using Hangfire;
using Hangfire.SqlServer;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
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
using System.Threading;
using System.Threading.Tasks;

namespace POS.UI.Sync
{
    public class NavPostData
    {

        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        public NavPostData(EntityCore context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public bool PostSalesInvoice(NavSalesInvoice invoice)
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePost");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");


            request.RequestFormat = DataFormat.Json;
            var temp = JsonConvert.SerializeObject(invoice);
            request.AddJsonBody(temp);

            IRestResponse<SyncModel<NavSalesInvoice>> response = client.Execute<SyncModel<NavSalesInvoice>>(request);
           

            if (response.StatusCode == HttpStatusCode.Created)
            {
                //update sync status
                SalesInvoice sInvoice = _context.SalesInvoice.FirstOrDefault(x => x.Invoice_Number == invoice.number);
                sInvoice.IsNavSync = true;
                sInvoice.NavSyncDate = DateTime.Now;
                _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                _context.SaveChanges();

                //NavSalesInvoice invoiceFromNav = response.Data.value.FirstOrDefault();

                ////save
                //Guid invoiceNumber = new Guid(invoice.number);
                //List<SalesInvoiceItems> items = _context.SalesInvoiceItems.Where(x => x.Invoice_Number == invoice.number).ToList();
                //foreach(var item in items)
                //{
                //    item.InvoiceIdFromNav = invoiceFromNav.id;
                //    _context.Entry(item).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                //}
                //_context.SaveChanges();
                PostSalesInvoiceItem();

                return true;
            }
            else
            {
                ////update values
                //SalesInvoice sInvoice = _context.SalesInvoice.FirstOrDefault(x => x.Invoice_Number == invoice.number);
                //if(sInvoice.SyncErrorCount < 3)
                //{
                //    sInvoice.SyncErrorCount = sInvoice.SyncErrorCount + 1;
                //    _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                //    _context.SaveChanges();
                //    //run scheduler after 1 minute
                //    BackgroundJob.Schedule(() => PostSalesInvoice(invoice), TimeSpan.FromMinutes(sInvoice.SyncErrorCount));
                //}
                
                return false;
            }
        }
        public bool PostTaxInvoice(SalesInvoice invoice)
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "TaxInvoicePost");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");


            request.RequestFormat = DataFormat.Json;
            request.AddJsonBody(invoice);

            IRestResponse response = client.Execute(request);

            if (response.StatusCode == HttpStatusCode.OK)
                return true;
            else
            {
                return false;
            }
        }
        public bool PostCreditNote(CreditNote creditNote)
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "CreditNotePost");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");


            request.RequestFormat = DataFormat.Json;
            request.AddJsonBody(creditNote);

            IRestResponse response = client.Execute(request);

            if (response.StatusCode == HttpStatusCode.OK)
                return true;
            else
            {
                return false;
            }
        }
        public void PostCustomer()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Customer");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");

            List<Customer> customers = _context.Customer.Where(x => x.Is_Member == true && x.IsNavSync == false).ToList();
            var navCustomers = _mapper.Map<List<NavCustomer>>(customers);
            request.RequestFormat = DataFormat.Json;

            foreach (var cus in navCustomers)
            {
                var settings = new JsonSerializerSettings();
                //settings.ContractResolver = new CamelCasePropertyNamesContractResolver();
                settings.NullValueHandling = NullValueHandling.Ignore;
                //you can add multiple settings and then use it
                var obj = JsonConvert.SerializeObject(cus, Formatting.Indented,settings);

                request.AddJsonBody(obj);
                IRestResponse<SyncModel<NavCustomer>> response = client.Execute<SyncModel<NavCustomer>>(request);
                if (response.StatusCode == HttpStatusCode.Created)
                {
                    var updatedCustomer = customers.FirstOrDefault(x => x.Membership_Number == cus.number);
                    updatedCustomer.IsNavSync = true;
                    updatedCustomer.NavSyncDate = DateTime.Now;


                    //update update number
                    var data = JsonConvert.DeserializeObject<NavCustomer>(response.Content);
                    if (data != null)
                    {
                        services.LastUpdateNumber = data.Update_No;
                        services.LastSyncDate = DateTime.Now;
                    }
                    _context.SaveChanges();

                }
            }

            //  request.AddJsonBody(navCustomers);

            ////IRestResponse response = client.Execute(request);
            //IRestResponse<SyncModel<NavCustomer>> response = client.Execute<SyncModel<NavCustomer>>(request);

            //if (response.StatusCode == HttpStatusCode.OK)
            //{
            //    List<Customer> navCustomer = _mapper.Map<List<Customer>>(response.Data.value);
            //    List<int?> memberIds = navCustomer.Select(x => x.Member_Id).ToList();
            //    var updatedCustomer = customers.Where(x => memberIds.Contains(x.Member_Id)).ToList();
            //    updatedCustomer.ForEach(x => { x.IsNavSync = true; x.NavSyncDate = DateTime.Now; });

            //    _context.SaveChanges();
            //    return true;
            //}
            //else
            //    return false;

        }

        public bool PostSalesInvoiceItem()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePost");
            NavIntegrationService serviceforSalesInvoiceItem = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePostItem");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";

            var allUnSyncItemList = _context.SalesInvoiceItems.Where(x => x.IsNavSync == false).Select(x=>x.Id).Distinct();
            //var itemList = _context.SalesInvoiceItems.Where(x=> all)
            foreach(var itemList in allUnSyncItemList)
            {
                var items = _context.SalesInvoiceItems.Where(x => x.Id == itemList);
               
                
                foreach(var item in items)
                {
                    NavSalesItems navSalesItem = new NavSalesItems()
                    {
                       
                        itemId = item.ItemId,                        
                        unitPrice = item.Rate.Value,
                        quantity = item.Quantity.Value,
                        discountAmount = item.Discount.Value,                       
                        totalTaxAmount = item.Tax.Value
                    };


                    var newUrl = url + $"({items.FirstOrDefault().Invoice_Id.ToString()})/{serviceforSalesInvoiceItem.ServiceName}";

                    var client = NAV.NAVClient(newUrl, config);
                    var request = new RestRequest(Method.POST);

                    request.AddHeader("Content-Type", "application/json");


                    request.RequestFormat = DataFormat.Json;
                    var temp = JsonConvert.SerializeObject(navSalesItem);
                    request.AddJsonBody(JsonConvert.SerializeObject(navSalesItem));

                    IRestResponse response = client.Execute(request);

                    if (response.StatusCode == HttpStatusCode.Created)
                    {
                        //update sync status
                        item.IsNavSync = true;
                        item.NavSyncDate = DateTime.Now;
                        _context.Entry(item).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                        _context.SaveChanges();
                        
                    }


                }
                //if(items.Where(x=>x.IsNavSync == false).Count() == 0)
                //{
                //    PostSalesInvoiceCompletedSignalToNav(items.FirstOrDefault());
                //}
              
            }

            return true;
           
            
        }


        public void PostSalesInvoiceCompletedSignalToNav(SalesInvoiceItems item)
        {
            Config config = ConfigJSON.Read();
            var url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/salesInvoices";
            var newUrl = url + $"({item.Invoice_Id.ToString()})/Microsoft.NAV.Post";
            var client = NAV.NAVClient(newUrl, config);
            var request = new RestRequest(Method.OPTIONS);

            request.AddHeader("Content-Type", "application/json");

            IRestResponse response = client.Execute(request);

           

        }
    }
}

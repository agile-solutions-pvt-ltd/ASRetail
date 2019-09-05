using AutoMapper;
using Hangfire;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;

namespace POS.UI.Sync
{
    public class NavPostData
    {

        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        // private readonly ILogger _logger;
        public NavPostData(EntityCore context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            //_logger = logger;
        }

        [AutomaticRetry(Attempts = 0)]
        public bool PostSalesInvoice(NavSalesInvoice invoice)
        {
            Config config = ConfigJSON.Read();
            var currentTime = DateTime.Now.TimeOfDay;
            if ((config.OfficeHourStart != null && currentTime.CompareTo(Convert.ToDateTime(config.OfficeHourStart).TimeOfDay) == 1)
               && (config.OfficeHourEnd != null && currentTime.CompareTo(Convert.ToDateTime(config.OfficeHourEnd).TimeOfDay) == -1))
                return true;
            if (config.StopInvoicePosting == false)
            {
                NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePost");
                string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                var client = NAV.NAVClient(url, config);
                var request = new RestRequest(Method.POST);

                request.AddHeader("Content-Type", "application/json");


                request.RequestFormat = DataFormat.Json;
                var temp = JsonConvert.SerializeObject(invoice);
                request.AddJsonBody(temp);

                IRestResponse<SyncModel<NavSalesInvoice>> response = client.Execute<SyncModel<NavSalesInvoice>>(request);


                if (response.StatusCode == HttpStatusCode.Created || response.StatusCode == HttpStatusCode.OK || response.Content.Contains("already exists"))
                {
                    //update sync status
                    SalesInvoice sInvoice = _context.SalesInvoice.FirstOrDefault(x => x.Invoice_Number == invoice.number);
                    sInvoice.IsNavSync = true;
                    sInvoice.NavSyncDate = DateTime.Now;
                    _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    _context.SaveChanges();

                    PostSalesInvoicePaymentMode(invoice.number, invoice.id);
                    PostSalesInvoiceItem(invoice.number, invoice.id, sInvoice.Trans_Type);

                    return true;
                }
                else
                {
                    string errorMessage = "Error Invoice:: Invoice Number= " + invoice.number + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                    WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                    // _logger.LogError("Error Invoice:: Invoice Number= " + invoice.number + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                    //update values
                    //SalesInvoice sInvoice = _context.SalesInvoice.FirstOrDefault(x => x.Invoice_Number == invoice.number);
                    //if (sInvoice.SyncErrorCount < 3)
                    //{
                    //    sInvoice.SyncErrorCount = sInvoice.SyncErrorCount + 1;
                    //    _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    //    _context.SaveChanges();
                    //    //run scheduler after 1 minute
                    //    // BackgroundJob.Schedule(() => PostSalesInvoice(invoice), TimeSpan.FromMinutes(sInvoice.SyncErrorCount * 5));
                    //}

                    return false;
                }
            }
            else
                return true;
        }
        [AutomaticRetry(Attempts = 0)]
        public bool DeleteSalesOrder()
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePost");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            url += "?$filter=locationcode eq '" + config.Location + "'";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.GET);

            request.AddHeader("Content-Type", "application/json");

            IRestResponse<SyncModel<NavSalesInvoice>> response = client.Execute<SyncModel<NavSalesInvoice>>(request);


            if (response.StatusCode == HttpStatusCode.OK)
            {

                foreach (var sOrder in response.Data.value)
                {
                    //delete first if already exist
                    string urlDelete = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                    urlDelete = urlDelete + "(" + sOrder.id + ")";
                    var clientDelete = NAV.NAVClient(urlDelete, config);
                    var requestDelete = new RestRequest(Method.DELETE);
                    requestDelete.AddHeader("Content-Type", "application/json");
                    IRestResponse responseDelete = clientDelete.Execute(requestDelete);
                }
                return true;
            }
            else
            {


                return false;
            }
        }
        [AutomaticRetry(Attempts = 0)]
        public bool PostSalesInvoice(Store store)
        {
            Config config = ConfigJSON.Read();
            var currentTime = DateTime.Now.TimeOfDay;
            if (config.StopInvoicePosting)
                return true;
            if ((config.OfficeHourStart != null && currentTime.CompareTo(Convert.ToDateTime(config.OfficeHourStart).TimeOfDay) == 1)
                && (config.OfficeHourEnd != null && currentTime.CompareTo(Convert.ToDateTime(config.OfficeHourEnd).TimeOfDay) == -1))
                return true;
            var unSyncInvoice = _context.SalesInvoice.Where(x => x.IsNavSync == false).OrderBy(x => x.Trans_Date_Ad);
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePost");
            int errorCount = 0, successCount = 0;
            foreach (var salesInvoice in unSyncInvoice)
            {

                var crNumber = "";
                var bill = _context.SalesInvoiceBill.FirstOrDefault(x => x.Invoice_Number == salesInvoice.Invoice_Number && x.Trans_Mode == "CreditNote");
                if (bill != null)
                    crNumber = bill.Account;
                else
                    crNumber = salesInvoice.Invoice_Number;

                string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                var client = NAV.NAVClient(url, config);
                var request = new RestRequest(Method.POST);
                //DeleteSalesOrder();
                //delete first if already exist
                string urlDelete = url + "(" + salesInvoice.Id + ")";
                var clientDelete = NAV.NAVClient(urlDelete, config);
                var requestDelete = new RestRequest(Method.DELETE);
                requestDelete.AddHeader("Content-Type", "application/json");
                IRestResponse responseDelete = clientDelete.Execute(requestDelete);


                request.AddHeader("Content-Type", "application/json");

                NavSalesInvoice invoice = new NavSalesInvoice()
                {
                    id = salesInvoice.Id.ToString(),
                    number = salesInvoice.Invoice_Number,
                    externalDocumentNumber = crNumber,
                    postingno = salesInvoice.Invoice_Number,
                    shippingno = salesInvoice.Invoice_Number,
                    orderDate = salesInvoice.Trans_Date_Ad.Value.ToString("yyyy-MM-dd"),
                    customerNumber = salesInvoice.MemberId,
                    customerName = salesInvoice.Customer_Name,
                    vatregistrationnumber = salesInvoice.Customer_Vat,
                    locationcode = store.INITIAL,
                    accountabilitycenter = store.INITIAL,
                    assigneduserid = salesInvoice.Created_By,
                    amountrounded = salesInvoice.Total_Net_Amount != salesInvoice.Total_Payable_Amount


                };

                request.RequestFormat = DataFormat.Json;
                var temp = JsonConvert.SerializeObject(invoice);
                request.AddJsonBody(temp);

                IRestResponse<SyncModel<NavSalesInvoice>> response = client.Execute<SyncModel<NavSalesInvoice>>(request);

                if (response.StatusCode == HttpStatusCode.Created || response.StatusCode == HttpStatusCode.OK)
                {
                    var data = JsonConvert.DeserializeObject<NavSalesInvoice>(response.Content);
                    //update sync status
                    SalesInvoice sInvoice = _context.SalesInvoice.FirstOrDefault(x => x.Invoice_Number == invoice.number);
                    sInvoice.IsNavSync = true;
                    sInvoice.NavSyncDate = DateTime.Now;
                    _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;


                    _context.SaveChanges();
                    PostSalesInvoicePaymentMode(invoice.number, data.id);
                    PostSalesInvoiceItem(invoice.number, data.id, sInvoice.Trans_Type);

                    successCount += 1;
                    config.Environment = "Success " + successCount + " - Error " + errorCount;
                    //_logger.LogInformation("Post Invoice " + invoice.number + " to NAV Successfully   " + DateTime.Now.ToString());
                    ConfigJSON.Write(config);
                    // return true;
                }
                else
                {
                    string errorMessage = "Error Invoice:: Invoice Number= " + invoice.number + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                    WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                    // _logger.LogError("Error Invoice:: Invoice Number= " + invoice.number + " Message= " + response.Content +"  " + DateTime.Now.ToString());
                    ////update values
                    //SalesInvoice sInvoice = _context.SalesInvoice.FirstOrDefault(x => x.Invoice_Number == invoice.number);
                    //if (sInvoice.SyncErrorCount < 3)
                    //{
                    //    sInvoice.SyncErrorCount = sInvoice.SyncErrorCount + 1;
                    //    _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    //    _context.SaveChanges();
                    //    //run scheduler after 1 minute
                    //    BackgroundJob.Schedule(() => PostSalesInvoice(invoice), TimeSpan.FromMinutes(sInvoice.SyncErrorCount * 5));
                    //}
                    errorCount += 1;
                    config.Environment = "Success " + successCount + " - Error " + errorCount;
                    ConfigJSON.Write(config);
                    // return false;

                }
            }
            config.Environment += " Finished";
            ConfigJSON.Write(config);
            return true;
        }
        [AutomaticRetry(Attempts = 0)]
        public bool PostCreditNote(NavCreditMemo creditNote)
        {

            Config config = ConfigJSON.Read();
            if (config.StopCreditNotePosting)
                return true;
            var currentTime = DateTime.Now.TimeOfDay;
            if ((config.OfficeHourStart != null && currentTime.CompareTo(Convert.ToDateTime(config.OfficeHourStart).TimeOfDay) == 1)
               && (config.OfficeHourEnd != null && currentTime.CompareTo(Convert.ToDateTime(config.OfficeHourEnd).TimeOfDay) == -1))
                return true;
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "CreditNotePost");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
            var client = NAV.NAVClient(url, config);
            var request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");


            request.RequestFormat = DataFormat.Json;
            var temp = JsonConvert.SerializeObject(creditNote);
            request.AddJsonBody(temp);

            IRestResponse response = client.Execute(request);

            if (response.StatusCode == HttpStatusCode.Created)
            {
                var data = JsonConvert.DeserializeObject<NavCreditMemo>(response.Content);
                //update sync status
                CreditNote sInvoice = _context.CreditNote.FirstOrDefault(x => x.Credit_Note_Number == creditNote.number);
                sInvoice.IsNavSync = true;
                sInvoice.NavSyncDate = DateTime.Now;
                _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;


                _context.SaveChanges();
                // _logger.LogInformation("Post Credit Note " + creditNote.number + " to NAV Successfully   " + DateTime.Now.ToString());
                PostCreditNoteItem(sInvoice.Credit_Note_Number, data.id);
                return true;
            }
            else
            {
                string errorMessage = "Error Credit Note:: Credit Note= " + creditNote.number + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                // _logger.LogError("Error Credit Note:: Credit Note= " + creditNote.number + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                //update values
                //CreditNote sInvoice = _context.CreditNote.FirstOrDefault(x => x.Credit_Note_Number == creditNote.number);
                //if (sInvoice.SyncErrorCount < 3)
                //{
                //    sInvoice.SyncErrorCount = sInvoice.SyncErrorCount + 1;
                //    _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                //    _context.SaveChanges();
                //    //run scheduler after 1 minute
                //    BackgroundJob.Schedule(() => PostSalesInvoice(invoice), TimeSpan.FromMinutes(sInvoice.SyncErrorCount * 5));
                //}
                return false;
            }
        }
        [AutomaticRetry(Attempts = 0)]
        public bool PostCreditNote(Store store)

        {

            Config config = ConfigJSON.Read();
            if (config.StopCreditNotePosting)
                return true;
            var currentTime = DateTime.Now.TimeOfDay;
            if ((config.OfficeHourStart != null && currentTime.CompareTo(Convert.ToDateTime(config.OfficeHourStart).TimeOfDay) == 1)
               && (config.OfficeHourEnd != null && currentTime.CompareTo(Convert.ToDateTime(config.OfficeHourEnd).TimeOfDay) == -1))
                return true;

            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "CreditNotePost");
            var unSyncInvoice = _context.CreditNote.Where(x => x.IsNavSync == false).OrderBy(x => x.Trans_Date_Ad);
            foreach (var credit in unSyncInvoice)
            {
                string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                var client = NAV.NAVClient(url, config);

                var request = new RestRequest(Method.POST);

                request.AddHeader("Content-Type", "application/json");

                NavCreditMemo creditNote = new NavCreditMemo()
                {
                    id = credit.Id.ToString(),
                    number = credit.Credit_Note_Number,
                    postingno = credit.Credit_Note_Number,
                    creditMemoDate = credit.Trans_Date_Ad.Value.ToString("yyyy-MM-dd"),
                    customerNumber = credit.MemberId,
                    customerName = credit.Customer_Name,
                    vatregistrationnumber = credit.Customer_Vat,
                    locationcode = store.INITIAL,
                    accountabilitycenter = store.INITIAL,
                    assigneduserid = credit.Created_By,
                    externalDocumentNumber = credit.Reference_Number,
                    amountrounded = credit.IsRoundup,
                    returnremarks = credit.Credit_Note

                };
                request.RequestFormat = DataFormat.Json;
                var temp = JsonConvert.SerializeObject(creditNote);
                request.AddJsonBody(temp);

                IRestResponse response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.Created)
                {
                    var data = JsonConvert.DeserializeObject<NavCreditMemo>(response.Content);
                    //update sync status
                    CreditNote sInvoice = _context.CreditNote.FirstOrDefault(x => x.Credit_Note_Number == creditNote.number);
                    sInvoice.IsNavSync = true;
                    sInvoice.NavSyncDate = DateTime.Now;
                    _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;


                    _context.SaveChanges();
                    // _logger.LogInformation("Post Credit Note " + creditNote.number + " to NAV Successfully   " + DateTime.Now.ToString());
                    PostCreditNoteItem(sInvoice.Credit_Note_Number, data.id);
                    //return true;
                }
                else
                {
                    string errorMessage = "Error Credit Note:: Credit Note= " + creditNote.number + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                    WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                    // _logger.LogError("Error Credit Note:: Credit Note= " + creditNote.number + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                    //update values
                    //CreditNote sInvoice = _context.CreditNote.FirstOrDefault(x => x.Credit_Note_Number == creditNote.number);
                    //if (sInvoice.SyncErrorCount < 3)
                    //{
                    //    sInvoice.SyncErrorCount = sInvoice.SyncErrorCount + 1;
                    //    _context.Entry(sInvoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    //    _context.SaveChanges();
                    //    //run scheduler after 1 minute
                    //    BackgroundJob.Schedule(() => PostSalesInvoice(invoice), TimeSpan.FromMinutes(sInvoice.SyncErrorCount * 5));
                    //}
                    //return false;
                }
            }
            return true;
        }
        [AutomaticRetry(Attempts = 1)]
        public void PostCustomer()
        {
            Config config = ConfigJSON.Read();
            if (!config.StopCustomerPosting)
            {
                NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "Customer");
                string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";
                var client = NAV.NAVClient(url, config);


                List<Customer> customers = _context.Customer.Where(x => x.Is_Member == true && x.IsNavSync == false).ToList();
                var navCustomers = _mapper.Map<List<NavCustomerPOST>>(customers);


                foreach (var cus in navCustomers)
                {
                    var settings = new JsonSerializerSettings();
                    //settings.ContractResolver = new CamelCasePropertyNamesContractResolver();
                    settings.NullValueHandling = NullValueHandling.Ignore;
                    //you can add multiple settings and then use it
                    var obj = JsonConvert.SerializeObject(cus, Formatting.Indented, settings);

                    var request = new RestRequest(Method.POST);
                    request.RequestFormat = DataFormat.Json;
                    request.AddHeader("Content-Type", "application/json");
                    request.AddJsonBody(obj);
                    IRestResponse<SyncModel<NavCustomer>> response = client.Execute<SyncModel<NavCustomer>>(request);
                    if (response.StatusCode == HttpStatusCode.Created)
                    {
                        var updatedCustomer = customers.FirstOrDefault(x => x.Membership_Number == cus.number);
                        updatedCustomer.IsNavSync = true;
                        updatedCustomer.NavSyncDate = DateTime.Now;


                        ////update update number
                        //var data = JsonConvert.DeserializeObject<NavCustomer>(response.Content);
                        //if (data != null)
                        //{
                        //    services.LastUpdateNumber = data.Update_No;
                        //    services.LastSyncDate = DateTime.Now;
                        //}
                        _context.SaveChanges();
                        // _logger.LogInformation("Post Customer " + cus.number + " to NAV Successfully   " + DateTime.Now.ToString());

                    }
                    else
                    {
                        if (response.Content.Contains("already exist"))
                        {


                            // update update number
                            var updatedCustomer = customers.FirstOrDefault(x => x.Membership_Number == cus.number);
                            updatedCustomer.IsNavSync = true;
                            updatedCustomer.NavSyncDate = DateTime.Now;

                            _context.SaveChanges();
                            // _logger.LogInformation("Customer already exist No=" + cus.number + " " + DateTime.Now.ToString());
                            continue;
                        }
                        else
                        {
                            string errorMessage = "Error Customer:: Customer No.= " + cus.number + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                            WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                            // _logger.LogError("Error Customer:: Customer No.= " + cus.number + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                        }

                    }
                }
                if (_context.Customer.Where(x => x.Is_Member == true && x.IsNavSync == false).Any())
                {
                    BackgroundJob.Schedule(() => PostCustomer(), TimeSpan.FromMinutes(10));
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
        }
        [AutomaticRetry(Attempts = 0)]
        public bool PostSalesInvoicePaymentMode(string invoiceNumber, string invoiceId)
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePost");
            NavIntegrationService serviceforSalesInvoiceItem = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesPaymentModes");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";

            var invoiceBill = _context.SalesInvoiceBill.Where(x => x.Invoice_Number == invoiceNumber);
            //var itemList = _context.SalesInvoiceItems.Where(x=> all)
            int lineNo = 0;
            foreach (var i in invoiceBill)
            {
                //if credit then no need to call api
                if (i.Trans_Mode == "Credit")
                    return false;
                lineNo += 1;
                NavSalesPaymentMode mode = new NavSalesPaymentMode()
                {
                    lineno = lineNo * 10000,
                    amount = i.Amount,
                    paymenttype = i.Trans_Mode,// == "CreditNote" ? "" : i.Trans_Mode, //for creditNote payment type should be blank
                    locationcode = config.Location,
                    documentno = i.Invoice_Number
                };
                var newUrl = url + $"({invoiceId})/{serviceforSalesInvoiceItem.ServiceName}";

                var client = NAV.NAVClient(newUrl, config);
                var request = new RestRequest(Method.POST);

                request.AddHeader("Content-Type", "application/json");


                request.RequestFormat = DataFormat.Json;
                var temp = JsonConvert.SerializeObject(mode);
                request.AddJsonBody(JsonConvert.SerializeObject(mode));

                IRestResponse response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.Created || response.Content.Contains("already exists"))
                {
                    //update sync status
                    i.IsNavSync = true;
                    i.NavSyncDate = DateTime.Now;
                    _context.Entry(i).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    //_context.SaveChanges();

                }
                else
                {
                    string errorMessage = "Error Invoice Bill, Invoice= " + i.Invoice_Number.ToString() + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                    WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                    //_logger.LogError("Error Invoice Bill, Invoice= " + i.Invoice_Number.ToString() + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                }

            }
            _context.SaveChanges();


            return true;


        }
        [AutomaticRetry(Attempts = 0)]
        public bool PostSalesInvoiceItem(string invoiceNumber, string invoiceId, string transType)
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePost");
            NavIntegrationService serviceforSalesInvoiceItem = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "SalesInvoicePostItem");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";


            var items = _context.SalesInvoiceItems.Where(x => x.Invoice_Number == invoiceNumber);
            foreach (var item in items)
            {

                NavSalesItems navSalesItem = new NavSalesItems()
                {

                    itemId = item.ItemId,
                    itemno = item.ItemCode,
                    quantity = item.Quantity.Value,
                    unitPrice = item.RateExcludeVatWithoutRoundoff,// + item.RateExcludeVat * 13 / 100, //Send rate excluding vat
                    discountPercent = item.DiscountPercent


                };


                var newUrl = url + $"({invoiceId})/{serviceforSalesInvoiceItem.ServiceName}";

                var client = NAV.NAVClient(newUrl, config);
                var request = new RestRequest(Method.POST);

                request.AddHeader("Content-Type", "application/json");


                request.RequestFormat = DataFormat.Json;
                var temp = JsonConvert.SerializeObject(navSalesItem);
                request.AddJsonBody(JsonConvert.SerializeObject(navSalesItem));

                IRestResponse response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.Created || response.Content.Contains("already exists"))
                {
                    //update sync status
                    item.IsNavSync = true;
                    item.NavSyncDate = DateTime.Now;
                    _context.Entry(item).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    //_context.SaveChanges();

                }
                else
                {
                    string errorMessage = "Error Invoice Item, invoice Number= " + items.FirstOrDefault().Invoice_Number.ToString() + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                    WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                    //_logger.LogError("Error Invoice Item, invoice Number= " + items.FirstOrDefault().Invoice_Number.ToString() + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                }

            }
            _context.SaveChanges();

            if (items.Where(x => x.IsNavSync == false).Count() == 0 && _context.SalesInvoiceBill.Where(x => x.Invoice_Number == invoiceNumber && x.IsNavSync == false).Count() == 0)
            {
                var invoiceGuid = Guid.Parse(invoiceId);
                PostSalesInvoiceCompletedSignalToNav(config, invoiceGuid, invoiceNumber);
            }
            //var allUnSyncItemList = _context.SalesInvoiceItems.Where(x => x.IsNavSync == false).Select(x => x.Invoice_Number).Distinct();
            ////var itemList = _context.SalesInvoiceItems.Where(x=> all)
            //foreach (var itemList in allUnSyncItemList)
            //{
            //    var items = _context.SalesInvoiceItems.Where(x => x.Invoice_Number == invoiceNumber);
            //    foreach (var item in items)
            //    {
            //        NavSalesItems navSalesItem = new NavSalesItems()
            //        {

            //            itemId = item.ItemId,
            //            unitPrice = item.Rate.Value,
            //            quantity = item.Quantity.Value,
            //            discountAmount = item.Discount.Value,

            //        };


            //        var newUrl = url + $"({items.FirstOrDefault().Invoice_Id.ToString()})/{serviceforSalesInvoiceItem.ServiceName}";

            //        var client = NAV.NAVClient(newUrl, config);
            //        var request = new RestRequest(Method.POST);

            //        request.AddHeader("Content-Type", "application/json");


            //        request.RequestFormat = DataFormat.Json;
            //        var temp = JsonConvert.SerializeObject(navSalesItem);
            //        request.AddJsonBody(JsonConvert.SerializeObject(navSalesItem));

            //        IRestResponse response = client.Execute(request);

            //        if (response.StatusCode == HttpStatusCode.Created)
            //        {
            //            //update sync status
            //            item.IsNavSync = true;
            //            item.NavSyncDate = DateTime.Now;
            //            _context.Entry(item).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
            //            _context.SaveChanges();

            //        }


            //    }

            //    if (items.Where(x => x.IsNavSync == false).Count() == 0)
            //    {
            //        PostSalesInvoiceCompletedSignalToNav(items.FirstOrDefault());
            //    }
            //}


            return true;


        }
        [AutomaticRetry(Attempts = 0)]
        public bool PostCreditNoteItem(string invoiceNumber, string invoiceId)
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "CreditNotePost");
            NavIntegrationService serviceforSalesInvoiceItem = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "CreditNotePostItem");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";

            var allUnSyncItemList = _context.CreditNoteItem.Where(x => x.Credit_Note_Number == invoiceNumber);
            //var itemList = _context.SalesInvoiceItems.Where(x=> all)
            foreach (var item in allUnSyncItemList)
            {
               // var items = _context.CreditNoteItem.Where(x => x.Credit_Note_Number == itemList);
                NavCreditItems navSalesItem = new NavCreditItems()
                {

                    // itemId = item.it,
                    itemId = item.ItemId,
                    //itemno = item.ItemCode,
                    unitPrice = item.RateExcludeVat,
                    quantity = item.Quantity.Value,
                    discountPercent = item.DiscountPercent
                };


                var newUrl = url + $"({invoiceId})/{serviceforSalesInvoiceItem.ServiceName}";

                var client = NAV.NAVClient(newUrl, config);
                var request = new RestRequest(Method.POST);

                request.AddHeader("Content-Type", "application/json");


                request.RequestFormat = DataFormat.Json;
                var temp = JsonConvert.SerializeObject(navSalesItem);
                request.AddJsonBody(JsonConvert.SerializeObject(navSalesItem));

                IRestResponse response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.Created || response.Content.Contains("already exists"))
                {
                    //update sync status
                    //var updateItem = _context.CreditNoteItem.FirstOrDefault(x=>x.ItemCode == item.ItemCode)
                    item.IsNavSync = true;
                    item.NavSyncDate = DateTime.Now;
                    _context.Entry(item).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                   

                }
                else
                {
                    string errorMessage = "Error Credit Note Item, Credit Note= " + invoiceId + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                    WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                    //_logger.LogError("Error Credit Note Item, Credit Note= " + items.FirstOrDefault().Credit_Note_Number.ToString() + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                }
               
               
            }
            _context.SaveChanges();
            if (allUnSyncItemList.Where(x => x.IsNavSync == false).Count() == 0)
            {
                Guid invoiceGuid = new Guid(invoiceId);
                PostCreditInvoiceCompletedSignalToNav(config, invoiceGuid, invoiceNumber);
            }

            return true;


        }
        [AutomaticRetry(Attempts = 0)]
        public bool PostCreditNoteItem(string invoiceNumber)
        {
            Config config = ConfigJSON.Read();
            NavIntegrationService services = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "CreditNotePost");
            NavIntegrationService serviceforSalesInvoiceItem = _context.NavIntegrationService.FirstOrDefault(x => x.IntegrationType == "CreditNotePostItem");
            string url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/{services.ServiceName}";


            var items = _context.CreditNoteItem.Where(x => x.Credit_Note_Number == invoiceNumber);
            foreach (var item in items)
            {
                NavCreditItems navSalesItem = new NavCreditItems()
                {

                    // itemId = item.it,
                    itemId = item.ItemId,
                    //itemno = item.ItemCode,
                    unitPrice = item.RateExcludeVat,
                    quantity = item.Quantity.Value,
                    discountPercent = item.DiscountPercent
                };


                var newUrl = url + $"({items.FirstOrDefault().Credit_Note_Id.ToString()})/{serviceforSalesInvoiceItem.ServiceName}";

                var client = NAV.NAVClient(newUrl, config);
                var request = new RestRequest(Method.POST);

                request.AddHeader("Content-Type", "application/json");


                request.RequestFormat = DataFormat.Json;
                var temp = JsonConvert.SerializeObject(navSalesItem);
                request.AddJsonBody(JsonConvert.SerializeObject(navSalesItem));

                IRestResponse response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.Created || response.Content.Contains("already exists"))
                {
                    //update sync status
                    item.IsNavSync = true;
                    item.NavSyncDate = DateTime.Now;
                    _context.Entry(item).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    _context.SaveChanges();

                }
                else
                {
                    string errorMessage = "Error Credit Note Item, Credit Note= " + items.FirstOrDefault().Credit_Note_Number.ToString() + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                    WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                    //_logger.LogError("Error Credit Note Item, Credit Note= " + items.FirstOrDefault().Credit_Note_Number.ToString() + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                }


            }
            if (items.Where(x => x.IsNavSync == false).Count() == 0)
            {
                PostCreditInvoiceCompletedSignalToNav(config, items.FirstOrDefault().Credit_Note_Id.Value, items.FirstOrDefault().Credit_Note_Number);
            }




            return true;


        }



        //********* Final POST
        public void PostSalesInvoiceCompletedSignalToNav(Config config, Guid invoiceId, string invoiceNumber)
        {
            var url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/salesOrders";
            var newUrl = url + $"({invoiceId.ToString()})/Microsoft.NAV.Post";
            var client = NAV.NAVClient(newUrl, config);
            var request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");

            IRestResponse response = client.Execute(request);
            if (response.Content == "" || response.Content.Contains("already exists"))
            {
                //posted successfully                
                SalesInvoice _invoice = _context.SalesInvoice.FirstOrDefault(x => x.Invoice_Number == invoiceNumber);
                if (_invoice != null)
                {
                    _invoice.IsNavPosted = true;
                    _context.Entry(_invoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    _context.SaveChanges();
                }
            }
            else
            {
                if (response.Content.Contains("Sorry, we just updated this page. Reopen it"))
                    PostSalesInvoiceCompletedSignalToNav(config, invoiceId, invoiceNumber);
                else
                {
                    string errorMessage = "Error Sale Invoice post, InvoiceId= " + invoiceId + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                    WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);
                    //_logger.LogError("Error Sale Invoice post, InvoiceId= " + invoiceId + " Message= " + response.Content + "  " + DateTime.Now.ToString());
                }
            }



        }
        public void PostCreditInvoiceCompletedSignalToNav(Config config, Guid invoiceId, string invoiceNumber)
        {
            var url = config.NavApiBaseUrl + "/" + config.NavPath + $"/companies({config.NavCompanyId})/salesCreditMemos";
            var newUrl = url + $"({invoiceId.ToString()})/Microsoft.NAV.Cancel";
            var client = NAV.NAVClient(newUrl, config);
            var request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");

            IRestResponse response = client.Execute(request);
            if (response.Content == "")
            {
                //posted successfully                
                CreditNote _invoice = _context.CreditNote.FirstOrDefault(x => x.Credit_Note_Number == invoiceNumber);
                if (_invoice != null)
                {
                    _invoice.IsNavPosted = true;
                    _context.Entry(_invoice).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    _context.SaveChanges();
                }
            }
            else
            {
                string errorMessage = "Error Credit Note post, Credit Note= " + invoiceId + " Message= " + response.Content + "  " + DateTime.Now.ToString() + Environment.NewLine;
                WriteToFile(Path.GetFullPath("logs/"), "NAVSyncLog.log", errorMessage);

                //_logger.LogError("Error Credit Note post, Credit Note= " + invoiceId + " Message= " + response.Content + "  " + DateTime.Now.ToString());
            }


        }





        public static void WriteToFile(string DirectoryPath, string FileName, string Text)
        {
            //Check Whether directory exist or not if not then create it
            if (!Directory.Exists(DirectoryPath))
            {
                Directory.CreateDirectory(DirectoryPath);
            }

            string FilePath = DirectoryPath + "\\" + FileName;
            //Check Whether file exist or not if not then create it new else append on same file
            if (!File.Exists(FilePath))
            {
                File.WriteAllText(FilePath, Text);
            }
            else
            {
                Text = $"{Environment.NewLine}{Text}";
                File.AppendAllText(FilePath, Text);
            }
        }

        [AutomaticRetry(Attempts = 0)]
        public void PostUnSyncInvoie(Store store)
        {
            Config config = ConfigJSON.Read();
            var unSyncInvoice = _context.SalesInvoice.Where(x => x.IsNavPosted == false);
            //update isnavsync to false then restart scheduling job
            bool flag = UpdateIsNavSyncStatus(unSyncInvoice);
            if (flag == false)
                return;

            //delete all generated sales orders from nav
            DeleteSalesOrder();
            PostSalesInvoice(store);
        }

        public bool UpdateIsNavSyncStatus(IEnumerable<SalesInvoice> invoice)
        {
            try
            {
                foreach (var inv in invoice)
                {
                    inv.IsNavSync = false;
                    _context.Entry(inv).State = Microsoft.EntityFrameworkCore.EntityState.Modified;

                }

                //update invoice items
                var unSyncInvoiceNumber = invoice.Select(x => x.Invoice_Number).ToList();
                var unSyncInvoiceItem = _context.SalesInvoiceItems.Where(x => unSyncInvoiceNumber.Contains(x.Invoice_Number));
                var unsyncInvoicePayment = _context.SalesInvoiceBill.Where(x => unSyncInvoiceNumber.Contains(x.Invoice_Number));
                foreach (var item in unSyncInvoiceItem)
                {
                    item.IsNavSync = false;
                    _context.Entry(item).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                }
                foreach (var item in unsyncInvoicePayment)
                {
                    item.IsNavSync = false;
                    _context.Entry(item).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                }
                _context.SaveChanges();
                return true;
            }
#pragma warning disable CS0168 // The variable 'ex' is declared but never used
            catch (Exception ex)
#pragma warning restore CS0168 // The variable 'ex' is declared but never used
            {
                return false;
            }
        }
    }
}

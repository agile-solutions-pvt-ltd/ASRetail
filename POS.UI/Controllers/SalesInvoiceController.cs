using AutoMapper;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using POS.UI.Sync;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI.Controllers
{
    [SessionAuthorized]
    public class SalesInvoiceController : Controller
    {
        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        private IMemoryCache _cache;
        private ILogger _logger;
        public SalesInvoiceController(EntityCore context, IMapper mapper, IMemoryCache memoryCache, ILoggerFactory loggerFactory)
        {
            _context = context;
            _mapper = mapper;
            _cache = memoryCache;
            _logger = loggerFactory.CreateLogger<SalesInvoiceController>();
        }



        [HttpGet]
        public IActionResult Index(Guid? id, string StatusMessage)
        {
            SalesInvoiceTmp tmp;
            var store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
            if (id != null)
            {
                tmp = _context.SalesInvoiceTmp.Include(x => x.SalesInvoiceItems).FirstOrDefault(x => x.Id == id);
                //remove self reference object
                tmp = JsonConvert.DeserializeObject<SalesInvoiceTmp>(
                    JsonConvert.SerializeObject(tmp, Formatting.Indented, new JsonSerializerSettings
                    {
                        ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                    }));
            }
            else
            {

                // var store = _context.Store.FirstOrDefault();

                int invoiceId = 0;
                if (Request.Query["Mode"].ToString() != null && Request.Query["Mode"].ToString() == "tax")
                {
                    invoiceId = _context.SalesInvoice.Where(x => x.Trans_Type == "Tax").Max(x => x.Invoice_Id as int?) ?? 0;
                    // invoiceId = _context.SalesInvoice.Where(x => x.Trans_Type == "Tax").Select(x => x.Invoice_Id).DefaultIfEmpty(0).Max() + 1;
                }
                else
                {
                    invoiceId = _context.SalesInvoice.Where(x => x.Trans_Type == "Sales").Max(x => x.Invoice_Id as int?) ?? 0;
                   // invoiceId = _context.SalesInvoice.Where(x => x.Trans_Type == "Sales").Select(x => x.Invoice_Id).DefaultIfEmpty(0).Max() + 1;
                }
                tmp = new SalesInvoiceTmp()
                {
                    Invoice_Number = "SI-" + invoiceId.ToString("0000") + "-" + store.INITIAL + "-" + store.FISCAL_YEAR
                };
            }
            TempData["StatusMessage"] = StatusMessage;
            ViewData["Store"] = store;

            //for customer
            //display only ismember data later
            //IList<Customer> customers;
            //if (!_cache.TryGetValue("Customer", out customers))
            //{
            //    // Key not in cache, so get data.
            //    customers = _context.Customer.Where(x => x.Is_Member == true).ToList();

            //    _cache.Set("Customer", customers);
            //}
            //ViewData["Customer"] = customers;

            return View(tmp);
        }

        [HttpPost]
        public async Task<IActionResult> Index([FromBody] SalesInvoiceAndCustomerViewModel model)
        {
            SalesInvoiceTmp salesInvoiceTmp = model.SalesInvoice;
            Customer customer = model.Customer;

            if (ModelState.IsValid)
            {
                if (model.SalesInvoice.Trans_Date_Ad.Value.ToShortDateString() != DateTime.Now.ToShortDateString())
                {
                    return StatusCode(400, "Date is not Up-to-Date !!");
                }
                try
                {
                    //if that salesinvoice already exist, than track first
                    SalesInvoiceTmp oldData = new SalesInvoiceTmp();
                    bool isExistOldSalesInvoice = false;
                    if (salesInvoiceTmp.Id != null)
                    {
                        oldData = await _context.SalesInvoiceTmp.FirstOrDefaultAsync(x => x.Id == salesInvoiceTmp.Id);
                        if (oldData != null) isExistOldSalesInvoice = true;
                    }

                    //add membership
                    if (!string.IsNullOrEmpty(customer.Name) && !string.IsNullOrEmpty(customer.Mobile1) && customer.Is_Member == true)
                    {
                        Customer member = AddCustomer(customer);
                        //_context.SaveChanges();
                        salesInvoiceTmp.Customer_Id = member.Code;
                        salesInvoiceTmp.MemberId = member.Membership_Number;
                    }


                    //now processed to new save invoice
                    salesInvoiceTmp.Id = Guid.NewGuid();
                    salesInvoiceTmp.Trans_Time = DateTime.Now.TimeOfDay;
                    salesInvoiceTmp.Division = "Divisioin";
                    salesInvoiceTmp.Terminal = HttpContext.Session.GetString("Terminal");
                    salesInvoiceTmp.Created_Date = DateTime.Now;
                    salesInvoiceTmp.Created_By = User.Identity.Name;



                    _context.Add(salesInvoiceTmp);

                    foreach (var item in salesInvoiceTmp.SalesInvoiceItems)
                    {
                        item.Invoice_Id = salesInvoiceTmp.Id;
                        item.Invoice_Number = salesInvoiceTmp.Invoice_Number;
                        _context.SalesInvoiceItemsTmp.Add(item);
                    }





                    await _context.SaveChangesAsync();

                    //if everything goes right then delete old sales invoice in background
                    if (isExistOldSalesInvoice)
                    {
                        _context.SalesInvoiceTmp.Remove(oldData);
                        _context.SaveChanges();
                    }



                    //for serverside return
                    //if (salesInvoiceTmp.Trans_Type == "Hold")
                    //    return RedirectToAction("Index");
                    //else
                    //    return RedirectToAction("Billing", new { id = salesInvoiceTmp.Id });
                    //for api return
                    if (salesInvoiceTmp.Trans_Type == "Save")
                        return Ok(new { redirectUrl = "" });
                    if (salesInvoiceTmp.Trans_Type == "Hold" || salesInvoiceTmp.Trans_Type == "Save")
                        return Ok(new { redirectUrl = "/SalesInvoice/Landing" });
                    else if (salesInvoiceTmp.Trans_Type == "Tax")
                        return Ok(new { RedirectUrl = "/SalesInvoice/Billing/" + salesInvoiceTmp.Id + "?M=" + salesInvoiceTmp.MemberId + "&Mode=tax" });
                    else
                        return Ok(new { RedirectUrl = "/SalesInvoice/Billing/" + salesInvoiceTmp.Id + "?M=" + salesInvoiceTmp.MemberId });
                }
                catch (Exception ex)
                {
                    return StatusCode(500, ex.InnerException);
                }
            }
            return View(salesInvoiceTmp);
        }


        [HttpGet]
        public IActionResult Landing(string StatusMessage)
        {
            ////display only ismember data later
            //IList<Customer> customers;
            //if (!_cache.TryGetValue("Customer", out customers))
            //{
            //    // Key not in cache, so get data.
            //    customers = _context.Customer.Where(x => x.Is_Member == true).ToList();

            //    _cache.Set("Customer", customers);
            //}
            //ViewData["Customer"] = customers;
            TempData["StatusMessage"] = StatusMessage;

            return View(JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store")));
        }


        [RolewiseAuthorized]
        [HttpGet]
        public IActionResult CrLanding(string StatusMessage)
        {
            TempData["StatusMessage"] = StatusMessage;
            return View(JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store")));
        }

        [HttpPost]
        public async Task<IActionResult> Delete(Guid? id)
        {
            if (id != null)
            {
                SalesInvoiceTmp invoice = await _context.SalesInvoiceTmp.FirstOrDefaultAsync(x => x.Id == id);
                if (invoice != null)
                {
                    _context.SalesInvoiceTmp.Remove(invoice);
                    _context.SaveChanges();
                    return Ok("Delete Successfull !!");
                }
            }
            return NotFound();
        }

        public IActionResult PausedTransactionListPartial()
        {
            var userid = User.Identity.Name;
            var trans = _context.SalesInvoiceTmp.Where(x => x.Trans_Type == "Hold" && x.Created_By == userid).ToList();
            return PartialView("_PausedTransactionListPartial", trans);
        }


        public IActionResult SavedTransactionListPartial()
        {

            var trans = _context.SalesInvoiceTmp.Where(x => x.Trans_Type == "Save").ToList();
            return PartialView("_SavedTransactionListPartial", trans);
        }


        public IActionResult GetItemReferenceData(Guid id, bool getFromDatabase = false)
        {
            //for item Reference Data           
            var item = _context.SalesInvoiceItemsTmp.Where(x => x.Invoice_Id == id).ToList();
            List<string> barCodeList = item.Select(x => x.Bar_Code).ToList();
            barCodeList = barCodeList.Concat(item.Select(x => x.ItemCode)).ToList();
            IList<ItemViewModel> items;
            _cache.TryGetValue("ItemViewModel", out items);
            if (items == null)
            {
                // Key not in cache, so get data.

                items = GetItemsRawDataByBarcodeList(barCodeList).ToList();
                getFromDatabase = true;


            }
            var temp = items.Where(x => barCodeList.Contains(x.Bar_Code));
            if (temp.Count() == 0 && getFromDatabase == false)
                temp = GetItemsRawDataByBarcodeList(barCodeList).Where(x => barCodeList.Contains(x.Bar_Code));

            temp = temp.Where(x => (x.RateStartDate == null || Convert.ToDateTime(x.RateStartDate.Value.ToShortDateString()) <= Convert.ToDateTime(DateTime.Now.ToShortDateString()))
            && (x.RateEndDate == null || Convert.ToDateTime(x.RateEndDate.Value.ToShortDateString()) >= Convert.ToDateTime(DateTime.Now.ToShortDateString()))
            && (x.DiscountStartDate == null || Convert.ToDateTime(x.DiscountStartDate.Value.ToShortDateString()) <= Convert.ToDateTime(DateTime.Now.ToShortDateString()))
            && (x.DiscountEndDate == null || Convert.ToDateTime(x.DiscountEndDate.Value.ToShortDateString()) >= Convert.ToDateTime(DateTime.Now.ToShortDateString())));
            return Ok(temp);
        }

        [HttpGet]
        public IActionResult Billing(Guid id)
        {
            var salesInvoiceTMP = _context.SalesInvoiceTmp.FirstOrDefault(x => x.Id == id);
            ViewBag.SalesInvoiceTemp = salesInvoiceTMP;
            IEnumerable<CustomerViewModel> customers;
            _cache.TryGetValue("Customers", out customers);
            if (customers == null)
            {
                // Key not in cache, so get data.
                customers = _context.Customer
                    .Where(x => x.Membership_Number == salesInvoiceTMP.MemberId)
                    .Select(x => new CustomerViewModel
                    {
                        Address = x.Address,
                        Barcode = x.Barcode,
                        Code = x.Code,
                        CustomerDiscGroup = x.CustomerDiscGroup,
                        CustomerPriceGroup = x.CustomerPriceGroup,
                        Is_Member = x.Is_Member,
                        Is_Sale_Refused = x.Is_Sale_Refused,
                        MembershipDiscGroup = x.MembershipDiscGroup,
                        Membership_Number = x.Membership_Number,
                        Membership_Number_Old = x.Membership_Number_Old,
                        Member_Id = x.Member_Id,
                        Mobile1 = x.Mobile1,
                        Name = x.Name,
                        Type = x.Type,
                        Vat = x.Vat
                    });
            }
            else
                customers = customers.Where(x => x.Membership_Number == salesInvoiceTMP.MemberId);
            ViewData["Customer"] = customers;


            return View();
        }


        [HttpPost]
        public IActionResult Billing([FromBody] SalesInvoiceBillingViewModel model)
        {
            try
            {
                //check if billing is not available
                if (model == null || model.bill.Count() == 0)
                    return NotFound();

                //Check from salesInvoiceTmp table
                SalesInvoiceTmp salesInvoiceTmp = _context.SalesInvoiceTmp.FirstOrDefault(x => x.Id == model.salesInvoiceId);
                if (salesInvoiceTmp == null)
                    return NotFound();


                using (var trans = _context.Database.BeginTransaction())
                {
                    SalesInvoice salesInvoice = new SalesInvoice();
                    try
                    {
                        //get store info
                        Store store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
                        //convert to sales invoice and save


                        //if (_context.ChangeTracker.HasChanges(.Any(x => x.Id == model.salesInvoiceId))
                        //    salesInvoice = _context.SalesInvoice.FirstOrDefault(x => x.Id == model.salesInvoiceId);
                        //else
                        salesInvoice = _mapper.Map<SalesInvoice>(salesInvoiceTmp);
                        salesInvoice.Id = Guid.NewGuid();

                        salesInvoice.Total_Bill_Discount = model.billDiscount;
                        salesInvoice.Total_Payable_Amount = model.totalPayable;
                        salesInvoice.Total_Net_Amount_Roundup = model.totalNetAmountRoundUp;
                        salesInvoice.Tender_Amount = model.tenderAmount;
                        salesInvoice.Change_Amount = model.changeAmount;
                        salesInvoice.Invoice_Id = _context.SalesInvoice.Where(x => x.Trans_Type == salesInvoice.Trans_Type).Select(x => x.Invoice_Id).DefaultIfEmpty(0).Max() + 1;
                        salesInvoice.Invoice_Number = SalesInvoiceNumberFormat(store, salesInvoice.Invoice_Id, salesInvoice.Trans_Type);
                        _context.SalesInvoice.Add(salesInvoice);


                        //get invoice items temp convert to sales invoice item and save them
                        IList<SalesInvoiceItemsTmp> itemtmp = _context.SalesInvoiceItemsTmp.Where(x => x.Invoice_Id == salesInvoiceTmp.Id).ToList();
                        foreach (var item in itemtmp)
                        {
                            item.Invoice = null;
                            SalesInvoiceItems salesItem = _mapper.Map<SalesInvoiceItems>(item);
                            salesItem.Id = 0;
                            salesItem.Invoice_Id = salesInvoice.Id;
                            salesItem.Invoice_Number = salesInvoice.Invoice_Number;
                            _context.SalesInvoiceItems.Add(salesItem);
                        }
                        _context.SaveChanges();

                        //check session
                        Settlement oldSettlement = _context.Settlement.FirstOrDefault(x => x.UserId == salesInvoice.Created_By && x.Status == "Open");
                        string sessionId = oldSettlement != null ? oldSettlement.SessionId : Guid.NewGuid().ToString();
                        string crNumber = salesInvoice.Invoice_Number;
                        //save bill amount information
                        foreach (var item in model.bill)
                        {
                            item.Invoice_Id = salesInvoice.Id;
                            item.Invoice_Number = salesInvoice.Invoice_Number;
                            item.Invoice_Type = salesInvoice.Trans_Type;
                            item.Terminal = HttpContext.Session.GetString("Terminal");
                            if (item.Trans_Mode == "Cash")
                                item.Amount = item.Amount - salesInvoice.Change_Amount;
                            item.IsNavSync = false;


                            _context.SalesInvoiceBill.Add(item);


                            //if credit note amount is used then update credit note table
                            if (item.Trans_Mode == "Credit Note")
                            {
                                CreditNote creditNote = _context.CreditNote.FirstOrDefault(x => x.Credit_Note_Number == item.Account);
                                crNumber = item.Account;
                                if (creditNote != null)
                                {
                                    creditNote.Created_By = User.Identity.Name;
                                    creditNote.Created_Date = DateTime.Now;
                                    creditNote.Remarks = "Claimed";
                                    _context.Entry(creditNote).State = EntityState.Modified;
                                }
                            }


                            //save to settlement table                           
                            decimal totalAmount = 0;
                            if (item.Trans_Mode == "Cash")
                                totalAmount = item.Amount;
                            else
                                totalAmount = item.Amount;

                            Settlement settlement = new Settlement()
                            {
                                SessionId = sessionId,

                                TransactionDate = DateTime.Now,
                                PaymentMode = item.Trans_Mode,
                                Amount = item.Amount,
                                Status = "Open",
                                VerifiedBy = "",
                                VerifiedDate = DateTime.Now,
                                TransactionNumber = salesInvoice.Invoice_Number,
                                Remarks = "",
                                TerminalId = Convert.ToInt32(HttpContext.Session.GetString("TerminalId")),
                                UserId = salesInvoice.Created_By

                            };
                            _context.Settlement.Add(settlement);
                        }

                        //save to print table
                        InvoicePrint print = new InvoicePrint()
                        {
                            InvoiceNumber = salesInvoice.Invoice_Number,
                            Type = salesInvoice.Trans_Type,
                            FirstPrintedDate = DateTime.Now,
                            FirstPrintedBy = User.Identity.Name,
                            PrintCount = 1
                        };
                        _context.InvoicePrint.Add(print);



                        _context.SaveChanges();

                        //if everything seems good, then delete salesInvoiceTmp
                        _context.Remove(salesInvoiceTmp);

                        //total amount excludevat
                        decimal totalRateExcludeVat = 0;
                        foreach (var i in salesInvoice.SalesInvoiceItems)
                        {
                            totalRateExcludeVat += i.RateExcludeVat * i.Quantity.Value;
                        }
                        // salesInvoice.SalesInvoiceItems.Select(x => x.RateExcludeVat).Sum();

                        //save to invoiceMaterialview
                        InvoiceMaterializedView view = new InvoiceMaterializedView()
                        {
                            BillNo = salesInvoice.Invoice_Number,
                            DocumentType = salesInvoice.Trans_Type + " Invoice",
                            FiscalYear = store.FISCAL_YEAR,
                            LocationCode = store.INITIAL,
                            BillDate = salesInvoice.Trans_Date_Ad.Value,
                            PostingTime = salesInvoice.Trans_Time.Value,
                            CustomerCode = salesInvoice.Customer_Id,
                            CustomerName = salesInvoice.Customer_Name,
                            Vatno = salesInvoice.Customer_Vat,
                            Amount = totalRateExcludeVat,
                            Discount = salesInvoice.TOTAL_DISCOUNT_EXC_VAT,
                            TaxableAmount = salesInvoice.TaxableAmount,
                            NonTaxableAmount = salesInvoice.NonTaxableAmount,
                            TaxAmount = salesInvoice.Total_Vat.Value,
                            TotalAmount = salesInvoice.Total_Net_Amount.Value,
                            IsBillActive = true,
                            IsBillPrinted = true,
                            PrintedBy = User.Identity.Name,
                            PrintedTime = DateTime.Now,
                            EnteredBy = salesInvoice.Created_By,
                            SyncStatus = "Not Started",
                            SyncedDate = DateTime.Now,
                            SyncedTime = DateTime.Now.TimeOfDay,
                            SyncWithIrd = false,
                            IsRealTime = false
                        };
                        NavSalesInvoice navSalesInvoice = new NavSalesInvoice()
                        {
                            id = salesInvoice.Id.ToString(),
                            number = salesInvoice.Invoice_Number,
                            postingno = salesInvoice.Invoice_Number,
                            shippingno = salesInvoice.Invoice_Number,
                            orderDate = salesInvoice.Trans_Date_Ad.Value.ToString("yyyy-MM-dd"),
                            customerNumber = salesInvoice.MemberId,
                            customerName = salesInvoice.Customer_Name,
                            vatregistrationnumber = salesInvoice.Customer_Vat,
                            locationcode = store.INITIAL,
                            accountabilitycenter = store.INITIAL,
                            assigneduserid = salesInvoice.Created_By,
                            externalDocumentNumber = crNumber,
                            amountrounded = salesInvoice.Total_Net_Amount != salesInvoice.Total_Payable_Amount

                        };



                        _context.InvoiceMaterializedView.Add(view);
                        _context.SaveChanges();

                        trans.Commit();
                        //*********** background task
                        Config config = ConfigJSON.Read();
                        //Send data to IRD
                        if (!config.StopPostingIRD)
                            BackgroundJob.Enqueue(() => SendDataToIRD(salesInvoice, store));
                        //Send data to NAV

                        if (!config.StopInvoicePosting)
                        {
                            NavPostData navPostData = new NavPostData(_context, _mapper);
                            BackgroundJob.Enqueue(() => navPostData.PostSalesInvoice(navSalesInvoice));
                        }



                        //TempData["StatusMessage"] = "Bill Payment Successfull !!";
                        return Ok(new { StatusMessage = "Bill Payment Successfull !!", InvoiceData = salesInvoice, StoreData = store, BillData = model.bill });
                    }
                    catch (Exception ex)
                    {
                        trans.Rollback();
                        if (ex.Message.Contains("UniqueInvoiceNumber") || ex.InnerException.Message.Contains("UniqueInvoiceNumber"))
                        {
                            _context.Entry(salesInvoice).State = EntityState.Detached;
                            return Billing(model);
                        }
                        else
                            return BadRequest(ex.Message);
                    }
                };


            }
            catch (Exception ex)
            {

                return BadRequest(ex.Message);
            }

        }


        private string SalesInvoiceNumberFormat(Store store, int invoiceNumber, string type)
        {
            if (type == "Sales")
                return "SI-" + invoiceNumber.ToString("0000") + "-" + store.INITIAL + "-" + store.FISCAL_YEAR;
            else if (type == "Tax")
                return "TI-" + invoiceNumber.ToString("0000") + "-" + store.INITIAL + "-" + store.FISCAL_YEAR;
            else return "";

        }


        //add membership
        public Customer AddCustomer(Customer customer)
        {
            try
            {
                customer.Code = Guid.NewGuid().ToString();
                customer.Member_Id = _context.Customer.Where(x => x.Is_Member == true && x.Member_Id != null).Select(x => x.Member_Id).DefaultIfEmpty(0).Max() + 1;
                Store store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
                customer.Membership_Number = store.INITIAL + "-" + Convert.ToInt32(customer.Member_Id).ToString("000000");
                customer.Created_By = User.Identity.Name;
                customer.Registration_Date = DateTime.Now;
                customer.MembershipDiscGroup = "CATEGORY D";
                customer.CustomerPriceGroup = "RSP";
                customer.CustomerDiscGroup = "RSP";
                _context.Add(customer);
                _context.SaveChanges();
                NavPostData navPost = new NavPostData(_context, _mapper);
                BackgroundJob.Enqueue(() => navPost.PostCustomer());
                return customer;

            }
            catch (Exception ex)
            {
                if (ex.InnerException.Message.Contains("idx_unique_member_id"))
                    return AddCustomer(customer);
                else
                    return new Customer();
            }
        }

        //api get salesinvoice
        public IActionResult GetInvoice(string invoiceNumber)
        {
            SalesInvoice tmp = _context.SalesInvoice.Include(x => x.SalesInvoiceItems).FirstOrDefault(x => x.Invoice_Number == invoiceNumber || x.Invoice_Id.ToString("0000") == invoiceNumber);
            if (tmp == null)
                return NotFound();
            //remove self reference object
            tmp = JsonConvert.DeserializeObject<SalesInvoice>(
                JsonConvert.SerializeObject(tmp, Formatting.Indented, new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                }));
            var customer = _context.Customer.FirstOrDefault(x => x.Membership_Number == tmp.MemberId);
            var invoiceBill = _context.SalesInvoiceBill.Where(x => x.Invoice_Number == tmp.Invoice_Number);

            return Ok(new { invoiceData = tmp, customerData = customer, invoiceBillData = invoiceBill });

        }


        public IActionResult GetFOCItem(string itemCode)
        {
            var focItem = _context.ItemFOC.Where(x => x.ItemForFOC == itemCode);
            return Ok(focItem);
        }

        //background function
        public void SendDataToIRD(SalesInvoice invoice, Store storeInfo)
        {

            BillViewModel p = new BillViewModel
            {
                seller_pan = storeInfo.VAT,
                buyer_pan = invoice.Customer_Vat,
                buyer_name = invoice.Customer_Name,
                fiscal_year = "2" + storeInfo.FISCAL_YEAR.Replace("/", "."), //format according to CBMS
                invoice_number = invoice.Invoice_Number,
                invoice_date = invoice.Trans_Date_Ad.Value.ToString("yyyy.MM.dd"),
                total_sales = Convert.ToDouble(invoice.Total_Net_Amount),
                taxable_sales_vat = Convert.ToDouble(invoice.TaxableAmount),
                vat = Convert.ToDouble(invoice.Total_Vat.Value),
                excisable_amount = 0,
                excise = 0,
                taxable_sales_hst = 0,
                hst = 0,
                amount_for_esf = 0,
                esf = 0,
                export_sales = 0,
                tax_exempted_sales = 0,
                isrealtime = true,
                datetimeClient = DateTime.Now
            };

            Sync.IRDPostData data = new Sync.IRDPostData();
            bool result = data.PostBill(p);
            SaveInvoiceMaterial(result, invoice.Invoice_Number);
        }
        public void SaveInvoiceMaterial(bool sendToIRD, string billNo)
        {
            InvoiceMaterializedView view = _context.InvoiceMaterializedView.FirstOrDefault(x => x.BillNo == billNo);
            if (sendToIRD)
            {
                view.SyncStatus = "Sync Completed";
                view.SyncedDate = DateTime.Now;
                view.SyncedTime = DateTime.Now.TimeOfDay;
                view.SyncWithIrd = true;
                view.IsRealTime = true;
            }
            else
            {
                view.SyncStatus = "Sync In Progress";
                view.SyncedDate = DateTime.Now;
                view.SyncedTime = DateTime.Now.TimeOfDay;
                view.SyncWithIrd = false;
                view.IsRealTime = false;
            }
            _context.Entry(view).State = EntityState.Modified;
            _context.SaveChanges();
        }


        public IEnumerable<ItemViewModel> GetItemsRawDataByBarcodeList(List<string> barcodes)
        {
            string barcodeListString = string.Join("','", barcodes);
            string query = @"SELECT Distinct
        ROW_NUMBER() OVER(PARTITION BY Bar_Code order by Rate) AS SN ,
       i.Code,i.Id as ItemId,i.Name,i.KeyInWeight,
       ISNULL(b.BarCode,0) as Bar_Code,b.Unit, 
	   ISNULL(d.DiscountPercent,0) as Discount,d.MinimumQuantity as DiscountMinimumQuantity, d.StartDate as DiscountStartDate, d.EndDate as DiscountEndDate, d.StartTime as DiscountStartTime, d.EndTime as DiscountEndTime,d.SalesType as DiscountType,d.SalesCode as DiscountSalesGroupCode,d.ItemType as DiscountItemType, d.Location as DiscountLocation,ISNULL(p.AllowLineDiscount,1) as Is_Discountable,i.No_Discount,
	   ISNULL(p.UnitPrice,0) as Rate,p.MinimumQuantity as RateMinimumQuantity, p.StartDate as RateStartDate, p.EndDate as RateEndDate, p.SalesType, p.SalesCode,
	   i.Is_Vatable
FROM ITEM i
left join ITEM_BARCODE b on i.Code = b.ItemCode AND b.IsActive = 1
inner join ITEM_PRICE p on i.Code = p.ItemCode
left join ITEM_DISCOUNT d on i.Code = d.ItemCode Or (d.ItemType = 'Item Disc. Group' and  d.ItemCode =  i.DiscountGroup)
where b.BarCode in ('" + barcodeListString + "') OR i.Code in ('" + barcodeListString + "')";

            // string barcodeListString =string.Join("','",barcodes); 
            // var p0 = new SqliteParameter("@p0", barcodeListString);
            IEnumerable<ItemViewModel> data = _context.ItemViewModel.FromSql(query).ToList();
            return data;

        }
    }
}

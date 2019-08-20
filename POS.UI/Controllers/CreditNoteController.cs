using AutoMapper;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;
using POS.UI.Sync;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI.Controllers
{
    [SessionAuthorized]
    public class CreditNoteController : Controller
    {
        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        private ILogger _logger;
        public CreditNoteController(EntityCore context, IMapper mapper, ILoggerFactory loggerFactory)
        {
            _mapper = mapper;
            _context = context;
            _logger = loggerFactory.CreateLogger<CreditInvoiceController>();
        }


        [RolewiseAuthorized]
        public IActionResult Index()
        {
            // ViewData["Customer"] = new List<Customer>();//_context.Customer;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index([FromBody] CreditNote creditNote)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    Store store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store")); ;
                    creditNote.Id = Guid.NewGuid();
                    creditNote.Credit_Note_Id = _context.CreditNote.Select(x => x.Credit_Note_Id).DefaultIfEmpty(0).Max() + 1;
                    creditNote.Credit_Note_Number = "CN-" + creditNote.Credit_Note_Id.ToString("0000") + "-" + store.INITIAL+'-'+ store.FISCAL_YEAR;
                    creditNote.Trans_Time = DateTime.Now.TimeOfDay;
                    creditNote.Division = "Divisioin";
                    creditNote.Terminal = HttpContext.Session.GetString("Terminal");
                    creditNote.Created_Date = DateTime.Now;
                    creditNote.Created_By = User.Identity.Name;
                    creditNote.isRedeem = creditNote.isRedeem;

                    if (creditNote.isRedeem == true)
                    {
                        creditNote.Remarks = "Claimed";
                    }
                    _context.Add(creditNote);

                    foreach (var item in creditNote.CreditNoteItems)
                    {
                        item.Credit_Note_Id = creditNote.Id;
                        item.Credit_Note_Number = creditNote.Credit_Note_Number;                        
                        _context.CreditNoteItem.Add(item);
                    }

                    //save to print table
                    InvoicePrint print = new InvoicePrint()
                    {
                        InvoiceNumber = creditNote.Credit_Note_Number,
                        Type = "CreditNote",
                        FirstPrintedDate = DateTime.Now,
                        FirstPrintedBy = User.Identity.Name,
                        PrintCount = 1
                    };
                    _context.InvoicePrint.Add(print);

                    await _context.SaveChangesAsync();

                    //now update invoice remarks also
                    SalesInvoice invoice = _context.SalesInvoice.FirstOrDefault(x => x.Invoice_Number == creditNote.Reference_Number.Trim());
                    invoice.Remarks = "Return";
                    _context.Entry(invoice).State = EntityState.Modified;
                    InvoiceMaterializedView invoiceMaterializedViewOld = _context.InvoiceMaterializedView.FirstOrDefault(x => x.BillNo == creditNote.Reference_Number.Trim());
                    invoiceMaterializedViewOld.IsBillActive = false;
                    _context.Entry(invoiceMaterializedViewOld).State = EntityState.Modified;


                    InvoiceMaterializedView view = new InvoiceMaterializedView()
                    {
                        BillNo = creditNote.Credit_Note_Number,
                        DocumentType = "Credit Memo",
                        FiscalYear = store.FISCAL_YEAR,
                        LocationCode = store.INITIAL,
                        BillDate = creditNote.Trans_Date_Ad.Value,
                        PostingTime = creditNote.Trans_Time.Value,
                        CustomerCode = creditNote.Customer_Id,
                        CustomerName = creditNote.Customer_Name,
                        Vatno = creditNote.Customer_Vat,
                        Amount = creditNote.Total_Gross_Amount.Value,
                        Discount = creditNote.Total_Discount.Value,
                        TaxableAmount = creditNote.TaxableAmount,
                        NonTaxableAmount = creditNote.NonTaxableAmount,
                        TaxAmount = creditNote.Total_Vat == null ? 0 : creditNote.Total_Vat.Value,
                        TotalAmount = creditNote.Total_Net_Amount.Value,
                        IsBillActive = true,
                        IsBillPrinted = false,
                        PrintedTime = DateTime.Now,
                        PrintedBy = "",
                        EnteredBy = creditNote.Created_By,
                        SyncStatus = "Not Started",
                        SyncedDate = DateTime.Now,
                        SyncedTime = DateTime.Now.TimeOfDay,
                        SyncWithIrd = false,
                        IsRealTime = false
                    };

                    InvoiceMaterializedView invoiceMaterializedView = _context.InvoiceMaterializedView.FirstOrDefault(x => x.BillNo == creditNote.Reference_Number.Trim());
                    invoiceMaterializedView.IsBillActive = false;
                    _context.Entry(invoiceMaterializedView).State = EntityState.Modified;

                    NavCreditMemo navCreditMemo = new NavCreditMemo()
                    {
                        id = creditNote.Id.ToString(),
                        number = creditNote.Credit_Note_Number,
                        postingno = creditNote.Credit_Note_Number,
                        creditMemoDate = creditNote.Trans_Date_Ad.Value.ToString("yyyy-MM-dd"),
                        customerNumber = creditNote.MemberId,
                        customerName = creditNote.Customer_Name,
                        vatregistrationnumber = creditNote.Customer_Vat,
                        locationcode = store.INITIAL,
                        accountabilitycenter = store.INITIAL,
                        assigneduserid = creditNote.Created_By,
                        externalDocumentNumber = creditNote.Reference_Number,
                        amountrounded = creditNote.IsRoundup,
                        returnremarks = creditNote.Credit_Note

                    };
                    _context.InvoiceMaterializedView.Add(view);
                    _context.SaveChanges();

                    //post to ird
                    //background task
                    BackgroundJob.Enqueue(() => SendDataToIRD(creditNote, store));
                    //Send data to NAV
                    NavPostData navPostData = new NavPostData(_context, _mapper);
                    BackgroundJob.Enqueue(() => navPostData.PostCreditNote(navCreditMemo));

                    //for api return
                    TempData["StatusMessage"] = "Credit Note Added Successfully";
                    return Ok(new { redirectUrl = "/CreditNote", Message = "Credit Note Added Successfully", InvoiceData = creditNote, StoreData = store });
                }
                catch (Exception ex)
                {
                    if (ex.Message.Contains("UniqueCreditNoteNumber") || ex.InnerException.Message.Contains("UniqueCreditNoteNumber"))
                        return await Index(creditNote);
                }
            }
            return View(creditNote);
        }


        //[HttpGet]
        //public IActionResult Index(Guid id)
        //{
        //    if (id != null) {
        //        CreditNote creditNote = _context.CreditNote.Include(x => x.CreditNoteItems).FirstOrDefault(x => x.Id == id);
        //        return Ok(creditNote);
        //    }
        //    return StatusCode(404);
        //}
        [HttpGet]       
        public IActionResult GetCreditNote(string CN)
        {
            if (!string.IsNullOrEmpty(CN))
            {
                CreditNote creditNote = _context.CreditNote.Include(x => x.CreditNoteItems).FirstOrDefault(x => x.Credit_Note_Number == CN);
                if (creditNote == null)
                    return StatusCode(400, new { Message = "Not found !!" });
                if (creditNote.Remarks == "Claimed")
                {
                    return StatusCode(400, new { Message = "Already Claimed !!" });
                }
                else if (creditNote != null && creditNote.Trans_Date_Ad.Value < DateTime.Now.AddDays(-30))
                {
                    return StatusCode(400, new { Message = "Credit Note Expired !!" });
                }
                else
                    return Ok(creditNote);
            }
            return RedirectToAction(nameof(Index));
        }



        public void SendDataToIRD(CreditNote crNote, Store storeInfo)
        {

            BillViewModel p = new BillViewModel
            {
                seller_pan = storeInfo.VAT,
                buyer_pan = crNote.Customer_Vat,
                buyer_name = crNote.Customer_Name,
                fiscal_year = storeInfo.FISCAL_YEAR,
                ref_invoice_number = crNote.Reference_Number,
                credit_note_date = crNote.Trans_Date_Ad.Value.ToString("yyyy.MM.dd"),
                credit_note_number = crNote.Credit_Note_Number,
                reason_for_return = crNote.Remarks,
                total_sales = Convert.ToDouble(crNote.Total_Net_Amount),
                taxable_sales_vat = Convert.ToDouble(crNote.TaxableAmount),
                vat = Convert.ToDouble(crNote.Total_Vat == null ? 0 : crNote.Total_Vat.Value),
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
            if (result)
            {
                InvoiceMaterializedView view = _context.InvoiceMaterializedView.FirstOrDefault(x => x.BillNo == crNote.Credit_Note_Number);
                view.SyncStatus = "Sync Completed";
                view.SyncedDate = DateTime.Now;
                view.SyncedTime = DateTime.Now.TimeOfDay;
                view.SyncWithIrd = true;
                view.IsRealTime = true;

                //update invoice bill status to inactive
                InvoiceMaterializedView invoiceView = _context.InvoiceMaterializedView.FirstOrDefault(x => x.BillNo == crNote.Reference_Number);
                invoiceView.IsBillActive = false;

                _context.Entry(view).State = EntityState.Modified;
                _context.Entry(invoiceView).State = EntityState.Modified;
                _context.SaveChanges();
            }
        }
    }
}
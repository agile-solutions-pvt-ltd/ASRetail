using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using POS.Core;
using POS.Core.Helpers;
using POS.DTO;

namespace POS.UI.Controllers
{

    public class SalesInvoiceController : Controller
    {
        private readonly EntityCore _context;

        public SalesInvoiceController(EntityCore context)
        {
            _context = context;
        }



        [HttpGet]
        public IActionResult Index(Guid? id, string StatusMessage)
        {
            SalesInvoiceTmp tmp;
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
                var store = _context.Store.FirstOrDefault();
                var invoiceId = _context.SalesInvoice.Select(x => x.Invoice_Id).DefaultIfEmpty(0).Max() + 1;
                tmp = new SalesInvoiceTmp()
                {
                    Invoice_Number = "SI-" + invoiceId.ToString("0000") + "-" + store.INITIAL + "-" + store.FISCAL_YEAR
                };
            }
            TempData["StatusMessage"] = StatusMessage;
            ViewData["Customer"] = _context.Customer;
            return View(tmp);
        }

        [HttpPost]
        public async Task<IActionResult> Index([FromBody] SalesInvoiceAndCustomerViewModel model)
        {
            SalesInvoiceTmp salesInvoiceTmp = model.SalesInvoice;
            Customer customer = model.Customer;
            if (ModelState.IsValid)
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
                    customer.Code = Guid.NewGuid().ToString();
                    customer.Member_Id = _context.Customer.Select(x => x.Member_Id).DefaultIfEmpty(1000).Max() + 1;
                    _context.Add(customer);
                    _context.SaveChanges();
                    salesInvoiceTmp.Customer_Id = customer.Code;
                }


                //now processed to new save invoice
                salesInvoiceTmp.Id = Guid.NewGuid();
                salesInvoiceTmp.Trans_Time = DateTime.Now.TimeOfDay;
                salesInvoiceTmp.Division = "Divisioin";
                salesInvoiceTmp.Terminal = "Terminal1";
                salesInvoiceTmp.Created_Date = DateTime.Now;
                salesInvoiceTmp.Created_By = this.User.FindFirstValue(ClaimTypes.NameIdentifier);


                _context.Add(salesInvoiceTmp);

                foreach (var item in salesInvoiceTmp.SalesInvoiceItems)
                {
                    item.Invoice_Id = salesInvoiceTmp.Id;
                    item.Invoice_Number = salesInvoiceTmp.Invoice_Number;
                    _context.SalesInvoiceItemsTmp.Add(item);
                }





                await _context.SaveChangesAsync();

                //if everything goes right then delete old sales invoice
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
                if (salesInvoiceTmp.Trans_Type == "Hold")
                    return Ok(new { redirectUrl = "/SalesInvoice" });
                else
                    return Ok(new { RedirectUrl = "/SalesInvoice/Billing/" + salesInvoiceTmp.Id });
            }
            return View(salesInvoiceTmp);
        }


        [HttpGet]
        public IActionResult Landing()
        {
            //display only ismember data later
            ViewData["Customer"] = _context.Customer;
            return View();
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
            var trans = _context.SalesInvoiceTmp.Where(x => x.Trans_Type == "Hold").ToList();
            return PartialView("_PausedTransactionListPartial", trans);
        }

        [HttpGet]
        public IActionResult Billing(Guid id)
        {
            ViewBag.SalesInvoiceTemp = _context.SalesInvoiceTmp.FirstOrDefault(x => x.Id == id);
            ViewData["Customer"] = _context.Customer;
            return View();
        }



        [HttpPost]
        public IActionResult Billing(Guid salesInvoiceId, [FromBody] List<SalesInvoiceBill> bill)
        {
            try
            {
                //check if billing is not available
                if (bill.Count() == 0)
                    return NotFound();

                //Check from salesInvoiceTmp table
                SalesInvoiceTmp salesInvoiceTmp = _context.SalesInvoiceTmp.FirstOrDefault(x => x.Id == salesInvoiceId);
                if (salesInvoiceTmp == null)
                    return NotFound();

                //get store info
                Store store = _context.Store.FirstOrDefault();
                //convert to sales invoice and save
                SalesInvoice salesInvoice = Cast.CastObject<SalesInvoice>(salesInvoiceTmp);
                salesInvoice.Invoice_Id = _context.SalesInvoice.Where(x => x.Trans_Type == salesInvoice.Trans_Type).Select(x => x.Invoice_Id).DefaultIfEmpty(0).Max() + 1;
                salesInvoice.Invoice_Number = SalesInvoiceNumberFormat(store, salesInvoice.Invoice_Id, salesInvoice.Trans_Type);
                _context.SalesInvoice.Add(salesInvoice);

                //get invoice items temp convert to sales invoice item and save them
                IList<SalesInvoiceItemsTmp> itemtmp = _context.SalesInvoiceItemsTmp.Where(x => x.Invoice_Id == salesInvoiceTmp.Id).ToList();
                foreach (var item in itemtmp)
                {
                    item.Invoice = null;
                    SalesInvoiceItems salesItem = Cast.CastObject<SalesInvoiceItems>(item);
                    salesItem.Id = 0;
                    salesItem.Invoice_Id = salesInvoice.Id;
                    salesItem.Invoice_Number = salesInvoice.Invoice_Number;
                    _context.SalesInvoiceItems.Add(salesItem);
                }


                //check session
                Settlement oldSettlement = _context.Settlement.FirstOrDefault(x => x.UserId == salesInvoice.Created_By && x.Status == "Open");
                //save bill amount information
                foreach (var item in bill)
                {
                    item.Invoice_Number = salesInvoice.Invoice_Number;
                    item.Invoice_Type = salesInvoice.Trans_Type;
                    _context.SalesInvoiceBill.Add(item);


                    //if credit note amount is used then update credit note table
                    if (item.Trans_Mode == "Credit Note")
                    {
                        CreditNote creditNote = _context.CreditNote.FirstOrDefault(x => x.Credit_Note_Number == item.Account);
                        if (creditNote != null)
                        {
                            creditNote.Created_By = this.User.FindFirstValue(ClaimTypes.NameIdentifier);
                            creditNote.Created_Date = DateTime.Now;
                            creditNote.Remarks = "Claimed";
                            _context.Entry(creditNote).State = EntityState.Modified;
                        }
                    }


                    //save to settlement table

                    string sessionId = oldSettlement != null ? oldSettlement.SessionId : Guid.NewGuid().ToString();
                    Settlement settlement = new Settlement()
                    {
                        SessionId = sessionId,
                        TerminalId = 5, //static for now
                        TransactionDate = DateTime.Now,
                        PaymentMode = item.Trans_Mode,
                        Amount = item.Amount,
                        Status = "Open",
                        VerifiedBy = "",
                        VerifiedDate = DateTime.Now,
                        TransactionNumber = salesInvoice.Invoice_Number,
                        Remarks = "",
                        UserId = salesInvoice.Created_By

                    };
                    _context.Settlement.Add(settlement);
                }



                _context.SaveChanges();

                //if everything seems good, then delete salesInvoiceTmp
                _context.Remove(salesInvoiceTmp);

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
                    Amount = salesInvoice.Total_Gross_Amount.Value,
                    Discount = salesInvoice.Total_Discount.Value,
                    TaxableAmount = salesInvoice.TaxableAmount,
                    NonTaxableAmount = salesInvoice.NonTaxableAmount,
                    TaxAmount = salesInvoice.Total_Vat.Value,
                    TotalAmount = salesInvoice.Total_Net_Amount.Value,
                    IsBillActive = true,
                    IsBillPrinted = false,
                    PrintedTime = DateTime.Now,
                    PrintedBy = "",
                    EnteredBy = salesInvoice.Created_By,
                    SyncStatus = "Not Started",
                    SyncedDate = DateTime.Now,
                    SyncedTime = DateTime.Now.TimeOfDay,
                    SyncWithIrd = false,
                    IsRealTime = false
                };
                _context.InvoiceMaterializedView.Add(view);

                _context.SaveChanges();

                //background task
                 var jobId = BackgroundJob.Enqueue(() => SendDataToIRD(salesInvoice, store));
               // SendDataToIRD(salesInvoice, store);


                //TempData["StatusMessage"] = "Bill Payment Successfull !!";
                return Ok("Bill Payment Successfull !!");
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


        //api get salesinvoice
        public IActionResult GetInvoice(string invoiceNumber)
        {
            SalesInvoice tmp = _context.SalesInvoice.Include(x => x.SalesInvoiceItems).FirstOrDefault(x => x.Invoice_Number == invoiceNumber);
            if (tmp == null)
                return NotFound();
            //remove self reference object
            tmp = JsonConvert.DeserializeObject<SalesInvoice>(
                JsonConvert.SerializeObject(tmp, Formatting.Indented, new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                }));
            return Ok(tmp);
        }



        public void SendDataToIRD(SalesInvoice invoice, Store storeInfo)
        {

            BillViewModel p = new BillViewModel
            {
                username = "Test_CBMS",
                password = "test@321",
                seller_pan = storeInfo.VAT,
                buyer_pan = invoice.Customer_Vat,
                buyer_name = invoice.Customer_Name,
                fiscal_year = storeInfo.FISCAL_YEAR,
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
            if (result)
            {
                InvoiceMaterializedView view = _context.InvoiceMaterializedView.FirstOrDefault(x => x.BillNo == invoice.Invoice_Number);
                view.SyncStatus = "Sync Completed";
                view.SyncedDate = DateTime.Now;
                view.SyncedTime = DateTime.Now.TimeOfDay;
                view.SyncWithIrd = true;
                view.IsRealTime = true;

                _context.Entry(view).State = EntityState.Modified;
                _context.SaveChanges();
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
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




        public IActionResult Index(Guid? id)
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
                    salesInvoiceTmp.Customer_Id = customer.Id;
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
                if (bill.Count() == 0)
                    return NotFound();

                //Check from salesInvoiceTmp table
                SalesInvoiceTmp salesInvoiceTmp = _context.SalesInvoiceTmp.FirstOrDefault(x => x.Id == salesInvoiceId);
                if (salesInvoiceTmp == null)
                    return NotFound();

                //convert to sales invoice and save
                SalesInvoice salesInvoice = Cast.CastObject<SalesInvoice>(salesInvoiceTmp);
                salesInvoice.Invoice_Id = _context.SalesInvoice.Where(x=>x.Trans_Type == salesInvoice.Trans_Type).Select(x => x.Invoice_Id).DefaultIfEmpty(0).Max() + 1;
                salesInvoice.Invoice_Number = SalesInvoiceNumberFormat(salesInvoice.Invoice_Id, salesInvoice.Trans_Type);
                _context.SalesInvoice.Add(salesInvoice);

                //get invoice items temp convert to sales invoice and save them
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

                //save bill amount information
                foreach (var item in bill)
                {
                    item.Invoice_Number = salesInvoice.Invoice_Number;
                    item.Invoice_Type = salesInvoice.Trans_Type;
                    _context.SalesInvoiceBill.Add(item);
                }
                _context.SaveChanges();

                //if everything seems good, then delete salesInvoiceTmp
                _context.Remove(salesInvoiceTmp);
                _context.SaveChanges();

                TempData["StatusMessage"] = "Bill Payment Successfull !!";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }


        private string SalesInvoiceNumberFormat(int invoiceNumber, string type)
        {
            Store store = _context.Store.FirstOrDefault();
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
    }
}

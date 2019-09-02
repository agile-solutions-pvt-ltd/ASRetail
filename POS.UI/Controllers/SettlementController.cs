using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;
using System;
using System.Collections.Generic;
using System.Linq;

namespace POS.UI.Controllers
{
    [RolewiseAuthorized]
    public class SettlementController : Controller
    {

        private readonly EntityCore _context;

        public SettlementController(EntityCore context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Index(string status, DateTime? startdate = null, DateTime? enddate = null)
        {
            //IEnumerable<Settlement> settlement = _context.Settlement.Include(x => x.Terminal).Include(x => x.User).Where(x => x.Status == "Closed");
            //settlement = (from x in settlement
            //              group x by
            //              new { x.Id, x.PaymentMode, x.Remarks, x.SessionId, x.Status, x.TerminalId, x.TransactionDate, x.TransactionNumber, x.UserId, x.VerifiedBy, x.VerifiedDate } into y
            //              select new Settlement
            //              {
            //                  Id = y.Key.Id,
            //                  UserId
            //              });
            // .GroupBy(x => new { x.UserId, x.TerminalId })
            //.Select(y => new Settlement{
            //    Id = x=>x.
            //    x.Sum(y => y.Amount));

            String _status = status ?? new string("Closed");
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);

            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            TempData["startdate"] = _startDate;
            TempData["enddate"] = _endDate;
            TempData["Status"] = _status;

            _endDate = _endDate.AddHours(23);


            IEnumerable<SettlementViewModel> settlement = _context.SettlementViewModel.Where(x => x.Status == _status && x.StartTransaction >= _startDate && x.EndTransaction <= _endDate);
            return View(settlement);
        }


        [HttpGet]
        public IActionResult GetSettlement(string status, DateTime? startdate = null, DateTime? enddate = null)
        {
            String _status = status ?? new string("Closed");

            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            _endDate = _endDate.AddHours(23);
            if (_status == "verified")
            {
                IEnumerable<SettlementViewModel> settlement = _context.SettlementViewModel.Where(x => x.Status == _status && x.VerifiedDate >= _startDate && x.VerifiedDate <= _endDate).ToList();
                return Ok(settlement);
            }
            else
            {
                IEnumerable<SettlementViewModel> settlement = _context.SettlementViewModel.Where(x => x.Status == _status && x.StartTransaction >= _startDate && x.EndTransaction <= _endDate).ToList();
                return Ok(settlement);

            }

        }

        [HttpGet]
        public IActionResult GetSettlementById(string session)
        {

            IEnumerable<SettlementViewModel> settlementData = _context.SettlementViewModel.Where(x => x.SessionId == session).ToList();
            var store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
            return Ok(new { SettlementData = settlementData, Store = store });
        }

        //        [HttpGet]
        //        public IActionResult GetSettlementCashAmount(string userId, DateTime startDate, DateTime endDate)
        //        {

        //            string query = $@"select si.Created_By, sib.Terminal, sum(si.Total_Payable_Amount) as Amount from
        //SALES_INVOICE si
        //inner join SALES_INVOICE_BILL sib on si.Invoice_Number = sib.Invoice_Number
        //where sib.Trans_Mode = 'Cash' and si.Created_By = 'SUHMITA.RAI' and
        //cast(si.Trans_Date_AD as Date) >= CAST('2019-07-19' as date) and Cast(si.trans_time as time) >= cast('2019-07-19T09:00:00.840' as time)
        //and cast(si.Trans_Date_AD as Date) <= CAST('2019-07-19' as date) and cast(si.Trans_Time as time) <= cast('2019-07-19T20:16:00.840' as time)
        //group by si.Created_By,sib.Terminal";
        //            var value = _context
        //            return Ok(new { CashAmount = settlementData, Store = store });
        //        }





        [HttpPost]
        public IActionResult VerifySettlement([FromBody] SettlementPostViewModel data)
        {
            if (ModelState.IsValid)
            {
                IList<Settlement> settlement = _context.Settlement.Where(x => x.SessionId == data.Settlement.SessionId).ToList();
                var store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
                using (var trans = _context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (var item in settlement)
                        {
                            if (item.PaymentMode == "Cash")
                            {
                                item.AdjustmentAmount = data.AdjustmentCashAmount;
                                item.ShortExcessAmount = data.ShortExcessCashAmount;
                            }
                            else if (item.PaymentMode == "Credit")
                            {
                                item.AdjustmentAmount = data.AdjustmentCreditAmount;
                                item.ShortExcessAmount = data.ShortExcessCreditAmount;
                            }
                            else if (item.PaymentMode == "CreditNote")
                            {
                                item.AdjustmentAmount = data.AdjustmentCreditNoteAmount;
                                item.ShortExcessAmount = data.ShortExcessCreditNoteAmount;
                            }
                            else if (item.PaymentMode == "Card")
                            {
                                item.AdjustmentAmount = data.AdjustmentCardAmount;
                                item.ShortExcessAmount = data.ShortExcessCardAmount;
                            }
                            item.VerifiedBy = User.Identity.Name;
                            item.VerifiedDate = DateTime.Now;
                            item.Status = "Verified";
                            _context.Entry(item).State = EntityState.Modified;
                        }

                        _context.SaveChanges();
                        trans.Commit();

                        var settlementData = _context.SettlementViewModel.Where(x => x.SessionId == settlement.FirstOrDefault().SessionId).ToList();
                        return Ok(new { SettlementData = settlementData, Store = store });
                    }
#pragma warning disable CS0168 // The variable 'ex' is declared but never used
                    catch (Exception ex)
#pragma warning restore CS0168 // The variable 'ex' is declared but never used
                    {
                        trans.Rollback();
                    }
                };


            }
            return StatusCode(400);
        }

    }
}

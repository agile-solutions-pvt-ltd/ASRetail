using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using POS.Core;
using POS.DTO;
using POS.UI.Models;

namespace POS.UI.Controllers
{
    public class SettlementController : Controller
    {

        private readonly EntityCore _context;

        public SettlementController(EntityCore context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Index()
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
            IEnumerable<SettlementViewModel> settlement = _context.SettlementViewModel.Where(x => x.Status == "Closed");
            return View(settlement);
        }


        [HttpGet]
        public IActionResult GetSettlement()
        {
           
            IEnumerable<SettlementViewModel> settlement = _context.SettlementViewModel.Where(x => x.Status == "Closed");
            return Ok(settlement);
        }


    }
}

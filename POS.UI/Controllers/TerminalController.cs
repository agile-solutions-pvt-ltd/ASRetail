﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI.Controllers
{
    [Authorize]
    public class TerminalController : Controller
    {
        private readonly EntityCore _context;

        public TerminalController(EntityCore context)
        {
            _context = context;
        }

        // GET: Terminal
        /// <summary>
        /// Get view for list of terminal.
        /// </summary>
        /// <returns>Terminal's List</returns>
        /// 
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            return View(await _context.Terminal.ToListAsync());
        }

        // GET: Terminal/Details/5
        /// <summary>
        /// Get view of first or default terminal detail by id.
        /// </summary>
        /// <param name="id">Primary Key (int)</param>
        /// <returns>Terminal's detail by id.</returns>
        /// 
        [HttpGet]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var terminal = await _context.Terminal
                .FirstOrDefaultAsync(m => m.Id == id);
            if (terminal == null)
            {
                return NotFound();
            }

            return View(terminal);
        }

        // GET: Terminal/Create
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        // POST: Terminal/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        /// <summary>
        /// Post new details of terminal.
        /// </summary>
        /// <param name="terminal">Main obj for posting</param>
        /// <returns>Create terminal.</returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Initial,Name,Is_Active,Remarks,Cash_Drop_Limit")] Terminal terminal)
        {
            if (ModelState.IsValid)
            {
                _context.Add(terminal);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(terminal);
        }

        // GET: Terminal/Edit/5
        /// <summary>
        /// Get edit view of terminal details by id
        /// </summary>
        /// <param name="id">Primary key (int)</param>
        /// <returns>Terminal's detail by id.</returns>
        [HttpGet]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var terminal = await _context.Terminal.FindAsync(id);
            if (terminal == null)
            {
                return NotFound();
            }
            return View(terminal);
        }

        // POST: Terminal/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        /// <summary>
        /// Post edited details of terminal.
        /// </summary>
        /// <param name="id">Primary Key (int)</param>
        /// <param name="terminal">Main obj for posting</param>
        /// <returns>Update terminal</returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Initial,Name,Is_Active,Remarks,Cash_Drop_Limit")] Terminal terminal)
        {
            if (id != terminal.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(terminal);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TerminalExists(terminal.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(terminal);
        }

        // GET: Terminal/Delete/5
        [HttpGet]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var terminal = await _context.Terminal
                .FirstOrDefaultAsync(m => m.Id == id);
            if (terminal == null)
            {
                return NotFound();
            }

            return View(terminal);
        }

        // POST: Terminal/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var terminal = await _context.Terminal.FindAsync(id);
            _context.Terminal.Remove(terminal);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool TerminalExists(int id)
        {
            return _context.Terminal.Any(e => e.Id == id);
        }






        [HttpGet]
        public IActionResult TerminalMapping()
        {
            ViewData["Terminal_Id"] = new SelectList(_context.Terminal, "Id", "Name");
            return View();
        }

        [HttpPost]
        public IActionResult TerminalMapping([FromBody] TerminalMapping terminalMapping)
        {
            if (ModelState.IsValid)
            {
                //first remove if mapped to terminal
                IEnumerable<TerminalMapping> oldMapping = _context.TerminalMapping.Where(x => x.IPAddress == terminalMapping.IPAddress);
                _context.TerminalMapping.RemoveRange(oldMapping);
                _context.SaveChanges();

                terminalMapping.AssignedBy = User.Identity.Name; ;
                terminalMapping.AssignedDate = DateTime.Now;
                _context.TerminalMapping.Add(terminalMapping);
                _context.SaveChanges();
                return Ok();
            }
            return StatusCode(400);
        }

        [AllowAnonymous]
        public IActionResult GetClientComputerName(string ip)
        {
            try
            {

                Config config = ConfigJSON.Read();
                string url = "http://" + ip + ":" + config.ClientPort + "/POSClient/GetComputerName";
                var client = new RestSharp.RestClient(url);
                var request = new RestSharp.RestRequest(RestSharp.Method.GET);

                request.AddHeader("Access-Control-Allow-Origin", "*");

                RestSharp.IRestResponse response = client.Execute(request);
                string pcName = response.Content.Replace("\"", "");
#pragma warning disable CS0219 // The variable 'terminalId' is assigned but its value is never used
                int terminalId = 0;
#pragma warning restore CS0219 // The variable 'terminalId' is assigned but its value is never used
                //check if terminal is assigned
                TerminalMapping terminalMapping = _context.TerminalMapping.FirstOrDefault(x => x.PCName == pcName);
                Terminal terminal = new Terminal();
                if (terminalMapping != null)
                    terminal = _context.Terminal.FirstOrDefault(x => x.Id == terminalMapping.TerminalId);

                return Ok(new { pcName = pcName, terminalId = terminalMapping.TerminalId.ToString(), terminalName = terminal?.Name });
            }
#pragma warning disable CS0168 // The variable 'ex' is declared but never used
            catch (Exception ex)
#pragma warning restore CS0168 // The variable 'ex' is declared but never used
            {
                return StatusCode(500);
            }



        }



        [AllowAnonymous]
        public IActionResult GetTerminalInfo(string ip)
        {
            try
            {
                int terminalId = 0;
                //check if terminal is assigned
                TerminalMapping terminalMapping = _context.TerminalMapping.FirstOrDefault(x => x.IPAddress == ip);
                Terminal terminal = new Terminal();
                if (terminalMapping != null)
                {
                    terminal = _context.Terminal.FirstOrDefault(x => x.Id == terminalMapping.TerminalId);
                    terminalId = terminal.Id;
                }

                return Ok(new { pcName = "", terminalId = terminalId, terminalName = terminal?.Name });
            }
#pragma warning disable CS0168 // The variable 'ex' is declared but never used
            catch (Exception ex)
#pragma warning restore CS0168 // The variable 'ex' is declared but never used
            {
                return StatusCode(500);
            }



        }


    }
}

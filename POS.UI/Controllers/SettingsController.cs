using AutoMapper;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using POS.UI.Sync;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace POS.UI.Controllers
{
    [SessionAuthorized]
    public class SettingsController : Controller
    {
        private readonly EntityCore _context;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IMapper _mapper;
        private IMemoryCache _cache;
        public IConfiguration Configuration { get; }
        private ILogger _logger;
        public SettingsController(EntityCore context, IConfiguration configuration, IMapper mapper, UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager, IMemoryCache memoryCache, ILoggerFactory loggerFactory)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _context = context;
            _mapper = mapper;
            _cache = memoryCache;
            Configuration = configuration;
            _logger = loggerFactory.CreateLogger<SettingsController>();
        }


        [RolewiseAuthorized]
        [HttpGet]
        public IActionResult Index()
        {
            //  NavSync navSync = new NavSync(_context,_mapper);
            //  Config config = ConfigJSON.Read();
            // ViewData["Servers"] = _context.Company; // navSync.GetCompanySync();
            // ViewData["Server"] = config.Environment;
            return View();
        }
        [HttpPost]
        public IActionResult Index([FromBody]Setting setting)
        {
            if (ModelState.IsValid)
            {
                Config config = ConfigJSON.Read();
                config.Environment = setting.Environment;
                config.NavCompanyId = setting.CompanyId;
                ConfigJSON.Write(config);
            }
            return RedirectToAction("Index");
        }

        public IActionResult GetMenu()
        {

            return Ok(_context.Menu.ToList());
        }


        [HttpGet]
        public IActionResult Shortcuts()
        {
            return View();
        }



        public IActionResult PrintPage()
        {
            return View("InvoicePrint");
        }






        //////********** scheduling jobs
        [HttpGet]
        public IActionResult SchedulerSetup()
        {
            ViewData["Scheduler"] = ConfigJSON.Read();
            IList<CustomerViewModel> customer;
            _cache.TryGetValue("Customers", out customer);
            if (customer != null)
            {
                ViewData["IsCustomerCache"] = true;
                ViewData["CustomerCacheCount"] = customer.Count();
            }
            else
                ViewData["IsCustomerCache"] = false;

            IList<ItemViewModel> item;
            _cache.TryGetValue("ItemViewModel", out item);
            if (item != null)
            {
                ViewData["IsItemCache"] = true;
                ViewData["ItemCacheCount"] = item.Count();
            }
            else
                ViewData["IsItemCache"] = false;


            return View();
        }

        [HttpPost]
        public IActionResult SchedulerSetup([FromBody] SchedulerDuration data)
        {
            Config config = ConfigJSON.Read();
            config.SchedulerDuration = data;
            ConfigJSON.Write(config);
            return Ok();
        }

        [HttpPost]
        public IActionResult SchedulerStart(string name)
        {
            if (!string.IsNullOrEmpty(name))
            {
                NavSync sync = new NavSync(_context, _mapper, _userManager, _roleManager, _cache, Configuration);
                Type t = sync.GetType();
                MethodInfo method = t.GetMethod(name);
                var result = (bool)method.Invoke(sync, null);

                if (result)
                    return Ok();
                else
                    return StatusCode(500);
            }
            return StatusCode(400);
        }

        [AutomaticRetry(Attempts = 0)]
        public IActionResult PostInvoiceToNAV()
        {
            NavPostData sync = new NavPostData(_context, _mapper);
            Store store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
            //sync.PostSalesInvoice(store);
            //sync.PostSalesInvoice(store);
            BackgroundJob.Enqueue(() => sync.PostSalesInvoice(store));
            // BackgroundJob.Enqueue(() => Console.WriteLine("test from background"));
            var data = new
            {
                Status = 200,
                Message = "Success"
            };
            return Ok(data);
        }
        [AutomaticRetry(Attempts = 0)]
        public IActionResult PostCreditNoteToNAV()
        {
            NavPostData sync = new NavPostData(_context, _mapper);
            Store store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
            //sync.PostSalesInvoice(store);

            BackgroundJob.Enqueue(() => sync.PostCreditNote(store));
            var data = new
            {
                Status = 200,
                Message = "Success"
            };
            return Ok(data);
        }
        [AutomaticRetry(Attempts = 0)]
        public IActionResult PostCustomerToNAV()
        {
            NavPostData sync = new NavPostData(_context, _mapper);
            BackgroundJob.Enqueue(() => sync.PostCustomer());
            var data = new
            {
                Status = 200,
                Message = "Success"
            };
            return Ok(data);
        }
        [AutomaticRetry(Attempts = 0)]
        public IActionResult PostUnSyncInvoiceToNav()
        {
            NavPostData sync = new NavPostData(_context, _mapper);
            Store store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
            //sync.PostSalesInvoice(store);
            //sync.PostSalesInvoice(store);
            BackgroundJob.Enqueue(() => sync.PostCustomer());
            BackgroundJob.Enqueue(() => sync.PostUnSyncInvoie(store));
            // BackgroundJob.Enqueue(() => Console.WriteLine("test from background"));
            var data = new
            {
                Status = 200,
                Message = "Success"
            };
            return Ok(data);
        }
        public IActionResult PostUnSyncInvoiceToNavSchedulerStart()
        {
            // RecurringJob.AddOrUpdate(() => PostCustomerToNAV(), Cron.Daily);
            RecurringJob.AddOrUpdate(() => PostUnSyncInvoiceToNav(), "15 17 * * *");

            var data = new
            {
                Status = 200,
                Message = "Success"
            };
            return Ok(data);
        }
        public IActionResult DeleteSalesOrder()
        {
            NavPostData sync = new NavPostData(_context, _mapper);
           
            //sync.PostSalesInvoice(store);
            //sync.PostSalesInvoice(store);
            BackgroundJob.Enqueue(() => sync.DeleteSalesOrder());
            // BackgroundJob.Enqueue(() => Console.WriteLine("test from background"));
            var data = new
            {
                Status = 200,
                Message = "Success"
            };
            return Ok(data);
        }

        ////////********** scheduling jobs
        ///[HttpGet]
        public IActionResult APISetup()
        {
            ViewData["API"] = ConfigJSON.Read();
            return View();
        }

        [HttpPost]
        public IActionResult APISetup([FromBody] Config data)
        {
            Config config = ConfigJSON.Read();
            data.SchedulerDuration = config.SchedulerDuration;
            data.ClientPort = config.ClientPort;
            data.Environment = config.Environment;
            ConfigJSON.Write(data);
            return Ok();
        }


        public IActionResult NAVTestConnection()
        {
            Config config = ConfigJSON.Read();
            NavSync sync = new NavSync(_context, _mapper, _userManager, _roleManager, _cache, Configuration);
            var result = sync.TestNavConnection();

            if (result is string && result != "Success")
                return StatusCode(500, result);
            if (result.Count() > 0)
                return Ok(result);
            else
                return StatusCode(500, result);
        }





        public IActionResult DatabaseBackupRestore()
        {
            return View();
        }
        public IActionResult StoreInformation()
        {
            return View();
        }
        [HttpPost]
        public IActionResult DataBaseBackUp(string path)
        {
            string conStr = Configuration.GetConnectionString("DefaultConnection");
            bool result = DatabaseHelper.BackupDatabase(path, conStr);
            if (result)
                return Ok();
            else
                return StatusCode(500);
        }
        public IActionResult DataBaseRestore(string dbName, string path)
        {
            string conStr = Configuration.GetConnectionString("DefaultConnection");
            bool result = DatabaseHelper.RestoreDatabase(dbName, path, conStr);
            if (result)
                return Ok();
            else
                return StatusCode(500);
        }


        //Author - Santosh Sapkota
        public IActionResult NavUnsyncedInvoice()
        {
            return View();
        }
        //transaction type: 1 = Sales, 2 = Tax Invoice, 2 = Credit Note Invoice
        public IActionResult NavUnsyncedInvoiceByTransaction(int transactionType)
        {
            if (transactionType == 1)
            {
                var list = _context.SalesInvoice.Where(x => x.IsNavSync == false && x.Trans_Type == "Sales");
                return Ok(list);
            }
            else if (transactionType == 2)
            {
                var list = _context.SalesInvoice.Where(x => x.IsNavSync == false && x.Trans_Type == "Tax");
                return Ok(list);
            }
            else if (transactionType == 3)
            {
                var list = _context.CreditNote
                    .Where(x => x.IsNavSync == false)
                    .Select(x => new SalesInvoice
                    {
                        Invoice_Number = x.Credit_Note_Number,
                        Trans_Date_Ad = x.Trans_Date_Ad,
                        Trans_Date_Bs = x.Trans_Date_Bs,
                        Trans_Type = "Credit",
                        Customer_Id = x.Customer_Id,
                        Total_Net_Amount = x.Total_Net_Amount
                    });
                return Ok(list);
            }
            else
            {
                return BadRequest();
            }
        }




    }
}

using AutoMapper;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using POS.UI.Sync;
using System;
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
        public SettingsController(EntityCore context, IConfiguration configuration, IMapper mapper, UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager, IMemoryCache memoryCache)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _context = context;
            _mapper = mapper;
            _cache = memoryCache;
            Configuration = configuration;
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
                NavSync sync = new NavSync(_context, _mapper, _userManager, _roleManager, _cache,Configuration);
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


        public IActionResult PostInvoiceToNAV()
        {
            NavPostData sync = new NavPostData(_context, _mapper);
            Store store = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
            sync.PostSalesInvoice(store);
           
            BackgroundJob.Enqueue(() => sync.PostSalesInvoice(store));
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
            NavSync sync = new NavSync(_context, _mapper, _userManager, _roleManager, _cache,Configuration);
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
    }
}

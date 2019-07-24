using AutoMapper;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using POS.Core;
using POS.DTO;
using POS.UI.Sync;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI.Controllers
{
    [Authorize]
    public class ApiController : Controller
    {
        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        private IMemoryCache _cache;
        public ApiController(EntityCore context, IMapper mapper, IMemoryCache memoryCache)
        {
            _context = context;
            _mapper = mapper;
            _cache = memoryCache;
        }


        // GET: Customer
        public IActionResult SyncCompletedCustomers()
        {
            try
            {
                _cache.Remove("Customer");
                var data =new  {
                    Status=  200,
                    Messge= "Success"
                };
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500);
            }
        }
        // GET: Customer
        public IActionResult SyncCompletedItems()
        {
            try
            {
                _cache.Remove("ItemViewModel");
                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500);
            }
        }


    }
}

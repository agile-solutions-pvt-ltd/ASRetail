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
                _cache.Remove("Customers");
                IEnumerable<Customer> customers;
                if (!_cache.TryGetValue("Customers", out customers))
                {
                    // Key not in cache, so get data.
                    customers = _context.Customer.ToList();

                    _cache.Set("Customers", customers);
                }
                var data =new  {
                    Status=  200,
                    Message= "Success"
                };
                return Ok(data);
            }
            catch (Exception ex)
            {
                var data = new
                {
                    Status = 500,
                    Message = "Error :" + ex.Message
                };
                return StatusCode(500, data);
            }
        }
        // GET: Customer
        public IActionResult SyncCompletedItems()
        {
            try
            {
                _cache.Remove("ItemViewModel");
                var data = new
                {
                    Status = 200,
                    Message = "Success"
                };
                return Ok(data);
            }
            catch (Exception ex)
            {
                var data = new
                {
                    Status = 500,
                    Message = "Error :" + ex.Message
                };
                return StatusCode(500, data);
            }
        }


    }
}

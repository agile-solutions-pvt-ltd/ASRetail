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
    public class CustomerController : Controller
    {
        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        private IMemoryCache _cache;
        public CustomerController(EntityCore context, IMapper mapper, IMemoryCache memoryCache)
        {
            _context = context;
            _mapper = mapper;
            _cache = memoryCache;
        }


        // GET: Customer
        public async Task<IActionResult> Index()
        {
            return View(await _context.Customer.ToListAsync());
        }

        // GET: Customer/Details/5
        //public async Task<IActionResult> Details(int? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var customer = await _context.Customer
        //        .FirstOrDefaultAsync(m => m.Id == id);
        //    if (customer == null)
        //    {
        //        return NotFound();
        //    }

        //    return View(customer);
        //}

        // GET: Customer/Create
        public IActionResult Create()
        {
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Customer customer)
        {
            if (ModelState.IsValid)
            {
                if (AddCustomer(customer))
                {
                    NavPostData navPost = new NavPostData(_context, _mapper);
                    BackgroundJob.Enqueue(() => navPost.PostCustomer());
                    TempData["StatusMessage"] = "Customer Created Successfully !!";
                }
                else
                    TempData["StatusMessage"] = "Error occor, try again later !!";
                return RedirectToAction(nameof(Index));
            }
            return View(customer);
        }

        public bool AddCustomer(Customer customer)
        {
            try
            {
                customer.Code = Guid.NewGuid().ToString();
                customer.Member_Id = _context.Customer.Where(x => x.Is_Member == true && x.Member_Id != null).Select(x => x.Member_Id).DefaultIfEmpty(0).Max() + 1;
                Store store = _context.Store.FirstOrDefault();
                customer.Membership_Number = store.INITIAL + "-" + Convert.ToInt32(customer.Member_Id).ToString("000000");
                customer.Created_By = User.Identity.Name;
                customer.Registration_Date = DateTime.Now;
                customer.MembershipDiscGroup = "CATEGORY D";
                customer.CustomerPriceGroup = "RSP";
                customer.CustomerDiscGroup = "RSP";
                _context.Add(customer);
                _context.SaveChanges();


                //update cache
                IEnumerable<Customer> customers;
                if (!_cache.TryGetValue("Customers", out customers))
                {
                    // Key not in cache, so get data.
                    customers = _context.Customer.ToList();

                    _cache.Set("Customers", customers);
                }
                customers.ToList().Add(customer);
                _cache.Set("Customer", customers);
                return true;

            }
            catch (Exception ex)
            {
                if (ex.InnerException.Message.Contains("idx_unique_member_id"))
                    return AddCustomer(customer);
                else
                    return false;
            }
        }

        //// GET: Customer/Edit/5
        //public async Task<IActionResult> Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var customer = await _context.Customer.FindAsync(id);
        //    if (customer == null)
        //    {
        //        return NotFound();
        //    }
        //    return View(customer);
        //}

        //// POST: Customer/Edit/5
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> Edit(string code, [Bind("Code,Name,Address,Image,Tel1,Tel2,Mobile1,Mobile2,Email,Vat,Fax,Po_Box,Type,Credit_Limit,Credit_Day,Is_Sale_Refused,Is_Member,Member_Id,Barcode,Dob,Dob_Bs,Wedding_Date,Family_Member_Int,Occupation,Office_Name,Office_Address,Designation,Registration_Date,Validity_Period,Validity_Date,Membership_Scheme,Reference_By,Created_By,Created_Date,Remarks")] Customer customer)
        //{
        //    if (code != customer.Code)
        //    {
        //        return NotFound();
        //    }

        //    if (ModelState.IsValid)
        //    {
        //        try
        //        {
        //            _context.Update(customer);
        //            await _context.SaveChangesAsync();
        //            TempData["StatusMessage"] = "Customer Updated Successfully !!";
        //        }
        //        catch (DbUpdateConcurrencyException)
        //        {
        //            if (!CustomerExists(customer.Code))
        //            {
        //                return NotFound();
        //            }
        //            else
        //            {
        //                throw;
        //            }
        //        }
        //        return RedirectToAction(nameof(Index));
        //    }
        //    return View(customer);
        //}

        ////// GET: Customer/Delete/5
        //public async Task<IActionResult> Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var customer = await _context.Customer
        //        .FirstOrDefaultAsync(m => m.Id == id);
        //    if (customer == null)
        //    {
        //        return NotFound();
        //    }

        //    return View(customer);
        //}

        //// POST: Customer/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> DeleteConfirmed(int id)
        //{
        //    var customer = await _context.Customer.FindAsync(id);
        //    _context.Customer.Remove(customer);
        //    await _context.SaveChangesAsync();
        //    TempData["StatusMessage"] = "Customer Deleted Successfully !!";
        //    return RedirectToAction(nameof(Index));
        //}

        private bool CustomerExists(string Code)
        {
            return _context.Customer.Any(e => e.Code == Code);
        }


        public IActionResult GetMembership()
        {
            var value = (Request.Query["filter[filters][0][value]"]).ToString();

            IEnumerable<Customer> customers;
            if (!_cache.TryGetValue("Customers", out customers))
            {
                // Key not in cache, so get data.
                customers = _context.Customer.ToList();

                _cache.Set("Customers", customers);
            }
            if (value != "")
                customers = customers.Where(x => x.Is_Member == true && x.Name.Contains(value));
            return Ok(customers);
        }

        public IActionResult SearchMembership(string text, string customer = "")
        {
            IEnumerable<Customer> customers;
            if (!_cache.TryGetValue("Customers", out customers))
            {
                // Key not in cache, so get data.
                customers = _context.Customer.ToList();

                _cache.Set("Customers", customers);
            }
            if (customer == "")
                customers = customers.Where(x => x.Is_Member == true);
            else if (customer == "Credit")
                customers = customers.Where(x => x.Type == "Credit");
            customers = customers.Where(x =>
            (!string.IsNullOrEmpty(x.Name) && x.Name.ToLower().Contains(text)) ||
            (!string.IsNullOrEmpty(x.Membership_Number) && x.Membership_Number.ToLower().Contains(text)) ||
            (!string.IsNullOrEmpty(x.Membership_Number_Old) && x.Membership_Number_Old.ToLower().Contains(text)) ||
            (!string.IsNullOrEmpty(x.Barcode) && x.Barcode.ToLower().Contains(text)) ||
            (!string.IsNullOrEmpty(x.Mobile1) && x.Mobile1.ToLower().Contains(text)));
            return Ok(customers);
        }

        public IActionResult GetMembershipByNumber(string MembershipNumber)
        {
            IEnumerable<Customer> customers = customers = _context.Customer.Where(x => x.Is_Member == true && x.Membership_Number == MembershipNumber);

            return Ok(customers);
        }




        public IActionResult CreateMembership()
        {
            return View();
        }


        [HttpPost]

        public IActionResult CreateMembership([FromBody] Customer customer)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    customer.Is_Member = true;
                    customer.Member_Id = _context.Customer.Where(x => x.Is_Member == true && x.Member_Id != null).Select(x => x.Member_Id).DefaultIfEmpty(0).Max() + 1;
                    Store store = _context.Store.FirstOrDefault();
                    customer.Membership_Number = store.INITIAL + "-" + Convert.ToInt32(customer.Member_Id).ToString("000000");
                    customer.Created_By = User.Identity.Name;
                    customer.Registration_Date = DateTime.Now;
                    customer.CustomerDiscGroup = "RSP";
                    customer.CustomerPriceGroup = "RSP";
                    customer.MembershipDiscGroup = "CATEGORY D";


                    _context.Add(customer);
                    _context.SaveChanges();

                    //update cache
                    IEnumerable<Customer> customers;
                    if (!_cache.TryGetValue("Customers", out customers))
                    {
                        // Key not in cache, so get data.
                        customers = _context.Customer.ToList();

                        _cache.Set("Customers", customers);
                    }
                    customers.ToList().Add(customer);
                    _cache.Set("Customer", customers);

                    NavPostData navPost = new NavPostData(_context, _mapper);
                    BackgroundJob.Enqueue(() => navPost.PostCustomer());
                    return Ok(new { StatusMessage = "Membership Created Successfully !!", Membership = customer });
                }
                catch (Exception ex)
                {
                    if (ex.Message.Contains("'UniqueMobileNumber") || ex.InnerException.Message.Contains("UniqueMobileNumber"))
                        return StatusCode(409, new { StatusMessage = "Mobile Number Already Register !!" });
                    else if (ex.Message.Contains("idx_unique_member_id") || ex.InnerException.Message.Contains("idx_unique_member_id"))
                        return CreateMembership(customer);
                    else
                        return StatusCode(500, new { StatusMessage = ex.Message });

                    //TempData["StatusMessage"] = "Customer Created Successfully !!";

                }
            }
            return StatusCode(400, new { StatusMessage = "Not Valid" });

        }



        public IActionResult GetCreditCustomerr()
        {
            var value = (Request.Query["filter[filters][0][value]"]).ToString();

            IEnumerable<Customer> customers;
            if (!_cache.TryGetValue("Customers", out customers))
            {
                // Key not in cache, so get data.
                customers = _context.Customer.ToList();

                _cache.Set("Customers", customers);
            }
            if (value != "")
                customers = customers.Where(x => x.Name.Contains(value));
            return Ok(customers);
        }
    }
}

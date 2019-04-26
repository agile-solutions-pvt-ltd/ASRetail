using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using POS.Core;
using POS.DTO;

namespace POS.UI.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        private readonly UserManager<IdentityUser> _userManager;
        private readonly SignInManager<IdentityUser> _signInManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly ILogger _logger;
        private readonly IOptions<AppSettings> _appSettings;
        private readonly EntityCore _context;

        public AccountController(
            UserManager<IdentityUser> userManager,
            SignInManager<IdentityUser> signInManager,
            RoleManager<IdentityRole> roleManager,
            ILoggerFactory loggerFactory,
            IOptions<AppSettings> appSettings,
            EntityCore context)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
            _context = context;
            _logger = loggerFactory.CreateLogger<AccountController>();
            _appSettings = appSettings;
        }

        //
        // GET: /Account/Login
        [HttpGet]
        [AllowAnonymous]
        public IActionResult Login(string returnUrl = null)
        {
            ViewData["ReturnUrl"] = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model, string returnUrl = null)
        {
            ViewData["ReturnUrl"] = returnUrl;
            if (ModelState.IsValid)
            {
                // This doesn't count login failures towards account lockout
                // To enable password failures to trigger account lockout, set lockoutOnFailure: true

                var result = await _signInManager.PasswordSignInAsync(model.Email, model.Password, model.RememberMe, lockoutOnFailure: false);
                if (!result.Succeeded && !result.RequiresTwoFactor && !result.IsLockedOut)
                {
                    var user = await _userManager.FindByEmailAsync(model.Email);
                    if (user != null)
                    {
                        //check if user is in session
                       // _context.Settlement.Any(x => x.UserId == user.Id && x.Status == "Open");

                        result = await _signInManager.PasswordSignInAsync(user, model.Password, model.RememberMe, lockoutOnFailure: false);
                    }
                }
                if (result.Succeeded)
                {
                    _logger.LogInformation(1, "User logged in.");
                    return RedirectToLocal(returnUrl);
                }
                if (result.RequiresTwoFactor)
                {
                    return RedirectToAction(nameof(SendCode), new { ReturnUrl = returnUrl, RememberMe = model.RememberMe });
                }
                if (result.IsLockedOut)
                {
                    _logger.LogWarning(2, "User account locked out.");
                    return View("Lockout");
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Invalid login attempt.");
                    return View(model);
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }


       

        //
        // GET: /Account/Register
        [HttpGet]
        [AllowAnonymous]
        public IActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
                var result = await _userManager.CreateAsync(user, model.Password);
                if (result.Succeeded)
                {
                    // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=532713
                    // Send an email with this link
                    //var code = await _userManager.GenerateEmailConfirmationTokenAsync(user);
                    //var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = code }, protocol: HttpContext.Request.Scheme);
                    //await _emailSender.SendEmailAsync(model.Email, "Confirm your account",
                    //    "Please confirm your account by clicking this link: <a href=\"" + callbackUrl + "\">link</a>");
                    await _signInManager.SignInAsync(user, isPersistent: false);
                    _logger.LogInformation(3, "User created a new account with password.");
                    return RedirectToAction("Index", "Home", new { Area = "" });
                }
                AddErrors(result);
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LogOff()
        {
            await _signInManager.SignOutAsync();
            _logger.LogInformation(4, "User logged out.");
            Response.Cookies.Append(User.Identity.Name, "", new CookieOptions()
            {
                Expires = DateTime.Now.AddDays(-1)
            });
            return RedirectToAction("Login", "Account");
        }

        //
        // POST: /Account/ExternalLogin
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public IActionResult ExternalLogin(string provider, string returnUrl = null)
        {
            // Request a redirect to the external login provider.
            var redirectUrl = Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl });
            var properties = _signInManager.ConfigureExternalAuthenticationProperties(provider, redirectUrl);
            return new ChallengeResult(provider, properties);
        }

        //
        // GET: /Account/ExternalLoginCallback
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> ExternalLoginCallback(string returnUrl = null)
        {
            var info = await _signInManager.GetExternalLoginInfoAsync();
            if (info == null)
            {
                return RedirectToAction(nameof(Login));
            }

            // Sign in the user with this external login provider if the user already has a login.
            var result = await _signInManager.ExternalLoginSignInAsync(info.LoginProvider, info.ProviderKey, isPersistent: false);
            if (result.Succeeded)
            {
                _logger.LogInformation(5, "User logged in with {Name} provider.", info.LoginProvider);
                return RedirectToLocal(returnUrl);
            }
            if (result.RequiresTwoFactor)
            {
                return RedirectToAction(nameof(SendCode), new { ReturnUrl = returnUrl });
            }
            if (result.IsLockedOut)
            {
                return View("Lockout");
            }
            else
            {
                // If the user does not have an account, then ask the user to create an account.
                ViewData["ReturnUrl"] = returnUrl;
                ViewData["LoginProvider"] = info.LoginProvider;
                var email = info.Principal.FindFirstValue(ClaimTypes.Email);
                return View("ExternalLoginConfirmation", new ExternalLoginConfirmationViewModel { Email = email });
            }
        }

        //
        // POST: /Account/ExternalLoginConfirmation
        //[HttpPost]
        //[AllowAnonymous]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> ExternalLoginConfirmation(ExternalLoginConfirmationViewModel model, string returnUrl = null)
        //{
        //    if (_signInManager.IsSignedIn(User))
        //    {
        //        return RedirectToAction(nameof(ManageController.Index), "Manage");
        //    }

        //    if (ModelState.IsValid)
        //    {
        //        // Get the information about the user from the external login provider
        //        var info = await _signInManager.GetExternalLoginInfoAsync();
        //        if (info == null)
        //        {
        //            return View("ExternalLoginFailure");
        //        }
        //        var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
        //        var result = await _userManager.CreateAsync(user);
        //        if (result.Succeeded)
        //        {
        //            result = await _userManager.AddLoginAsync(user, info);
        //            if (result.Succeeded)
        //            {
        //                await _signInManager.SignInAsync(user, isPersistent: false);
        //                _logger.LogInformation(6, "User created an account using {Name} provider.", info.LoginProvider);
        //                return RedirectToLocal(returnUrl);
        //            }
        //        }
        //        AddErrors(result);
        //    }

        //    ViewData["ReturnUrl"] = returnUrl;
        //    return View(model);
        //}

        // GET: /Account/ConfirmEmail
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> ConfirmEmail(string userId, string code)
        {
            if (userId == null || code == null)
            {
                return View("Error");
            }
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return View("Error");
            }
            var result = await _userManager.ConfirmEmailAsync(user, code);
            return View(result.Succeeded ? "ConfirmEmail" : "Error");
        }

        //
        // GET: /Account/ForgotPassword
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ForgotPassword()
        {
            return View();
        }

        //
        // POST: /Account/ForgotPassword
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ForgotPassword(ForgotPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = await _userManager.FindByNameAsync(model.Email);
                if (user == null || !(await _userManager.IsEmailConfirmedAsync(user)))
                {
                    // Don't reveal that the user does not exist or is not confirmed
                    return View("ForgotPasswordConfirmation");
                }

                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=532713
                // Send an email with this link
                //var code = await _userManager.GeneratePasswordResetTokenAsync(user);
                //var callbackUrl = Url.Action("ResetPassword", "Account", new { userId = user.Id, code = code }, protocol: HttpContext.Request.Scheme);
                //await _emailSender.SendEmailAsync(model.Email, "Reset Password",
                //   "Please reset your password by clicking here: <a href=\"" + callbackUrl + "\">link</a>");
                //return View("ForgotPasswordConfirmation");
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ForgotPasswordConfirmation
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ForgotPasswordConfirmation()
        {
            return View();
        }

        //
        // GET: /Account/ResetPassword
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ResetPassword(string code = null)
        {
            return code == null ? View("Error") : View();
        }

        //
        // POST: /Account/ResetPassword
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ResetPassword(ResetPasswordViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            var user = await _userManager.FindByNameAsync(model.Email);
            if (user == null)
            {
                // Don't reveal that the user does not exist
                return RedirectToAction(nameof(AccountController.ResetPasswordConfirmation), "Account");
            }
            var result = await _userManager.ResetPasswordAsync(user, model.Code, model.Password);
            if (result.Succeeded)
            {
                return RedirectToAction(nameof(AccountController.ResetPasswordConfirmation), "Account");
            }
            AddErrors(result);
            return View();
        }

        //
        // GET: /Account/ResetPasswordConfirmation
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ResetPasswordConfirmation()
        {
            return View();
        }

        //
        // GET: /Account/SendCode
        [HttpGet]
        [AllowAnonymous]
        public async Task<ActionResult> SendCode(string returnUrl = null, bool rememberMe = false)
        {
            var user = await _signInManager.GetTwoFactorAuthenticationUserAsync();
            if (user == null)
            {
                return View("Error");
            }
            var userFactors = await _userManager.GetValidTwoFactorProvidersAsync(user);
            var factorOptions = userFactors.Select(purpose => new SelectListItem { Text = purpose, Value = purpose }).ToList();
            return View(new SendCodeViewModel { Providers = factorOptions, ReturnUrl = returnUrl, RememberMe = rememberMe });
        }

        ////
        //// POST: /Account/SendCode
        //[HttpPost]
        //[AllowAnonymous]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> SendCode(SendCodeViewModel model)
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return View();
        //    }

        //    var user = await _signInManager.GetTwoFactorAuthenticationUserAsync();
        //    if (user == null)
        //    {
        //        return View("Error");
        //    }

        //    // Generate the token and send it
        //    var code = await _userManager.GenerateTwoFactorTokenAsync(user, model.SelectedProvider);
        //    if (string.IsNullOrWhiteSpace(code))
        //    {
        //        return View("Error");
        //    }

        //    var message = "Your security code is: " + code;
        //    if (model.SelectedProvider == "Email")
        //    {
        //        await _emailSender.SendEmailAsync(await _userManager.GetEmailAsync(user), "Security Code", message);
        //    }
        //    else if (model.SelectedProvider == "Phone")
        //    {
        //        await _smsSender.SendSmsAsync(await _userManager.GetPhoneNumberAsync(user), message);
        //    }

        //    return RedirectToAction(nameof(VerifyCode), new { Provider = model.SelectedProvider, ReturnUrl = model.ReturnUrl, RememberMe = model.RememberMe });
        //}

        ////
        //// GET: /Account/VerifyCode
        //[HttpGet]
        //[AllowAnonymous]
        //public async Task<IActionResult> VerifyCode(string provider, bool rememberMe, string returnUrl = null)
        //{
        //    // Require that the user has already logged in via username/password or external login
        //    var user = await _signInManager.GetTwoFactorAuthenticationUserAsync();
        //    if (user == null)
        //    {
        //        return View("Error");
        //    }
        //    return View(new VerifyCodeViewModel { Provider = provider, ReturnUrl = returnUrl, RememberMe = rememberMe });
        //}

        ////
        //// POST: /Account/VerifyCode
        //[HttpPost]
        //[AllowAnonymous]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> VerifyCode(VerifyCodeViewModel model)
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return View(model);
        //    }

        //    // The following code protects for brute force attacks against the two factor codes.
        //    // If a user enters incorrect codes for a specified amount of time then the user account
        //    // will be locked out for a specified amount of time.
        //    var result = await _signInManager.TwoFactorSignInAsync(model.Provider, model.Code, model.RememberMe, model.RememberBrowser);
        //    if (result.Succeeded)
        //    {
        //        return RedirectToLocal(model.ReturnUrl);
        //    }
        //    if (result.IsLockedOut)
        //    {
        //        _logger.LogWarning(7, "User account locked out.");
        //        return View("Lockout");
        //    }
        //    else
        //    {
        //        ModelState.AddModelError("", "Invalid code.");
        //        return View(model);
        //    }
        //}

        #region Helpers

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }
        }

        private async Task<IdentityUser> GetCurrentUserAsync()
        {
            return await _userManager.GetUserAsync(HttpContext.User);
        }

        private IActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction(nameof(HomeController.Index), "Home");
            }
        }
        #endregion

        #region user
        public IActionResult Users()
        {
            var users = _context.UserViewModel;
            return View(users);
        }
        [HttpGet]
        public IActionResult UserCreate()
        {
            ViewData["Roles"] = new SelectList(_roleManager.Roles, "Name", "Name");
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UserCreate(UserViewModel user)
        {
            if (ModelState.IsValid)
            {
                var userResult = await _userManager.CreateAsync(new IdentityUser()
                {
                    Email = user.Email,
                    UserName = user.UserName
                }, user.Password);
                if (userResult.Succeeded)
                {
                    IdentityUser newUser = await _userManager.FindByNameAsync(user.UserName);
                    await _userManager.AddToRoleAsync(newUser, user.Role);
                    ViewData["StatusMessage"] = "User Created Successfully !!";
                    return RedirectToAction("Users");
                }

                else
                    ModelState.AddModelError("error", userResult.ToString());
            }
            ViewData["Roles"] = new SelectList(_roleManager.Roles, "Name", "Name");
            return View(user);
        }
        [HttpGet]
        public async Task<IActionResult> UserEdit(string id)
        {
            ViewData["Roles"] = new SelectList(_roleManager.Roles, "Name", "Name");
            return View(await _context.UserViewModel.FirstOrDefaultAsync(x => x.Id == id));
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UserEdit(UserViewModel user)
        {
            if (ModelState.IsValid)
            {
                var userCheck = await _userManager.FindByIdAsync(user.Id);
                if (userCheck != null)
                {
                    userCheck.UserName = user.UserName;
                    userCheck.Email = user.Email;
                    var userResult = await _userManager.UpdateAsync(userCheck);
                    if (userResult.Succeeded)
                    {
                        var roles = await _userManager.GetRolesAsync(userCheck);
                        await _userManager.RemoveFromRolesAsync(userCheck, roles.ToArray());
                        await _userManager.AddToRoleAsync(userCheck, user.Role);
                        TempData["StatusMessage"] = "User Updated Successfully !!";
                        return RedirectToAction("Users");
                    }
                    else
                        ModelState.AddModelError("error", userResult.ToString());
                }
                else
                    ModelState.AddModelError("error", "User Not Found !!");
            }
            ViewData["Roles"] = new SelectList(_roleManager.Roles, "Name", "Name");
            return View(user);
        }
        [HttpGet]
        public async Task<IActionResult> UserDelete(string id)
        {
            if (ModelState.IsValid)
            {
                var userCheck = await _userManager.FindByIdAsync(id);
                if (userCheck != null)
                {
                    var userResult = await _userManager.DeleteAsync(userCheck);
                    TempData["StatusMessage"] = "User Deleted Successfully !!";
                    return RedirectToAction("Users");
                }
                else
                    TempData["StatusMessage"] = "User Not Found !!";

            }
            TempData["StatusMessage"] = "User Deletion Unsuccessfull, Try again later !!";
            return RedirectToAction("Users");
        }


        #endregion

        #region Role
        public IActionResult Roles()
        {
            IEnumerable<IdentityRole> user = _roleManager.Roles;
            return View(user);

        }
        [HttpGet]
        public IActionResult RoleCreate()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RoleCreate(IdentityRole role)
        {
            if (ModelState.IsValid)
            {
                var roleResult = await _roleManager.CreateAsync(new IdentityRole(role.Name));
                if (roleResult.Succeeded)
                {
                    TempData["StatusMessage"] = "Role Created Successfully !!";
                    return RedirectToAction("Roles");
                }
                else
                    ModelState.AddModelError("error", roleResult.ToString());
            }
            return View(role);
        }
        [HttpGet]
        public async Task<IActionResult> RoleEdit(string id)
        {
            return View(await _roleManager.FindByIdAsync(id));
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RoleEdit(IdentityRole role)
        {
            if (ModelState.IsValid)
            {
                var roleCheck = await _roleManager.FindByIdAsync(role.Id);
                if (roleCheck != null)
                {
                    roleCheck.Name = role.Name;
                    var roleResult = await _roleManager.UpdateAsync(roleCheck);
                    if (roleResult.Succeeded)
                    {
                        TempData["StatusMessage"] = "Role Updated Successfully !!";
                        return RedirectToAction("Roles");
                    }
                    else
                        ModelState.AddModelError("error", roleResult.ToString());
                }
                else
                    ModelState.AddModelError("error", "Role Not Found !!");
            }
            return View(role);
        }
        [HttpGet]
        public async Task<IActionResult> RoleDelete(string id)
        {
            if (ModelState.IsValid)
            {
                var roleCheck = await _roleManager.FindByIdAsync(id);
                if (roleCheck != null)
                {
                    var roleResult = await _roleManager.DeleteAsync(roleCheck);
                    TempData["StatusMessage"] = "Role Deleted Successfully !!";
                    return RedirectToAction("Roles");
                }
                else
                    TempData["StatusMessage"] = "Role Not Fount !!";
            }
            TempData["StatusMessage"] = "Role Deletion Unsuccessfull, Try again later !!";
            return RedirectToAction("Roles");
        }

        [HttpGet]
        public IActionResult RoleWisePermission(string id)
        {
            ViewData["Roles"] = new SelectList(_roleManager.Roles, "Id", "Name");
            RoleWisePermissionCommon data = new RoleWisePermissionCommon();
            if (id != null)
            {
                data.roleWiseUserPermission = _context.RoleWisePermission.FirstOrDefault(x => x.RoleId == id);
                data.roleWiseMenuPermissions = _context.RoleWiseMenuPermission.Where(x => x.RoleId == id).ToList();               
            }
            return View(data);
        }

        //api post
        [HttpPost]
        [AllowAnonymous]
        public IActionResult RoleWisePermission([FromBody] RoleWisePermissionCommon permission)
        {
            if (!ModelState.IsValid)
                return StatusCode(400);
            try
            {
                //first delete
                RoleWisePermission oldPermission = _context.RoleWisePermission.FirstOrDefault(x => x.RoleId == permission.roleWiseUserPermission.RoleId);
                if (oldPermission != null)
                    _context.RoleWisePermission.Remove(oldPermission);
                List<RoleWiseMenuPermission> oldMenuPermission = _context.RoleWiseMenuPermission.Where(x => x.RoleId == permission.roleWiseUserPermission.RoleId).ToList();
                if (oldMenuPermission != null)
                    _context.RoleWiseMenuPermission.RemoveRange(oldMenuPermission);

                //then add
                _context.RoleWisePermission.Add(permission.roleWiseUserPermission);
                _context.RoleWiseMenuPermission.AddRange(permission.roleWiseMenuPermissions);

                //finally save all changes
                _context.SaveChanges();
                TempData["StatusMessage"] = "Saved Successfully !!";
                return Ok(permission.roleWiseUserPermission.RoleId);
            }
            catch
            {
                ModelState.AddModelError("Error", "Error occour, try again later !!");
                return StatusCode(500);
            }

        }




        [HttpGet]
        public IActionResult RoleWiseUserPermission()
        {
            var roleName = ((ClaimsIdentity)User.Identity).Claims
                 .Where(c => c.Type == ClaimTypes.Role)
                 .Select(c => c.Value).FirstOrDefault();

           //Task<string> roleId =  _roleManager.GetRoleIdAsync(new IdentityRole(role));
           // roleId.Wait();


            var role =_roleManager.FindByNameAsync(roleName);
            var roleId = role.Result.Id;
            RoleWisePermissionCommon data = new RoleWisePermissionCommon();
            if (role != null)
            {
                data.roleWiseUserPermission = _context.RoleWisePermission.FirstOrDefault(x => x.RoleId == roleId);
               // data.roleWiseMenuPermissions = _context.RoleWiseMenuPermission.Where(x => x.RoleId == id).ToList();
            }
            return Ok(data);
        }

        [HttpGet]
        public IActionResult RoleWiseMenuPermission()
        {
            var roleName = ((ClaimsIdentity)User.Identity).Claims
                 .Where(c => c.Type == ClaimTypes.Role)
                 .Select(c => c.Value).FirstOrDefault();

            
            var role = _roleManager.FindByNameAsync(roleName);
            var roleId = role.Result.Id;
           IList<RoleWiseMenuPermission> permission = _context.RoleWiseMenuPermission.Where(x => x.RoleId == roleId).Include(x => x.Menu).ToList();
           
            return Ok(permission);
        }
        #endregion


    }
}
using AutoMapper;
using Hangfire;
using Hangfire.Dashboard;
using Hangfire.SqlServer;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using POS.Core;
using POS.DTO;
using POS.UI.Models;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI
{
    public class Startup
    {

        public IConfiguration Configuration { get; }
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;

        }



        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });

            services.AddDbContext<EntityCore>(options =>
                options.UseSqlServer(
                    Configuration.GetConnectionString("DefaultConnection")));
            //services.AddDefaultIdentity<IdentityUser>()
            //    .AddEntityFrameworkStores<EntityCore>();

            services.AddIdentity<IdentityUser, IdentityRole>()
                    .AddEntityFrameworkStores<EntityCore>()
                    .AddDefaultTokenProviders();

            //Password Strength Setting
            services.Configure<IdentityOptions>(options =>
            {
                // Password settings
                options.Password.RequireDigit = true;
                options.Password.RequiredLength = 4;
                options.Password.RequireNonAlphanumeric = false;
                options.Password.RequireUppercase = false;
                options.Password.RequireLowercase = false;
                options.Password.RequiredUniqueChars = 2;

                // Lockout settings
                options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(30);
                options.Lockout.MaxFailedAccessAttempts = 10;
                options.Lockout.AllowedForNewUsers = true;

                // User settings
                options.User.RequireUniqueEmail = true;
            });

            //Setting the Account Login page
            services.ConfigureApplicationCookie(options =>
            {
                // Cookie settings
                options.Cookie.HttpOnly = true;
                options.ExpireTimeSpan = TimeSpan.FromDays(5);
                options.Cookie.Expiration = TimeSpan.FromDays(5);
                options.LoginPath = "/Account/Login"; // If the LoginPath is not set here,
                                                      // ASP.NET Core will default to /Account/Login
                options.LogoutPath = "/Account/Logout"; // If the LogoutPath is not set here,
                                                        // ASP.NET Core will default to /Account/Logout
                options.AccessDeniedPath = "/Account/AccessDenied"; // If the AccessDeniedPath is
                                                                    // not set here, ASP.NET Core 
                                                                    // will default to 
                                                                    // /Account/AccessDenied

                options.SlidingExpiration = true;

            });


            services.AddAutoMapper();


            services.AddMemoryCache();

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1)
                .AddJsonOptions(x => x.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore); ;


            services.AddSingleton<InMemoryCache>();

            services.AddSession(options =>
            {
                options.Cookie.IsEssential = true; // make the session cookie Essential
                options.IdleTimeout = TimeSpan.FromDays(5);//You can set Time   
            });


            // Add Hangfire services.
            //services.AddHangfire(configuration => configuration
            //    //.setdatacompatibilitylevel(compatibilitylevel.version_170)
            //    //.usesimpleassemblynametypeserializer()
            //    //.userecommendedserializersettings()
            //    .UseSqlServerStorage(Configuration.GetConnectionString("DefaultConnection"), new SqlServerStorageOptions
            //    {
            //        CommandBatchMaxTimeout = TimeSpan.FromDays(2),
            //        SlidingInvisibilityTimeout = TimeSpan.FromMinutes(20),
            //        QueuePollInterval = TimeSpan.Zero,
            //        UseRecommendedIsolationLevel = true,
            //        UsePageLocksOnDequeue = true,
            //        DisableGlobalLocks = true
            //    }));

            //services.AddHangfireServer();
            services.AddHangfire(opt => opt.UseSqlServerStorage(Configuration.GetConnectionString("DefaultConnection"),
    new SqlServerStorageOptions
    {
        CommandBatchMaxTimeout = TimeSpan.FromMinutes(5),
        QueuePollInterval = TimeSpan.FromMinutes(30),
        UseRecommendedIsolationLevel = true,
        UsePageLocksOnDequeue = true,
        DisableGlobalLocks = true
    }));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, IServiceProvider service)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseDatabaseErrorPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseSession();
            app.UseCookiePolicy();





            app.UseAuthentication();

            app.UseHangfireDashboard(options: new DashboardOptions()
            {
                Authorization = new IDashboardAuthorizationFilter[]
           {
                 new Helper.HangFireAuthorizationFilter()
           },
                StatsPollingInterval = 30000
            });
           
            app.UseHangfireServer();
            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });

            Task t = CreateUserRoles(service);
            t.Wait();



            //run denomination scheduler daily
            // RecurringJob.AddOrUpdate(() => POSScheduler(), Cron.Daily);


        }


        private async Task CreateUserRoles(IServiceProvider serviceProvider)
        {
            var RoleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
            var UserManager = serviceProvider.GetRequiredService<UserManager<IdentityUser>>();
            //serviceProvider.GetRequiredService<SignInManager<ApplicationUser>>();

            IdentityResult roleResult;
            //Adding Admin Role
            var roleCheck = await RoleManager.RoleExistsAsync("Administrator");
            if (!roleCheck)
            {
                //create the roles and seed them to the database
                roleResult = await RoleManager.CreateAsync(new IdentityRole("Administrator"));
            }
            //Adding Admin User
            var userCheck = await UserManager.FindByNameAsync("Admin");
            if (userCheck == null)
            {
                var userResult = await UserManager.CreateAsync(new ApplicationUser()
                {
                    UserName = "Admin",
                    Email = "Admin@gmail.com"
                }, "Admin@123");
            }
            //Assign Admin role to the main User here we have given our newly registered 
            //login id for Admin management
            IdentityUser user = await UserManager.FindByNameAsync("Admin");
            var roles = await UserManager.GetRolesAsync(user);
            await UserManager.RemoveFromRolesAsync(user, roles.ToArray());
            await UserManager.AddToRoleAsync(user, "Administrator");
        }



    }
}

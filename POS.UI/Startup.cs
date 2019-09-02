using AutoMapper;
using Hangfire;
using Hangfire.Dashboard;
using Hangfire.SqlServer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.ResponseCompression;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using POS.UI.Models;
using System;
using System.IO.Compression;
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


#pragma warning disable CS0618 // 'ServiceCollectionExtensions.AddAutoMapper(IServiceCollection)' is obsolete: 'This overload is error prone and it will be removed. Please pass the assemblies to scan explicitly. You can use AppDomain.CurrentDomain.GetAssemblies() if that works for you.'
            services.AddAutoMapper();
#pragma warning restore CS0618 // 'ServiceCollectionExtensions.AddAutoMapper(IServiceCollection)' is obsolete: 'This overload is error prone and it will be removed. Please pass the assemblies to scan explicitly. You can use AppDomain.CurrentDomain.GetAssemblies() if that works for you.'
            services.Configure<GzipCompressionProviderOptions>(options => options.Level = CompressionLevel.Fastest);
            services.AddResponseCompression(options =>
            {
                options.Providers.Add<GzipCompressionProvider>();
                options.EnableForHttps = true;
            });

            services.AddMemoryCache(options =>
            {
                options.CompactionPercentage = 1;
               

            });
            services.AddResponseCaching();

            services.AddSingleton<IKendoGrid, KendoGrid>();

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
            services.AddHangfire(opt => opt.UseSqlServerStorage(Configuration.GetConnectionString("HangFireConnection"),
    new SqlServerStorageOptions
    {
        PrepareSchemaIfNecessary = true,
        CommandBatchMaxTimeout = TimeSpan.FromMinutes(5),
        QueuePollInterval = TimeSpan.Zero,
        JobExpirationCheckInterval = TimeSpan.FromMinutes(30),
        CountersAggregateInterval = TimeSpan.FromMinutes(5),

        UseRecommendedIsolationLevel = true,
        UsePageLocksOnDequeue = true,
        DisableGlobalLocks = true
    }));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, IServiceProvider service)
        {
            //if (env.IsDevelopment())
            //{
            //    app.UseDeveloperExceptionPage();
            //    app.UseDatabaseErrorPage();
            //}
            //else
            //{
            //    app.UseExceptionHandler("/Home/Error");
            //    app.UseHsts();
            //}

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseSession();
            app.UseCookiePolicy();
            app.UseResponseCompression();




            app.UseAuthentication();

            app.UseResponseCaching();
            var options = new BackgroundJobServerOptions
            {
                WorkerCount = 2,//Environment.ProcessorCount,
                HeartbeatInterval = TimeSpan.FromMinutes(5)
            };
            app.UseHangfireServer(options);
            app.UseHangfireDashboard(options: new DashboardOptions()
            {
                Authorization = new IDashboardAuthorizationFilter[]
           {
                 new Helper.HangFireAuthorizationFilter()
           },
                StatsPollingInterval = 600000
            });


            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });

            Task t = CreateUserRoles(service);
            t.Wait();
            ClearAnyPendingJob();



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
        private void ClearAnyPendingJob()
        {
            //sql to delete and create hangfiredatabase
            JobStorage.Current?.GetMonitoringApi()?.PurgeJobs();
        }



    }



}

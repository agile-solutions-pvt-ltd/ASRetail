using POS.DTO;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Protocols;

namespace POS.Core
{
    public class EntityCore : IdentityDbContext
    {

        //public IConfiguration Configuration { get; }


        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    optionsBuilder.UseSqlServer("DefaultConnection");
        //}
        //public EntityCore() : base()
        //{
           

        //}

        public EntityCore(DbContextOptions<EntityCore> options)
            : base(options)
        {
            //ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;

        }


        //add model here to create table         
        public virtual DbSet<Store> Store { get; set; }
        public virtual DbSet<ItemCategory> ItemCategory { get; set; }
        public virtual DbSet<ItemGroup> ItemGroup { get; set; }
        public virtual DbSet<ItemType> ItemType { get; set; }
        public virtual DbSet<ItemFOC> ItemFOC { get; set; }
        public virtual DbSet<SalesInvoice> SalesInvoice { get; set; }
        public virtual DbSet<SalesInvoiceItems> SalesInvoiceItems { get; set; }
        public virtual DbSet<SalesInvoiceTmp> SalesInvoiceTmp { get; set; }
        public virtual DbSet<SalesInvoiceItemsTmp> SalesInvoiceItemsTmp { get; set; }
        public virtual DbSet<SalesInvoiceBill> SalesInvoiceBill { get; set; }
        public virtual DbSet<CreditNote> CreditNote { get; set; }
        public virtual DbSet<CreditNoteItems> CreditNoteItem { get; set; }
        public virtual DbSet<Customer> Customer { get; set; }
        public virtual DbSet<Item> Item { get; set; }
        public virtual DbSet<ItemViewModel> ItemViewModel { get; set; }
        public virtual DbSet<ItemBarCode> ItemBarCode { get; set; }
        public virtual DbSet<ItemPrice> ItemPrice { get; set; }
        public virtual DbSet<ItemDiscount> ItemDiscount { get; set; }
        public virtual DbSet<ItemUpdateTrigger> ItemUpdateTrigger { get; set; }



        public virtual DbSet<Denomination> Denomination { get; set; }
        public virtual DbSet<Terminal> Terminal { get; set; }

        public virtual DbSet<UserViewModel> UserViewModel { get; set; }
        public virtual DbSet<RoleWisePermission> RoleWisePermission { get; set; }
        public virtual DbSet<RoleWiseMenuPermission> RoleWiseMenuPermission { get; set; }

        public virtual DbSet<Menu> Menu { get; set; }
        public virtual DbSet<Settlement> Settlement { get; set; }
        public virtual DbSet<SettlementViewModel> SettlementViewModel { get; set; }
        public virtual DbSet<SettlementSummaryView> SettlementSummaryView { get; set; }

        public virtual DbSet<TodaySalesInvoicePaymentViewModel> TodaySalesInvoicePaymentViewModels { get; set; }

       

        public virtual DbSet<User> User { get; set; }


        public virtual DbSet<InvoiceMaterializedView> InvoiceMaterializedView { get; set; }

       
        public virtual DbSet<SpSalesInvoiceAggregateGet> SpSalesInvoiceAggregateGet { get; set; }

        public virtual DbSet<SalesInvoiceViewModel> SpSalesInvoiceSel { get; set; }

        
        public virtual DbSet<SalesVatBookReport> SalesVatBookReport { get; set; }


        public virtual DbSet<Company> Company { get; set; }
        public virtual DbSet<NavIntegrationService> NavIntegrationService { get; set; }

        public virtual DbSet<TerminalMapping> TerminalMapping { get; set; }
        public virtual DbSet<InvoicePrint> InvoicePrint { get; set; }

        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    // ignore a type that is not mapped to a database table
        //    // modelBuilder.Ignore<ApplicationUser>();

        //    modelBuilder.Entity<IdentityUserLogin>().HasKey(table => new {
        //        table.LoginProvider,
        //        table.ProviderKey
        //    });
        //}
    }
}

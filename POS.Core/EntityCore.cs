using POS.DTO;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.Core
{
    public class EntityCore : IdentityDbContext
    {
        
        public EntityCore(DbContextOptions<EntityCore> options)
            : base(options)
        {

        }


        //add model here to create table         
        public virtual DbSet<Store> Store { get; set; }
        public virtual DbSet<ItemCategory> ItemCategory { get; set; }
        public virtual DbSet<ItemGroup> ItemGroup { get; set; }
        public virtual DbSet<ItemType> ItemType { get; set; }
        public virtual DbSet<SalesInvoice> SalesInvoice { get; set; }
        public virtual DbSet<SalesInvoiceItems> SalesInvoiceItems { get; set; }
        public virtual DbSet<SalesInvoiceTmp> SalesInvoiceTmp { get; set; }
        public virtual DbSet<SalesInvoiceItemsTmp> SalesInvoiceItemsTmp { get; set; }
        public virtual DbSet<SalesInvoiceBill> SalesInvoiceBill { get; set; }
        public virtual DbSet<CreditNote> CreditNote { get; set; }
        public virtual DbSet<CreditNoteItems> CreditNoteItem { get; set; }
        public virtual DbSet<Customer> Customer { get; set; }
        public virtual DbSet<Item> Item { get; set; }

        public virtual DbSet<Denomination> Denomination { get; set; }
        public virtual DbSet<Terminal> Terminal { get; set; }

        public virtual DbSet<UserViewModel> UserViewModel { get; set; }
        public virtual DbSet<RoleWisePermission> RoleWisePermission { get; set; }
        public virtual DbSet<RoleWiseMenuPermission> RoleWiseMenuPermission { get; set; }

        public virtual DbSet<Menu> Menu { get; set; }
       



        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    // ignore a type that is not mapped to a database table
        //    modelBuilder.Ignore<ApplicationUser>();            
        //}
    }
}

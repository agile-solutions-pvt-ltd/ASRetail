using AutoMapper;
using System;

namespace POS.DTO
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<NavStoreInfo, Store>()
            .ForMember(dest => dest.ID, opts => opts.Ignore())
             .ForMember(dest => dest.INITIAL, opts => opts.MapFrom(src => src.Code))
            .ForMember(dest => dest.NAME, opts => opts.MapFrom(src => src.Name))
            .ForMember(dest => dest.COMPANY_NAME, opts => opts.MapFrom(src => src.Name_2))
             .ForMember(dest => dest.ADDRESS, opts => opts.MapFrom(src => src.Address))
            .ForMember(dest => dest.PHONE, opts => opts.MapFrom(src => src.Phone_No))
            .ForMember(dest => dest.PHONE_ALT, opts => opts.MapFrom(src => src.Phone_No_2))
            .ForMember(dest => dest.CustomerPriceGroup, opts => opts.MapFrom(src => src.Customer_Price_Group))
             .ForMember(dest => dest.FAX, opts => opts.MapFrom(src => src.Fax_No))
             .ForMember(dest => dest.EMAIL, opts => opts.MapFrom(src => src.E_Mail))
            .ForMember(dest => dest.WEBSITE, opts => opts.MapFrom(src => src.Home_Page))
            .ForMember(dest => dest.FISCAL_YEAR, opts => opts.Ignore());


            CreateMap<NAVItemCategory, ItemCategory>()
                 .ForMember(dest => dest.Code, opts => opts.MapFrom(src => src.code))
                 .ForMember(dest => dest.Name, opts => opts.MapFrom(src => src.displayName))
            .ForMember(dest => dest.HasChild, opts => opts.MapFrom(src => src.Has_Children))
             .ForMember(dest => dest.ParentCode, opts => opts.MapFrom(src => src.Parent_Category));



            CreateMap<NAVProductGroup, ItemGroup>()
                .ForMember(dest => dest.ItemCategoryCode, opts => opts.MapFrom(src => src.Item_Category_Code));

            CreateMap<NavItem, Item>()
                .ForMember(dest => dest.Id, opts => opts.MapFrom(src => src.id))
             .ForMember(dest => dest.Code, opts => opts.MapFrom(src => src.number))
             .ForMember(dest => dest.Name, opts => opts.MapFrom(src => src.displayName))
             .ForMember(dest => dest.Is_Active, opts => opts.MapFrom(src => src.blocked))
             .ForMember(dest => dest.VendorNumber, opts => opts.MapFrom(src => src.Vendor_No))
             .ForMember(dest => dest.Is_Vatable, opts => opts.MapFrom(src => src.Taxable))
              .ForMember(dest => dest.No_Discount, opts => opts.MapFrom(src => src.No_Discount))
             .ForMember(dest => dest.KeyInWeight, opts => opts.MapFrom(src => src.Key_In_Weight))
             .ForMember(dest => dest.DiscountGroup, opts => opts.MapFrom(src => src.itemdiscountgroup));

            CreateMap<NavBarCode, ItemBarCode>()
              .ForMember(dest => dest.BarCode, opts => opts.MapFrom(src => src.Cross_Reference_No))
              .ForMember(dest => dest.ItemCode, opts => opts.MapFrom(src => src.Item_No))
              .ForMember(dest => dest.Unit, opts => opts.MapFrom(src => src.Unit_of_Measure))
              .ForMember(dest => dest.IsActive, opts => opts.MapFrom(src => !src.Discontinue_Bar_Code));

            CreateMap<NavItemPrice, ItemPrice>()
                 .ForMember(dest => dest.Id, opts => opts.MapFrom(src => src.Id))
              .ForMember(dest => dest.ItemCode, opts => opts.MapFrom(src => src.Item_No))
              .ForMember(dest => dest.UnitPrice, opts => opts.MapFrom(src => src.Unit_Price))
              .ForMember(dest => dest.StartDate, opts => opts.MapFrom(src => src.Starting_Date.Value.Year == 1 ? null : src.Starting_Date))
              .ForMember(dest => dest.EndDate, opts => opts.MapFrom(src => src.Ending_Date.Value.Year == 1 ? null : src.Ending_Date))
               .ForMember(dest => dest.MinimumQuantity, opts => opts.MapFrom(src => src.Minimum_Quantity))
              .ForMember(dest => dest.AllowLineDiscount, opts => opts.MapFrom(src => src.Allow_Line_Disc))
              .ForMember(dest => dest.SalesType, opts => opts.MapFrom(src => src.Sales_Type))
              .ForMember(dest => dest.SalesCode, opts => opts.MapFrom(src => src.Sales_Code));

            CreateMap<NavItemDiscount, ItemDiscount>()
                 .ForMember(dest => dest.Id, opts => opts.MapFrom(src => src.Id))
              .ForMember(dest => dest.ItemType, opts => opts.MapFrom(src => src.Type))
             .ForMember(dest => dest.ItemCode, opts => opts.MapFrom(src => src.Code))
             .ForMember(dest => dest.DiscountPercent, opts => opts.MapFrom(src => src.linediscountpercentage))
              .ForMember(dest => dest.Location, opts => opts.MapFrom(src => src.Location_Code))
             .ForMember(dest => dest.StartDate, opts => opts.MapFrom(src => src.Starting_Date.Value.Year == 1 ? null : src.Starting_Date))
             .ForMember(dest => dest.EndDate, opts => opts.MapFrom(src => src.Ending_Date.Value.Year == 1 ? null : src.Ending_Date))
              .ForMember(dest => dest.StartTime, opts => opts.MapFrom(src => src.Starting_Time))
             .ForMember(dest => dest.EndTime, opts => opts.MapFrom(src => src.Ending_Time))
              .ForMember(dest => dest.MinimumQuantity, opts => opts.MapFrom(src => src.Minimum_Quantity))
               .ForMember(dest => dest.VendorNumber, opts => opts.MapFrom(src => src.Vendor_No))
             .ForMember(dest => dest.SalesCode, opts => opts.MapFrom(src => src.Sales_Code))
             .ForMember(dest => dest.SalesType, opts => opts.MapFrom(src => src.Sales_Type));


            CreateMap<SalesInvoiceTmp, SalesInvoice>()
                .ForMember(dest => dest.Total_Net_Amount_Roundup, opts => opts.Ignore())
                .ForMember(dest => dest.Total_Bill_Discount, opts => opts.Ignore())
                .ForMember(dest => dest.Total_Payable_Amount, opts => opts.Ignore())
                .ForMember(dest => dest.Tender_Amount, opts => opts.Ignore())
                .ForMember(dest => dest.Change_Amount, opts => opts.Ignore())
                .ForMember(dest => dest.IsNavSync, opts => opts.Ignore())
                .ForMember(dest => dest.NavSyncDate, opts => opts.Ignore())
                 .ForMember(dest => dest.SyncErrorCount, opts => opts.Ignore());


            CreateMap<SalesInvoiceItemsTmp, SalesInvoiceItems>()
                .ForMember(dest => dest.IsNavSync, opts => opts.Ignore())
                .ForMember(dest => dest.NavSyncDate, opts => opts.Ignore())
                 .ForMember(dest => dest.SyncErrorCount, opts => opts.Ignore());

            CreateMap<NavCustomer, Customer>()
               .ForMember(dest => dest.Code, opts => opts.MapFrom(src => src.id))
                .ForMember(dest => dest.Membership_Number, opts => opts.MapFrom(src => src.number))
               .ForMember(dest => dest.Name, opts => opts.MapFrom(src => src.displayName))
               .ForMember(dest => dest.Address, opts => opts.MapFrom(src => src.Address))
               .ForMember(dest => dest.Mobile1, opts => opts.MapFrom(src => src.phoneNumber))
                .ForMember(dest => dest.Email, opts => opts.MapFrom(src => src.email))
               .ForMember(dest => dest.Vat, opts => opts.MapFrom(src => src.taxRegistrationNumber))
               .ForMember(dest => dest.Type, opts => opts.MapFrom(src => src.type))
               .ForMember(dest => dest.CustomerDiscGroup, opts => opts.MapFrom(src => src.Customer_Disc_Group))
               .ForMember(dest => dest.CustomerPriceGroup, opts => opts.MapFrom(src => src.Customer_Price_Group))
               .ForMember(dest => dest.MembershipDiscGroup, opts => opts.MapFrom(src => src.Member_Disc_Group))
               .ForMember(dest => dest.Member_Id, opts => opts.MapFrom(src => src.SNo))
                .ForMember(dest => dest.Barcode, opts => opts.MapFrom(src => src.Member_Barcode))
                .ForMember(dest => dest.Membership_Number_Old, opts => opts.MapFrom(src => src.Membership_ID))
                .ForMember(dest => dest.IsNavSync, opts => opts.MapFrom(src => true))
                 .ForMember(dest => dest.NavSyncDate, opts => opts.MapFrom(src => DateTime.Now))
                   .ForMember(dest => dest.Registration_Date, opts => opts.MapFrom(src => src.Registration_Date.Year == 1 ? DateTime.Now : src.Registration_Date));

            CreateMap<Customer, NavCustomerPOST>()
              .ForMember(dest => dest.id, opts => opts.Ignore())
               .ForMember(dest => dest.number, opts => opts.MapFrom(src => src.Membership_Number))
              .ForMember(dest => dest.displayName, opts => opts.MapFrom(src => src.Name))
              .ForMember(dest => dest.phoneNumber, opts => opts.MapFrom(src => src.Mobile1))
              .ForMember(dest => dest.taxRegistrationNumber, opts => opts.MapFrom(src => src.Vat))
              .ForMember(dest => dest.Address, opts => opts.MapFrom(src => src.Address))
               .ForMember(dest => dest.Registration_Date, opts => opts.MapFrom(src => ((DateTime)src.Registration_Date.Value).ToString("yyyy-MM-dd")))
                .ForMember(dest => dest.VAT_Bus_Posting_Group, opts => opts.MapFrom(src => "SALE-LOCAL"))
               .ForMember(dest => dest.generalbuspostinggrp, opts => opts.MapFrom(src => "LOCAL"))
                .ForMember(dest => dest.Customer_Posting_Group, opts => opts.MapFrom(src => "MEMBER"))
                 .ForMember(dest => dest.Customer_Price_Group, opts => opts.MapFrom(src => src.CustomerPriceGroup))
                .ForMember(dest => dest.Customer_Disc_Group, opts => opts.MapFrom(src => src.CustomerDiscGroup))
                .ForMember(dest => dest.Member_Disc_Group, opts => opts.MapFrom(src => src.MembershipDiscGroup));


            CreateMap<NavRole, AspNetRoles>()
               .ForMember(dest => dest.Name, opts => opts.MapFrom(src => src.Name))
              .ForMember(dest => dest.NormalizedName, opts => opts.MapFrom(src => src.Name.ToUpper()))
              .ForMember(dest => dest.ConcurrencyStamp, opts => opts.MapFrom(o => Guid.NewGuid()));

            CreateMap<NavRole, RoleWisePermission>()
              .ForMember(dest => dest.Id, opts => opts.Ignore())
              .ForMember(dest => dest.Sales_Rate_Commission_Right, opts => opts.MapFrom(src => src.Commission_Right));


            CreateMap<NavTerminal, Terminal>()
             .ForMember(dest => dest.Id, opts => opts.Ignore())
              .ForMember(dest => dest.Initial, opts => opts.MapFrom(src => src.Code))
             .ForMember(dest => dest.Name, opts => opts.MapFrom(src => src.Description))
             .ForMember(dest => dest.Is_Active, opts => opts.Ignore())
              .ForMember(dest => dest.Remarks, opts => opts.Ignore())
             .ForMember(dest => dest.Cash_Drop_Limit, opts => opts.Ignore())
             .ForMember(dest => dest.Cash_Opening_Balance, opts => opts.MapFrom(src => src.Opening_Cash_in_Hand));


            CreateMap<NavMenuPermission, RoleWiseMenuPermission>()
            .ForMember(dest => dest.Id, opts => opts.Ignore())
             .ForMember(dest => dest.Menu, opts => opts.Ignore())
             .ForMember(dest => dest.MenuId, opts => opts.MapFrom(src => src.Menu_Code == null ? 0 : src.Menu_Code))
            .ForMember(dest => dest.RoleId, opts => opts.MapFrom(src => src.Role_Name));

            CreateMap<NavMenu, Menu>()
            .ForMember(dest => dest.ParentId, opts => opts.MapFrom(src => src.Parent_ID));

            //CreateMap<NavSalesInvoice, SalesInvoice>()
            // .ForMember(dest => dest.Id, opts => opts.MapFrom(src => src.id))
            //  .ForMember(dest => dest.Invoice_Number, opts => opts.MapFrom(src => src.number))
            // .ForMember(dest => dest.Trans_Date_Ad, opts => opts.MapFrom(src => src.orderDate))
            // .ForMember(dest => dest.Customer_Id, opts => opts.MapFrom(src => src.customerId))
            //  .ForMember(dest => dest.Customer_Name, opts => opts.MapFrom(src => src.customerName))
            // .ForMember(dest => dest.Customer_Mobile, opts => opts.MapFrom(src => src.customerNumber))
            // .ForMember(dest => dest.Created_By, opts => opts.MapFrom(src => src.salesperson))
            // .ForMember(dest => dest.Total_Discount, opts => opts.MapFrom(src => src.discountAmount))
            //  .ForMember(dest => dest.Invoice_Number, opts => opts.MapFrom(src => src.number))
            // .ForMember(dest => dest.NonTaxableAmount, opts => opts.MapFrom(src => src.totalAmountExcludingTax))
            // .ForMember(dest => dest.TaxableAmount, opts => opts.MapFrom(src => src.totalTaxAmount));




            CreateMap<NavItemFOC, ItemFOC>()
            .ForMember(dest => dest.Id, opts => opts.Ignore())
             .ForMember(dest => dest.ItemForFOC, opts => opts.MapFrom(src => src.Item_No_FOC))
            .ForMember(dest => dest.Name, opts => opts.MapFrom(src => src.Item_Description))
            .ForMember(dest => dest.IsActive, opts => opts.MapFrom(src => src.Blocked))

            .ForMember(dest => dest.StartDate, opts => opts.MapFrom(src => src.Start_Date))
             .ForMember(dest => dest.EndDate, opts => opts.MapFrom(src => src.End_Date));








        }
    }
}

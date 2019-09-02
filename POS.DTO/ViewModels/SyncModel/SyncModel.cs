using System;
using System.Collections.Generic;

namespace POS.DTO
{
    public class SyncModel<T>
    {
        public List<T> value { get; set; }
    }



    public class NAVItemCategory
    {
        public string id { get; set; }
        public string code { get; set; }
        public string displayName { get; set; }
        public string Indentation { get; set; }
        public string Has_Children { get; set; }
        public string Parent_Category { get; set; }
        public DateTime lastModifiedDateTime { get; set; }
        public bool Synced_with_POS { get; set; }
        public int Update_No { get; set; }
    }

    public class NAVProductGroup
    {
        public string Item_Category_Code { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public int Update_No { get; set; }
    }

    public class NavCustomer
    {
        public string id { get; set; }
        public string number { get; set; }
        public string displayName { get; set; }
        public string type { get; set; }
        public string phoneNumber { get; set; }
        public string email { get; set; }
        public string website { get; set; }
        public string taxRegistrationNumber { get; set; }
        public string blocked { get; set; }
        public string Address { get; set; }
        public string Description { get; set; }
        public string Customer_Disc_Group { get; set; }
        public string Customer_Price_Group { get; set; }
        public bool Is_Member { get; set; } = false;
        public DateTime Registration_Date { get; set; }
        public string VAT_Bus_Posting_Group { get; set; }
        public string generalbuspostinggrp { get; set; }
        public string Customer_Posting_Group { get; set; }
        public string Member_Disc_Group { get; set; }
        public int SNo { get; set; }
        public string Member_Barcode { get; set; }
        public string Membership_ID { get; set; }


        public int Update_No { get; set; }

        //public NavCustomer()
        //{
        //    address = new Address();
        //}
    }

    public class NavCustomerPOST
    {
        public string id { get; set; }
        public string number { get; set; }
        public string displayName { get; set; }
        public string phoneNumber { get; set; }
        public string taxRegistrationNumber { get; set; }
        public string Address { get; set; }
        public string Customer_Disc_Group { get; set; }
        public string Customer_Price_Group { get; set; }
        public bool Is_Member { get; set; } = false;
        public string Registration_Date { get; set; }
        public string VAT_Bus_Posting_Group { get; set; }
        public string generalbuspostinggrp { get; set; }
        public string Customer_Posting_Group { get; set; }
        public string Member_Disc_Group { get; set; }
        public string Membership_ID { get; set; }
    }



    public class Address
    {
        public string street { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string countryLetterCode { get; set; }
        public string postalCode { get; set; }
    }

    public class NavItem
    {
        public string id { get; set; }
        public string number { get; set; }
        public string displayName { get; set; }
        public string blocked { get; set; }
        public string Vendor_No { get; set; }
        public int Update_No { get; set; }
        public bool Taxable { get; set; }
        public bool Key_In_Weight { get; set; }
        public bool No_Discount { get; set; }
        public string itemdiscountgroup { get; set; }


    }

    public class NavBarCode
    {
        public string Item_No { get; set; }
        public string Unit_of_Measure { get; set; }
        public string Cross_Reference_Type { get; set; }
        public string Cross_Reference_No { get; set; }
        public bool Discontinue_Bar_Code { get; set; } = false;
        public int Update_No { get; set; }

    }

    public class NavItemPrice
    {
        public string Id { get; set; }
        public string Item_No { get; set; }
        public decimal Unit_Price { get; set; }
        public DateTime? Starting_Date { get; set; }
        public DateTime? Ending_Date { get; set; }
        public decimal Minimum_Quantity { get; set; }
        public bool Allow_Line_Disc { get; set; }
        public bool Price_Includes_VAT { get; set; } = false;
        public int Update_No { get; set; }
        public string Sales_Type { get; set; }
        public string Sales_Code { get; set; }

    }
    public class NavItemDiscount
    {
        public string Id { get; set; }
        public string Type { get; set; }
        public string Code { get; set; }
        public decimal linediscountpercentage { get; set; } = 0;
        public string Location_Code { get; set; }
        public DateTime? Starting_Date { get; set; }
        public DateTime? Ending_Date { get; set; }
        public TimeSpan? Starting_Time { get; set; }
        public TimeSpan? Ending_Time { get; set; }
        public decimal Minimum_Quantity { get; set; }
        public string Vendor_No { get; set; }
        public string Sales_Type { get; set; }
        public string Sales_Code { get; set; }
        public int Update_No { get; set; }

    }


    public class NavUser
    {
        public string User_ID { get; set; }
        public int Update_No { get; set; }
        public string Role_ID { get; set; }
    }
    public class NavRole
    {

        public string Name { get; set; }
        public bool Sales_Discount_Line_Item { get; set; }

        public decimal Sales_Discount_Line_Item_Limit { get; set; }
        public bool Sales_Discount_Flat_Item { get; set; }

        public decimal Sales_Discount_Flat_Item_Limit { get; set; }
        public bool Sales_Rate_Edit { get; set; }
        public bool Require_Terminal_To_Login { get; set; }
        public bool Credit_Note_Bill_Pay { get; set; }
        public int Update_No { get; set; }
        public bool Commission_Right { get; set; }
    }



    public class NavRolewiseMenuPermission
    {
        public string User_Name { get; set; }
        public int Update_No { get; set; }
    }




    public class NavSalesInvoice
    {
        public string id { get; set; }
        public string number { get; set; }
        public string postingno { get; set; }
        public string orderDate { get; set; }
        public string customerNumber { get; set; }
        public string customerName { get; set; }
        public string vatregistrationnumber { get; set; }
        public string locationcode { get; set; }
        public string accountabilitycenter { get; set; }
        public string assigneduserid { get; set; }
        public string shippingno { get; set; }
        public string externalDocumentNumber { get; set; }
        public bool amountrounded { get; set; }


    }
    public class NavCreditMemo
    {
        public string id { get; set; }
        public string number { get; set; }
        public string postingno { get; set; }
        public string creditMemoDate { get; set; }
        public string customerNumber { get; set; }
        public string customerName { get; set; }
        public string vatregistrationnumber { get; set; }
        public string locationcode { get; set; }
        public string accountabilitycenter { get; set; }
        public string assigneduserid { get; set; }
        public string externalDocumentNumber { get; set; }
        public bool amountrounded { get; set; }
        public string returnremarks { get; set; }



    }

    public class NavSalesItems
    {

        public string itemId { get; set; }
        public decimal quantity { get; set; }
        public decimal unitPrice { get; set; }
        //public decimal discountAmount { get; set; }
        public decimal discountPercent { get; set; }
        public decimal totalTaxAmount { get; set; }
        public string itemno { get; set; }

        //public decimal netAmount { get; set; }
        //public string itemId { get; set; }
        //public string quantity { get; set; }
        //public string unitPrice { get; set; }
        //public string discountAmount { get; set; }

    }
    public class NavSalesPaymentMode
    {

        public string documentno { get; set; }
        public int lineno { get; set; }
        public string locationcode { get; set; }
        public decimal amount { get; set; }
        public string paymenttype { get; set; }


    }

    public class NavCreditItems
    {

        public string itemId { get; set; }
        public decimal quantity { get; set; }
        public decimal unitPrice { get; set; }
        public decimal discountPercent { get; set; }
        //public decimal totalTaxAmount { get; set; }
        //public decimal netAmount { get; set; }
        //public string itemId { get; set; }
        //public string quantity { get; set; }
        //public string unitPrice { get; set; }
        //public string discountAmount { get; set; }

    }


    public class NavCompanyInfo
    {
        public string taxRegistrationNumber { get; set; }

    }
    public class NavStoreInfo
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string Name_2 { get; set; }
        public string Address { get; set; }
        public string Phone_No { get; set; }
        public string Phone_No_2 { get; set; }
        public string Fax_No { get; set; }
        public string E_Mail { get; set; }
        public string City { get; set; }
        public string Post_Code { get; set; }
        public string Country_Region_Code { get; set; }
        public string Customer_Price_Group { get; set; }
        public string Home_Page { get; set; }
        public int Update_No { get; set; }

    }

    public class NavMenu
    {

        public int Id { get; set; }
        public int? Parent_ID { get; set; }
        public int? SN { get; set; }
        public string Name { get; set; }
        public string Controller { get; set; }
        public string Action { get; set; }
        public string Route { get; set; }
        public string Type { get; set; }
        public int Update_No { get; set; }
    }

    public class NavMenuPermission
    {
        public string Role_Name { get; set; }
        public int? Menu_Code { get; set; }
        public int Update_No { get; set; }
    }


    public class NavTerminal
    {

        public string Location_Code { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public decimal Opening_Cash_in_Hand { get; set; }
        public int Update_No { get; set; }

    }

    public class NavItemFOC
    {
        public string Item_No_FOC { get; set; }
        public string Item_Description { get; set; }
        public decimal Amount { get; set; }
        public DateTime Start_Date { get; set; }
        public DateTime End_Date { get; set; }
        public bool Blocked { get; set; }
        public int Update_No { get; set; }
    }











}

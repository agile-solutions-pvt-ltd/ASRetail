using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    public partial class Customer
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Image { get; set; }
        public string Tel1 { get; set; }
        public string Tel2 { get; set; }
        public string Mobile1 { get; set; }
        public string Mobile2 { get; set; }
        public string Email { get; set; }
        public string Vat { get; set; }
        public string Fax { get; set; }
        public string Po_Box { get; set; }
        public string Type { get; set; }
        public decimal? Credit_Limit { get; set; }
        public int? Credit_Day { get; set; }
        public bool? Is_Sale_Refused { get; set; }
        public bool? Is_Member { get; set; }
        public int? Member_Id { get; set; }
        public string Barcode { get; set; }
        public DateTime? Dob { get; set; }
        public string Dob_Bs { get; set; }
        public DateTime? Wedding_Date { get; set; }
        public int? Family_Member_Int { get; set; }
        public string Occupation { get; set; }
        public string Office_Name { get; set; }
        public string Office_Address { get; set; }
        public string Designation { get; set; }
        public DateTime? Registration_Date { get; set; }
        public string Validity_Period { get; set; }
        public DateTime? Validity_Date { get; set; }
        public int? Membership_Scheme { get; set; }
        public string Reference_By { get; set; }
        public string Created_By { get; set; }
        public DateTime? Created_Date { get; set; }
        public string Remarks { get; set; }
    }
}

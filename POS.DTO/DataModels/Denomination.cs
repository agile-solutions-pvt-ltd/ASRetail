using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    public partial class Denomination
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Display(Name = "User")]
        public string User_Id { get; set; }
        [Display(Name = "Terminal")]
        public int Terminal_Id { get; set; }
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime Date { get; set; }
        [Display(Name = "Date BS")]
        public string Date_BS { get; set; }
        [Display(Name = "Card")]
        public decimal? Card { get; set; } = 0;
        public decimal? Credit { get; set; } = 0;
        [Display(Name = "Credit Note")]
        public decimal? CreditNote { get; set; } = 0;
        [Display(Name = "1000")]
        public decimal? R1000 { get; set; } = 0;
        [Display(Name = "500")]
        public decimal? R500 { get; set; } = 0;
        [Display(Name = "250")]
        public decimal? R250 { get; set; } = 0;
        [Display(Name = "100")]
        public decimal? R100 { get; set; } = 0;
        [Display(Name = "50")]
        public decimal? R50 { get; set; } = 0;
        [Display(Name = "25")]
        public decimal? R25 { get; set; } = 0;
        [Display(Name = "20")]
        public decimal? R20 { get; set; } = 0;
        [Display(Name = "10")]
        public decimal? R10 { get; set; } = 0;
        [Display(Name = "5")]
        public decimal? R5 { get; set; } = 0;
        [Display(Name = "2")]
        public decimal? R2 { get; set; } = 0;
        [Display(Name = "1")]
        public decimal? R1 { get; set; } = 0;
        [Display(Name = "0.5")]
        public decimal? R05 { get; set; } = 0;
        [Display(Name = "IC")]
        public decimal? Ric { get; set; } = 0;
        public decimal? Other { get; set; } = 0;
        [Required, Range(1, double.MaxValue, ErrorMessage = "Total Amount should be greater than zero !!")]
        public decimal Total { get; set; } = 0;

        public decimal TotalCash { get; set; } = 0;
        public string Remarks { get; set; }

        [ForeignKey("Terminal_Id")]
        public Terminal Terminal { get; set; }
    }
}

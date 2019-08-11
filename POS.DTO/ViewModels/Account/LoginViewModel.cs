using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace POS.DTO
{
    public class LoginViewModel
    {
        [Required]        
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Remember me?")]
        public bool RememberMe { get; set; }

        [NotMapped]
        public int TerminalId { get; set; }
        public string TerminalName { get; set; }
        [NotMapped]
        public DateTime ClientDate { get; set; }
    }
}
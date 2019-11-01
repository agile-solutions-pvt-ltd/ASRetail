using System.ComponentModel.DataAnnotations;

namespace POS.DTO
{
    public class ForgotPasswordViewModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
    }
}

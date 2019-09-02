using System.ComponentModel.DataAnnotations;

namespace POS.DTO
{
    public class ExternalLoginConfirmationViewModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
    }
}

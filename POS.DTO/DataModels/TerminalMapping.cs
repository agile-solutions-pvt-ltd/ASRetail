using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("TERMINAL_MAPPING")]
    public partial class TerminalMapping
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int TerminalId { get; set; }
        public string PCName { get; set; }
        public string IPAddress { get; set; }
        public string FingerPrint { get; set; }
        public string AssignedBy { get; set; }
        public DateTime AssignedDate { get; set; }
    }
}


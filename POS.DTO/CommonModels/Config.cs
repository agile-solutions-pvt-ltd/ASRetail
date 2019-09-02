using System.Collections.Generic;

namespace POS.DTO
{
    public class Config
    {
        public string Environment { get; set; }
        public string ClientPort { get; set; }
        public string IRDBaseUrl { get; set; }
        public string IRDBillUrl { get; set; }
        public string IRDBillCreditNoteUrl { get; set; }
        public string NavApiBaseUrl { get; set; }
        public string NavPath { get; set; }
        public string NavCompanyId { get; set; }
        public string IRDUserName { get; set; }
        public string IRDPassword { get; set; }
        public string NavUserName { get; set; }
        public string NavPassword { get; set; }
        // public string IRDBillUrl { get; set; }
        public bool StopPostingIRD { get; set; } = false;
        public bool StopInvoicePosting { get; set; }
        public bool StopCreditNotePosting { get; set; }
        public bool StopCustomerPosting { get; set; }
        public string OfficeHourStart { get; set; } = "16:00:00.3041840";
        public string OfficeHourEnd { get; set; } = "21:00:00.3041840";

        public string Location { get; set; }

        public List<string> LoggedInUsers { get; set; }



        public SchedulerDuration SchedulerDuration { get; set; }
        public SyncLog SyncLog { get; set; }

        public Config()
        {
            LoggedInUsers = new List<string>();
            SyncLog = new SyncLog();
        }
    }



    public class SchedulerDuration
    {
        public string Default { get; set; }
        public string Store { get; set; }
        public string Customer { get; set; }
        public string ItemCategory { get; set; }
        public string ProductGroup { get; set; }
        public string ItemType { get; set; }
        public string Item { get; set; }
        public string ItemPrice { get; set; }
        public string ItemDiscount { get; set; }
        public string ItemBarCode { get; set; }
        public string Terminal { get; set; }

        public string User { get; set; }
        public string UserRole { get; set; }
        public string UserPermission { get; set; }
        public string Status { get; set; }
        public string Menu { get; set; }
        public string MenuPermission { get; set; }

    }

    public class SyncLog
    {
        public string Store { get; set; }
        public string Customer { get; set; }
        public string ItemCategory { get; set; }
        public string ProductGroup { get; set; }
        public string ItemType { get; set; }
        public string Item { get; set; }
        public string ItemPrice { get; set; }
        public string ItemDiscount { get; set; }
        public string ItemBarCode { get; set; }
        public string Terminal { get; set; }

        public string User { get; set; }
        public string UserRole { get; set; }
        public string UserPermission { get; set; }
        public string Status { get; set; }
        public string Menu { get; set; }
        public string MenuPermission { get; set; }
    }
}

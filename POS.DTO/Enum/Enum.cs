using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace POS.DTO
{
    public enum SettlementStatus
    {
        Open,
        Closed,
        Verified
    }

    public enum SyncStatus
    {
        NotValid,
        SyncInProgress,
        SyncCompleted
    }
}



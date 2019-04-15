using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DTO
{
   public class RoleWisePermissionCommon
    {
        public RoleWisePermission roleWiseUserPermission { get; set; }
        public List<RoleWiseMenuPermission> roleWiseMenuPermissions { get; set; }
    }
}

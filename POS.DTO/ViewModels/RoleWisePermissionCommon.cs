using System.Collections.Generic;

namespace POS.DTO
{
    public class RoleWisePermissionCommon
    {
        public RoleWisePermission roleWiseUserPermission { get; set; }
        public List<RoleWiseMenuPermission> roleWiseMenuPermissions { get; set; }
    }
}

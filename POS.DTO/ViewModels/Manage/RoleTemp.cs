using System;
using System.Collections.Generic;

namespace POS.DTO
{
    public class RoleViewModel
    {
        public Guid Id { get; set; }
        public string Name { get; set; }

        List<Microsoft.AspNetCore.Identity.IdentityUser> Users { get; set; }
    }


}

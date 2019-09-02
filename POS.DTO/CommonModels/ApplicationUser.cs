using Microsoft.AspNetCore.Identity;
using System;

namespace POS.DTO
{
    public class ApplicationUser : IdentityUser
    {
        public ApplicationUser()
            : base()
        {
            this.Id = Guid.NewGuid().ToString();

        }


    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;

namespace POSService
{
   public class POSClientController: ApiController
    {
        public string GetComputerName()
        {
            return Environment.MachineName;
        }
    }
}

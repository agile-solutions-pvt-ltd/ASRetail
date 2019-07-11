using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;

namespace Microsoft.AspNetCore.Mvc
{
    public class BaseController : Controller
    {

        public EntityCore _context;
        public IConfiguration Configuration { get; }

        //public BaseController()
        //{

        //}
        public BaseController(EntityCore Context, IConfiguration configuration)
        {
            Configuration = configuration;
            _context = Context;
            setContext();
        }

        public void setContext()
        {

            Config config = ConfigJSON.Read();
            if (!string.IsNullOrEmpty(config.Environment))
            {
                var con = Configuration.GetConnectionString(config.Environment + "Connection");
                if (con != _context.Database.GetDbConnection().ConnectionString)
                {
                    var options = new DbContextOptionsBuilder<EntityCore>();
                    options.UseSqlServer(con);
                    _context = new EntityCore(options.Options);
                }

            }
        }
    }
}

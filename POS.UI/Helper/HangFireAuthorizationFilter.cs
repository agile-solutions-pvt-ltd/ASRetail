using Hangfire.Dashboard;

namespace POS.UI.Helper
{


    /// <summary>
    /// Used for Hangfire Dashboard only
    /// </summary>
    public class HangFireAuthorizationFilter : IDashboardAuthorizationFilter
    {
        public bool Authorize(DashboardContext context)
        {
            var httpContext = context.GetHttpContext();

            // Allow all authenticated users to see the Dashboard (potentially dangerous).
            return httpContext.User.Identity.IsAuthenticated;
        }
    }
}

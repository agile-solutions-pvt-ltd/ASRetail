using Hangfire;
using Hangfire.Storage;
using System.Linq;

namespace POS.UI.Helper
{
    public static class HangfireExtensions
    {
        public static void PurgeJobs(this IMonitoringApi monitor)
        {


            var hangfireMonitor = JobStorage.Current.GetMonitoringApi();

            //RecurringJobs
            //JobStorage.Current.GetConnection().GetRecurringJobs().ForEach(xx => BackgroundJob.Delete(xx.Id));

            //ProcessingJobs
            hangfireMonitor.ProcessingJobs(0, int.MaxValue).ForEach(xx => BackgroundJob.Delete(xx.Key));

            //ScheduledJobs
            hangfireMonitor.ScheduledJobs(0, int.MaxValue).ForEach(xx => BackgroundJob.Delete(xx.Key));

            //EnqueuedJobs
            hangfireMonitor.Queues().ToList().ForEach(xx => hangfireMonitor.EnqueuedJobs(xx.Name, 0, int.MaxValue).ForEach(x => BackgroundJob.Delete(x.Key)));

        }
    }
}

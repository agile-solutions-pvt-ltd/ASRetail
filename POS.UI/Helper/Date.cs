using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI.Helper
{
    public static class Date
    {

        public static int GetWeekNumber()
        {
            CultureInfo cultureInfo = CultureInfo.CurrentCulture;
            int weekNum = cultureInfo.Calendar.GetWeekOfYear(DateTime.Now, CalendarWeekRule.FirstFullWeek, DayOfWeek.Sunday);
            return weekNum;

        }
    }
}

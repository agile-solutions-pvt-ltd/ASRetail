using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Routing;
using Newtonsoft.Json;
using POS.DTO;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Microsoft.AspNetCore.Authorization
{
    public class RolewiseAuthorized : ActionFilterAttribute
    {
        public override void OnResultExecuting(ResultExecutingContext filterContext)
        {

        }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);
            if (!filterContext.HttpContext.User.Identity.IsAuthenticated)
            {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary { { "controller", "Account" }, { "action", "Login" } });
                return;
            }
            var menus = JsonConvert.DeserializeObject<List<RoleWiseMenuPermission>>(filterContext.HttpContext.Session.GetString("Menus"));
            var controllerName = filterContext.RouteData.Values["controller"].ToString();
            var actionName = filterContext.RouteData.Values["action"].ToString();
           // string url = "/" + controllerName + "/" + actionName;
            if (!menus.Where(s => s.Menu.Controller == controllerName).Any())
            {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary { { "controller", "Account" }, { "action", "Unauthorized" } });
                return;
            }
        }
    }
}

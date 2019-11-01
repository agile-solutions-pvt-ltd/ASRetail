using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Routing;
using Newtonsoft.Json;
using POS.DTO;
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

            if (!filterContext.HttpContext.User.IsInRole("Administrator"))
            {
                if (filterContext.HttpContext.Session.GetString("Menus") != null)
                {
                    var totalMenu = JsonConvert.DeserializeObject<List<Menu>>(filterContext.HttpContext.Session.GetString("TotalMenu"));
                    var menus = JsonConvert.DeserializeObject<List<RoleWiseMenuPermission>>(filterContext.HttpContext.Session.GetString("Menus"));
                    var controllerName = filterContext.RouteData.Values["controller"].ToString();
                    var actionName = filterContext.RouteData.Values["action"].ToString();
                    // string url = "/" + controllerName + "/" + actionName;

                    if (!menus.Where(s => s.Menu.Controller == controllerName || s.Menu.Action == actionName).Any())
                    {
                        filterContext.Result = new RedirectToRouteResult(
                            new RouteValueDictionary { { "controller", "Account" }, { "action", "Unauthorized" } });
                        return;
                    }
                    if (totalMenu.Where(x => x.Controller == controllerName && x.Action == actionName).Any() && !menus.Where(x => x.Menu.Controller == controllerName && x.Menu.Action == actionName).Any())
                    {
                        filterContext.Result = new RedirectToRouteResult(
                           new RouteValueDictionary { { "controller", "Account" }, { "action", "Unauthorized" } });
                        return;
                    }
                }
                else
                {
                    filterContext.Result = new RedirectToRouteResult(
                        new RouteValueDictionary { { "controller", "Account" }, { "action", "Login" } });
                    return;
                }
            }
        }
    }


    public class SessionAuthorized : ActionFilterAttribute
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
            var session = filterContext.HttpContext.Session.GetString("Menus");
            if (session == null)
            {
                filterContext.Result = new RedirectToRouteResult(
                        new RouteValueDictionary { { "controller", "Account" }, { "action", "Login" } });
                return;
            }

        }
    }
}

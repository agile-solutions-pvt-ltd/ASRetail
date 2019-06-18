using POS.DTO;
using POS.UI.Helper;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace POS.UI.Sync
{
  
    public static class NAV
    {
        public static RestClient NAVClient(string url, Config config)
        {
            var credential = new CredentialCache
                {
                     {
                       new Uri(url),
                       "NTLM",
                       new NetworkCredential(config.NavUserName, config.NavPassword)
                      }
                };
            var client = new RestClient(url)
            {
                Authenticator = new RestSharp.Authenticators.NtlmAuthenticator(credential)
            };
            return client;
        }

    }
}

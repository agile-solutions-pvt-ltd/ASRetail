using POS.DTO;
using RestSharp;
using System;
using System.Net;

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
            client.Timeout = 1200000; //20 minute
            return client;
        }

    }
}

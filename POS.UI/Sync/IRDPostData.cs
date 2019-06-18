using Newtonsoft.Json;
using POS.DTO;
using POS.UI.Helper;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;

namespace POS.UI.Sync
{
    public class IRDPostData
    {       
       

        public bool PostBill(BillViewModel model)
        {
            try
            {
                //Thread.Sleep(100000);
                Config config = ConfigJSON.Read();

                var client = new RestClient(config.IRDBaseUrl);
                var request = new RestRequest(config.IRDBillUrl, Method.POST);

                request.AddHeader("Content-Type", "application/json");

                //post data
                //authentication
                model.username = config.IRDUserName;
                model.password = config.IRDPassword;
                request.RequestFormat = DataFormat.Json;
                var jsonModel = JsonConvert.SerializeObject(model);
                request.AddJsonBody(model);

                IRestResponse response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.OK)
                    return true;
                else
                    return false;
            }
            catch(Exception ex)
            {
                return false;
            }
           



        }


        
    }
}

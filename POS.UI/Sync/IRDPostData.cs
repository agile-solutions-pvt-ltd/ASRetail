using Newtonsoft.Json;
using POS.DTO;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace POS.UI.Sync
{
    public class IRDPostData
    {

        public string _irdUrl = "https://cbapi.ird.gov.np/";

        public bool PostBill(BillViewModel model)
        {
            try
            {


                var client = new RestClient(_irdUrl);
                var request = new RestRequest("api/bill", Method.POST);


                request.AddHeader("Content-Type", "application/json");

                //post data
                request.RequestFormat = DataFormat.Json;
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

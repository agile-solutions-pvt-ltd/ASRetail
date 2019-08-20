using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using POS.DTO;
using System.IO;

namespace POS.UI.Helper
{
    public class ConfigJSON
    {
        private static string _path = "config.json";
        public IConfiguration Configuration { get; }

        //public ConfigJSON(IConfiguration configuration)
        //{
        //    Configuration = configuration;
        //}

        //public static IConfiguration GetConfiguration()
        //{
        //    ConfigJSON config = new ConfigJSON();
        //    return Configuration;
        //}
        public static Config Read()
        {
            using (StreamReader r = new StreamReader(_path))
            {
                string json = r.ReadToEnd();
                Config config = JsonConvert.DeserializeObject<Config>(json);
                return config;
            }
        }

        public static void Write(Config model)
        {
            string json = JsonConvert.SerializeObject(model, Formatting.Indented);
            if (!string.IsNullOrEmpty(json))
            {
                //write string to file
                System.IO.File.WriteAllText(_path, json);
            }
        }
    }
}

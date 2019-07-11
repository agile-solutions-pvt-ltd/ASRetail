using Microsoft.Extensions.Caching.Memory;

namespace POS.UI.Models
{
    // using Microsoft.Extensions.Caching.Memory;
    public class InMemoryCache
    {
        public MemoryCache Cache { get; set; }
        //public InMemoryCache()
        //{
        //    Cache = new MemoryCache(new MemoryCacheOptions
        //    {
        //        SizeLimit = 5120,

        //    });
        //}
    }
}

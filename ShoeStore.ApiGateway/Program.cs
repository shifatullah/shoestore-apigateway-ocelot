using System.IO;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;

namespace ShoeStore.ApiGateway
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((host, config) =>
                {
                    config
                        .SetBasePath(host.HostingEnvironment.ContentRootPath)
                        .AddJsonFile(Path.Combine("configuration", "configuration.json"), false, true)
                        .AddJsonFile(Path.Combine("configuration", $"configuration.{host.HostingEnvironment.EnvironmentName}.json"), false, true);
                })
                .UseStartup<Startup>();
    }
}
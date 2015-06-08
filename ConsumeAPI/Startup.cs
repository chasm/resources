using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ConsumeAPI.Startup))]
namespace ConsumeAPI
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

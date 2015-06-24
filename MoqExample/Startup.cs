using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MoqExample.Startup))]
namespace MoqExample
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

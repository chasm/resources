using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DependancyInjectionWithMoq.Startup))]
namespace DependancyInjectionWithMoq
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Story.Startup))]
namespace Story
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

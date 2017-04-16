using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(IBS.ERP.Startup))]
namespace IBS.ERP
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //ConfigureAuth(app);
            
        }
    }
}

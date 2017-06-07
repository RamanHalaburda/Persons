using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Persons.Startup))]
namespace Persons
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

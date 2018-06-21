using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Testing;
using RazorPagesMovie;
using Xunit;

namespace Tests
{
    public class UnitTest1 : IClassFixture<WebApplicationTestFixture<Startup>>
    {
        public HttpClient Client { get; }

        public UnitTest1(WebApplicationTestFixture<Startup> fixture)
        {
            Client = fixture.Client;
        }

        [Fact]
        public async Task GetHomePage()
        {
            var response = await Client.GetAsync("/");
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
    }
}

using System.Net.Http;
using System.Net.Http.Formatting;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;
using LatentIdentifcation.Models;

namespace LatentIdentifcation.Controllers
{
    public class PrintVerificationController : ApiController
    {
        [AcceptVerbs("POST")]
        [HttpPost]
        public string PrintVerification(FormDataCollection form)
        {
            var key = form.Get("key");
            var template = form.Get("template").Replace(" ", "+");
            var query = form.Get("query").Replace(" ", "+");

            Verification verification = new Verification(key, template, query);
            string result = verification.GetResult();

            if (result == null)
                return "No Found";

            return result;
        }

        [AcceptVerbs("GET")]
        [HttpGet]
        public string PrintVerification()
        {
            return "Web Service for Print Verification is OK. Please, send your data using the POST method.";
        }
    }
}
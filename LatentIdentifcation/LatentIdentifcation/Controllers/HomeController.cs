using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LatentIdentifcation.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Title = "Home Page";

            return View();
        }

        [HttpPost]
        public void Nombre(string texto)
        {
            string text = texto;

            System.IO.File.WriteAllText(@"C:\Users\Mario Prueba\Documents\Mis cosas\Tecnológico de Monterrey\8vo Semestre\Desarrollo web\DesaProyecto\archivo.txt", text);
        }

        /*public ActionResult HacerAlgo()
        {
            if (Request.HttpMethod == "POST")
            {
                
            }
            return View();
        }*/
    }
}

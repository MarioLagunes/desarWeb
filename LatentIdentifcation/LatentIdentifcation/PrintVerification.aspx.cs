using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using LatentIdentifcation.Models;

namespace LatentIdentifcation
{
    public partial class PrintVerification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //lbResult.Visible = false;
            //lbResultImg.Visible = false;
        }

        /*protected void Verify_Click(object sender, EventArgs e)
        {
            var ResponseSt = ComputeVerification().Split(':');
            var result = ResponseSt[0];
            var msgResult = ResponseSt[1].Replace("\"", "");

            lbResult.Text = msgResult;
            lbResult.Visible = Visible;
            lbResultImg.Visible = Visible;

            if (result.ToLowerInvariant().Contains("true"))
            {
                lbResultImg.Text = "<i class='fa fa-2x fa-check-square-o'></i> Match";
                lbResultImg.Attributes["class"] = "alert-success btn-lg";
                lbResult.Attributes["class"] = "";
            }
            if (result.Contains("Error"))
            {
                lbResultImg.Text = "Error";
                lbResultImg.Attributes["class"] = "alert-danger btn-lg";
                lbResult.Attributes["class"] = "alert-danger btn-lg";
            }
            if (result.ToLowerInvariant().Contains("false"))
            {
                lbResultImg.Text = "<i class='fa fa-2x fa-times'></i> No Match";
                lbResultImg.Attributes["class"] = "alert-warning btn-lg";
                lbResult.Attributes["class"] = "";
            }
        }

        private string ComputeVerification()
        {
            var key = tboxKey.Text;
            var templateEconded = EncodeBase64.ImageToBase64(template.FileBytes);
            var queryEconded = EncodeBase64.ImageToBase64(query.FileBytes);

            var ps = new[] { "key", key, "template", templateEconded, "query", queryEconded };

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://localhost:53210/api/PrintVerification/");
            request.Proxy = WebRequest.DefaultWebProxy;
            string str = "";

            for (int i = 0; i + 1 < ps.Length; i += 2)
                str += (ps[i]) + "=" + (ps[i + 1]) + "&";
            if (str.EndsWith("&"))
                str = str.Substring(0, str.Length - 1);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            byte[] buffer = Encoding.ASCII.GetBytes(str);
            request.ContentLength = buffer.Length;
            Stream newStream = request.GetRequestStream();
            newStream.Write(buffer, 0, buffer.Length);

            WebResponse response = request.GetResponse();
            Stream sStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(sStream);
            string ResponseSt = reader.ReadToEnd();
            reader.Close();
            response.Close();
            newStream.Close();
            return ResponseSt;
        }*/
    }
}
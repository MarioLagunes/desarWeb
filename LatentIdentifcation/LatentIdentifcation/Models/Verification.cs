using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using FR.MatchingSDK;
using PatternRecognition.FingerprintRecognition.Core;
using Image = System.Drawing.Image;

namespace LatentIdentifcation.Models
{
    public class Verification
    {
        private string _key;
        private string _template;
        private string _query;
        private readonly List<string> _keys = new List<string>() { "1", "2", "3" };

        public Verification(string key, string template, string query)
        {
            _key = key;
            _template = template;
            _query = query;
        }

        public string GetResult()
        {
            if (!_keys.Contains(_key))
                return "Error: Your key is invalid";

            return IsThereMatch(_template, _query);
        }

        private string IsThereMatch(string template, string query)
        {
            Tuple<bool, List<MinutiaPair>> verificationResult;
            using (var t = EncodeBase64.Base64ToImage(template))
            using (var q = EncodeBase64.Base64ToImage(query))
            {
                var isThereError = IsThereError(t, q);

                if (isThereError.Item1)
                    return isThereError.Item2;

                MatchingSDK matchingSdk = new MatchingSDK();

                var qBmp = new Bitmap(q);
                var tBmp = new Bitmap(t);
                var queryMtiaList = matchingSdk.ExtractMinutaeFromPalmprint(qBmp);
                var templateMtiaList = matchingSdk.ExtractMinutaeFromPalmprint(tBmp);
                var queryMTripletsFeature = matchingSdk.BuildMtripletsFeature(queryMtiaList);
                var templateMTripletsFeature = matchingSdk.BuildMtripletsFeature(templateMtiaList);
                verificationResult = matchingSdk.VerifyPalmprints(queryMTripletsFeature, templateMTripletsFeature);

                qBmp.Dispose();
                tBmp.Dispose();
            }

            var result = CreateOutput(verificationResult);

            return result;
        }

        private string CreateOutput(Tuple<bool, List<MinutiaPair>> matchResult)
        {
            var result = matchResult.Item1.ToString().Replace("\"", "") + $": <span class='alert-info btn-lg'>Here the List of Minutiae ({matchResult.Item2.Count} in total)</span><br>";
            result += "<table class='table table-condensed table-hover text-center'><thead><tr><th class='text-center'>Matching Value</th><th class='text-center'>Query<br>Type of Minutia</th><th class='text-center'>Query<br>X</td><th class='text-center'>Query<br>Y</th><th class='text-center column-verticallineMiddle form-inline'>Query<br>Angle</th><th class='text-center'>Template<br>Type of Minutia</th><th class='text-center'>Template<br>X</th><th class='text-center'>Template<br>Y</th><th class='text-center'>Template<br>Angle</th></tr></thead><tbody>";
            foreach (var pair in matchResult.Item2.OrderByDescending(x => x.MatchingValue))
            {
                var i = 0;
                Console.WriteLine(i);
                var classTR = "";
                if (pair.MatchingValue >= 0.8)
                    classTR = "alert-success";
                if (pair.MatchingValue < 0.8 && pair.MatchingValue >= 0.55)
                    classTR = "alert-warning";
                if (pair.MatchingValue < 0.55)
                    classTR = "alert-danger";

                result += $"<tr class='{classTR}'><td>" + pair.MatchingValue + "</td><td>" + pair.QueryMtia.MinutiaType + "</td><td>" + pair.QueryMtia.X + "</td><td>" + pair.QueryMtia.Y + "</td><td>" + pair.QueryMtia.Angle + "</td><td>" + pair.TemplateMtia.MinutiaType + "</td><td>" + pair.TemplateMtia.X + "</td><td>" + pair.TemplateMtia.Y + "</td><td>" + pair.TemplateMtia.Angle + "</td></tr>";
            }
            result += "</tbody></table>";
            return result.Replace("\"", "");
        }

        private Tuple<bool, string> IsThereError(Image template, Image query)
        {
            if (template == null)
                return new Tuple<bool, string>(true, "Error: Your TEMPLATE print is invalid, please, check our requirements for submitting prints");
            if (query == null)
                return new Tuple<bool, string>(true, "Error: Your QUERY print is invalid, please, check our requirements for submitting prints");

            if (template.RawFormat.Guid != ImageFormat.Jpeg.Guid)
                return new Tuple<bool, string>(true, "Error: Your TEMPLATE print is not an image formated to JPEG, please, check our requirements for submitting prints");

            if (query.RawFormat.Guid != ImageFormat.Jpeg.Guid)
                return new Tuple<bool, string>(true, "Error: Your QUERY print  is not an image formated to JPEG, please, check our requirements for submitting prints");

            return new Tuple<bool, string>(false, "");
        }
    }
}
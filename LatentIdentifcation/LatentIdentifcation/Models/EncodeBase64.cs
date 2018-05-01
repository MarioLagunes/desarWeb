using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;

namespace LatentIdentifcation.Models
{
    public static class EncodeBase64
    {

        public static string ImageToBase64(byte[] imageBytes)
        {
            var base64String = Convert.ToBase64String(imageBytes);
            return base64String;
        }

        public static System.Drawing.Image Base64ToImage(string base64String)
        {
            try
            {
                byte[] imageBytes = Convert.FromBase64String(base64String);
                using (var ms = new MemoryStream(imageBytes, 0, imageBytes.Length))
                {
                    System.Drawing.Image image = System.Drawing.Image.FromStream(ms, true);
                    return image;
                }
            }
            catch (Exception)
            {
                return null;
            }

        }
    }
}
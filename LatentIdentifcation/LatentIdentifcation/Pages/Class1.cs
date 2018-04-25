using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System;
using System.IO;
using System.Text.RegularExpressions;

namespace LatentIdentifcation.Pages
{
    public class Class1
    {
        public static void Main(String[] args)
        {
            if (args.Length != 1)
            {
                Console.WriteLine("Please specify the input file.");
                Environment.Exit(1);
            }
            String fileName = args[0];
            String fileContents = File.ReadAllText(fileName);
            Regex regex = new Regex(@"\d+[.]\d+[.]\d+[.]\d+", RegexOptions.Multiline);
            Console.Write("ipclien " + regex);

            foreach (Match m in regex.Matches(fileContents))
            {
                if (m.Groups[1].Success)
                {
                    Console.WriteLine($"Found an identifier: {m.Value}"
                        + $" ({m.Index}, {m.Length})");

                }
                else if (m.Groups[2].Success)
                {
                    Console.WriteLine($"Found an integer literal: {m.Value}"
                        + $" ({m.Index}, {m.Length})");
                }
            }
        }
    }
}
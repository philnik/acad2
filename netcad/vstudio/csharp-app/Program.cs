using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BricscadApp;
using BricscadDb;
using System.Runtime.InteropServices; // Required for COM interop
using System.IO;
using System.Data.SQLite;
using ClassLibrary2;
using System.Diagnostics;
using BricscadSm;
// #r "nuget "C:\Users\filip\source\repos\csharp-app\bin\Debug\ClassLibrary2.dll"

namespace csharp_app
{
    internal class Program
    {


        public class Bcad
        {
            public BricscadApp.AcadApplication acad;
            public BricscadApp.AcadDocument doc;
            public BricscadDb.AcadModelSpace model;

            public string DefaultTemplate = @"C:\Users\filip\AppData\Local\Bricsys\BricsCAD\V24x64\en_US\Templates\Default-mm.dwt";

            public void Acad()
            {
                acad = (BricscadApp.AcadApplication)Marshal.GetActiveObject("BricscadApp.AcadApplication");
                doc = acad.ActiveDocument;
                model = doc.ModelSpace;
            }
        }


        static void Main(string[] args)
        {
            Acad cad = new Acad();
            cad.Init_acad();
            // NewDocument(cad);
            BricscadDb.AcadModelSpace model;
            
            /*
            Add n = new Add();
            n.acad = cad;
            double val;
            for (int i = 0; i < 200; i++)
            {
                val = i * 10.0;
                n.Line(val * Math.Sin(val), val * Math.Cos(val), 0.0, 0.0);
            }
            */

            //NewDocument(cad);
            //CloseCurrentDocument(cad);
            /*
            Sql mysql = new Sql();
            MyClass mclass = new MyClass();

            mclass.Myfunc();
            mysql.Get_sql_version();
            */
        }

        static void NewDocument(Bcad bcad)
            {

                bcad.acad.Documents.Add(bcad.DefaultTemplate);

            }

            static void CloseCurrentDocument(Bcad bcad)
            {
                bcad.doc.Close();

            }

            }
        }
   

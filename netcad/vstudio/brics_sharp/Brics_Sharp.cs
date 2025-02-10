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
using System.Security.Cryptography;



namespace brics_sharp
{


    public class Acad
    {
        public BricscadApp.AcadApplication acad;
        public BricscadApp.AcadDocument doc;
        public BricscadDb.AcadModelSpace model;

        public string DefaultTemplate = @"C:\Users\filip\AppData\Local\Bricsys\BricsCAD\V24x64\en_US\Templates\Default-mm.dwt";

        public void Init_acad()
        {
            this.acad = (BricscadApp.AcadApplication)Marshal.GetActiveObject("BricscadApp.AcadApplication");
            this.doc = acad.ActiveDocument;
            this.model = doc.ModelSpace;
        }


        public List<string> DocName()
        {
            string name = doc.Name;
            string fullname = doc.FullName;
            string pathname = doc.Path;
            

            List<string> result = new List<string>
            { doc.Name, doc.FullName, doc.Path};
            return result;
        }
        public void NewDocument()
        {
            this.acad = (BricscadApp.AcadApplication)Marshal.GetActiveObject("BricscadApp.AcadApplication");
            //this.doc = acad.Documents.Add(DefaultTemplate);
            this.doc = this.acad.Documents.Add(DefaultTemplate);

            this.model = doc.ModelSpace;

        }
    }

    public class Run
        {

            public Acad acad;

            public void Command(string cmd)
            {
                acad.doc.Application.RunCommand(cmd);

            }

            public void Command_Example()
            {
                string sCmd;
                sCmd = "_circle 0,0 100 ";
                acad.doc.Application.RunCommand(sCmd);

            }

        }


        public class Add
        {
            public Acad acad;

            
            public void Line(double[] p0, double[] p1)
            {
                Line(p0[0], p0[1], p1[0], p1[1]);
            }

            public void Line(double[] p)
            {
                Line(p[0], p[1], p[2], p[3]);

            }

            public void Line(double x0, double y0, double x1, double y1)
            {
                double[] startPoint = { 0, 0, 0 };
                double[] endPoint = { 0, 0, 0 };
                startPoint[0] = x0;
                startPoint[1] = y0;
                startPoint[2] = 0.0;
                endPoint[0] = x1;
                endPoint[1] = y1;
                endPoint[2] = 0.0;
                this.acad.model.AddLine(startPoint, endPoint);
            }


            public void Circle(double[] center, double radius)
            {
                this.acad.model.AddCircle(center, radius);
            }

            public void Circle(double p0, double p1, double radius)
            {
                double[] center = { p0, p1 };
                Circle(center, radius);
            }

            public void MText(double p0, double p1, double width, string text)
            {
                double[] pos = { p0, p1 };
                MText(pos, width, text);


            }
            public void MText(double[] pos, double width, string text)
            {


                this.acad.model.AddMText(pos, width, text);
            }


        public void Add_Axial_Lines()
        {

            //this.acad = cad;
            double val;
            for (int i = 0; i < 200; i++)
            {
                val = i * 10.0;
                this.Line(val * Math.Sin(val), val * Math.Cos(val), 0.0, 0.0);
            }

        }


        }


        public class Sql
        {

            public void Get_sql_version()
            {
                string cs = "Data Source=:memory:";
                string stm = "SELECT SQLITE_VERSION()";

                var con = new SQLiteConnection(cs);
                con.Open();

                var cmd = new SQLiteCommand(stm, con);
                string version = cmd.ExecuteScalar().ToString();


                Console.WriteLine($"SQLite version: {version}");
                Console.ReadLine();

            }


        }

    }


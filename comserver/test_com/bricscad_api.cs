using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.IO;
using System.Net.Mime;
using System.Dynamic;
using System.Xml.Linq;
using BricscadDb;
using BricscadApp;

namespace SimpleComServer
{

    [ComVisible(true)]
    [Guid("2E530C3A-27C6-4006-B6D7-9BF04BE47471")]
    [InterfaceType(ComInterfaceType.InterfaceIsDual)]
    public interface IBrics2d
    {
        // object[] ReadCsv(string filepath);

        // object ReadMesh(string filepath);

        // int[,] ReadMeshBoundary(string filepath);

        void Init_acad();

        string[] DocData();
        string GetPlotPath();

        string GetVar(string var);

    }

   

[ComVisible(true)]
    [Guid("47F4BADB-948D-4F96-BF29-DDA1F201AC87")]
    [ClassInterface(ClassInterfaceType.None)]
    [ProgId("SimpleComServer.Brics2d")]
    public class Brics2d : IBrics2d
    {
        public BricscadApp.AcadApplication acad;
        public BricscadApp.AcadDocument doc;
        public BricscadDb.AcadModelSpace model;



        public void Init_acad()
        {
            this.acad = (BricscadApp.AcadApplication)Marshal.GetActiveObject("BricscadApp.AcadApplication");
            this.doc = acad.ActiveDocument;
            this.model = doc.ModelSpace;
        }


        public string[]  DocData()
        {
            string name = doc.Name;
            string fullname = doc.FullName;
            string pathname = doc.Path;


            string[] result = new string[3];
            result[0] = doc.Name;
            result[1] = doc.FullName;
            result[2] = doc.Path;
            return result;
        }

        public string GetVar(string var)
        {
            return this.doc.GetVariable(var);
        }

        public string GetPlotPath()
        {
            return this.doc.GetVariable("PlotOutputPath");

        }


    }


}

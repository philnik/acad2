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

    }

   

[ComVisible(true)]
    [Guid("47F4BADB-948D-4F96-BF29-DDA1F201AC87")]
    [ClassInterface(ClassInterfaceType.None)]
    [ProgId("SimpleComServer.Brics2d")]
    public class Brics2d : IBrics2d
    {


    }


}

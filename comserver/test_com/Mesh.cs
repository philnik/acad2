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
    [Guid("F40301E8-35E2-4B89-9D85-6DA46C6F1BFF")]
    [InterfaceType(ComInterfaceType.InterfaceIsDual)]
    public interface IMeshFile
    {
        object[] ReadCsv(string filepath);

        object ReadMesh(string filepath);

        int[,] ReadMeshBoundary(string filepath);

    }

[ComVisible(true)]
    [Guid("76BA730B-B048-4FE8-8847-D50DB1363CE1")]
    [ClassInterface(ClassInterfaceType.None)]
    [ProgId("SimpleComServer.MeshFile")]
    public class MeshFile: IMeshFile
	{

        public int[,] ReadMeshBoundary(string filepath)
        {
            string[][] readfile = ReadCsvString(filepath);

            int lrow = readfile.Length;
            int lcol= readfile[0].Length;

            int[,] output = new int[lrow,lcol]; 

            for (int i = 0; i < lrow; i++)
            {
                for (int j = 0; j < lcol; j++)
                {
                    output[i,j] = int.Parse(readfile[i][j]);
                }
            }

            return output;


        }


        public object ReadMesh(string filepath)
        {

            int[,] ivar = ReadMeshBoundary(filepath);

            return (object)ivar;
           


        }


        public string[][] ReadCsvString(string filePath)
        {
            List<string[]> csvData = new List<string[]>();

            try
            {
                using (StreamReader reader = new StreamReader(filePath))
                {
                    while (!reader.EndOfStream)
                    {
                        string line = reader.ReadLine();
                        // Split the line by space and remove empty entries (multiple spaces will not result in empty strings)
                        string[] fields = line.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                        csvData.Add(fields);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
            }

            // Assuming the original array is string[][] (2D array of strings)
            string[][] csvValues = csvData.ToArray();

            return csvValues;
        }




        public object[] ReadCsv(string filepath) {

            string[][] csvValues = ReadCsvString(filepath);

            // Convert it to an object array or Variant array as needed for COM
            object[] comArray = new object[csvValues.Length];

            for (int i = 0; i < csvValues.Length; i++)
            {
                comArray[i] = csvValues[i];  // This converts the row (string[]) into an object[]
            }

            return comArray;
            // Now pass comArray to the COM server
        

        }

	}

}
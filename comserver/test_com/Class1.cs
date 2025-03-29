using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.IO;
using System.Net.Mime;


// // {40E1DFFD-F972-4C5F-A529-D794190A6A26}
// static const GUID <<name>> = 
// { 0x40e1dffd, 0xf972, 0x4c5f, { 0xa5, 0x29, 0xd7, 0x94, 0x19, 0xa, 0x6a, 0x26 } };
// // {923A488A-6BD2-4669-B3CF-0FACFF4064D8}
// static const GUID <<name>> = 
// { 0x923a488a, 0x6bd2, 0x4669, { 0xb3, 0xcf, 0xf, 0xac, 0xff, 0x40, 0x64, 0xd8 } };
// // {62DE262F-2D6F-4629-B990-0A03953749AA}
// static const GUID <<name>> = 
// { 0x62de262f, 0x2d6f, 0x4629, { 0xb9, 0x90, 0xa, 0x3, 0x95, 0x37, 0x49, 0xaa } };

// csc /target:library /out:SimpleCOMServer.dll new.cs
// regasm /codebase /tlb SimpleComServer.dll

//[assembly: ComVisible(true)]
//[assembly: Guid("C883D59B-AFD4-4C6E-8EBC-70FA662CBDC1")]
// {6AFB7C1B-9223-4B6E-BA6B-E995BDA5C56F}
//static const GUID <<name>> = 
//{ 0x6afb7c1b, 0x9223, 0x4b6e, { 0xba, 0x6b, 0xe9, 0x95, 0xbd, 0xa5, 0xc5, 0x6f } };
// {227B0091-74EB-4F2F-8DDF-B0F9396ADE2D}
//static const GUID <<name>> = 
//{ 0x227b0091, 0x74eb, 0x4f2f, { 0x8d, 0xdf, 0xb0, 0xf9, 0x39, 0x6a, 0xde, 0x2d } };
// {C883D59B-AFD4-4C6E-8EBC-70FA662CBDC1}
//static const GUID <<name>> = 
//{ 0xc883d59b, 0xafd4, 0x4c6e, { 0x8e, 0xbc, 0x70, 0xfa, 0x66, 0x2c, 0xbd, 0xc1 } };


namespace SimpleComServer
{
    [ComVisible(true)]
    [Guid("923A488A-6BD2-4669-B3CF-0FACFF4064D8")]
    [InterfaceType(ComInterfaceType.InterfaceIsDual)]
    public interface IComCalculator
    {
        int Add(int a, int b);
        int[] GetNumbers();
        string[] GetStrings();
        double[] GetDoubles();
        bool[] GetBools();
        int multiply(int a, int b);
        int InAdd();
        int a { get; set; }
        int b { get; set; }

        string ReadFile(string path);

        string[][] ReadCsv(string filepath);
        
    

    }

    [ComVisible(true)]
    [Guid("227B0091-74EB-4F2F-8DDF-B0F9396ADE2D")]

    [ClassInterface(ClassInterfaceType.None)]
    [ProgId("SimpleComServer.Calculator")]
    public class ComCalculator : IComCalculator
    {
        public int a { get; set; }
        public int b { get; set; }


        public string[][] ReadCsv(string filePath)
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

            // Convert List<string[]> to a 2D array
            return csvData.ToArray();
        }





        public int InAdd()
        {
            return this.a + this.b;
        }
        public int Add(int a, int b)
        {
            return a + b;
        }

        public int multiply(int a, int b)
        {
            return a * b;
        }

        public int[] GetNumbers()
        {

            return new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
        }

        public string[] GetStrings()
        {
            return new string[] { "hello", "world", "this", "is" };
        }

        public double[] GetDoubles()
        {
            return new double[] { 1.2, 1.3, 1.4 };
        }

        public bool[] GetBools()
        {
            return new bool[] { true, false, true, false,   false };
        }
    }   
}


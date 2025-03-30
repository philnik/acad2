import win32com.client

#  runas /user:Adminstrator regsvr32 /u C:/Users/filip/source/repos/test_com/bin/Debug/test_com.dll
# runas /user:Adminstrator C:/Windows/Microsoft.NET/Framework/v4.0.30319/RegAsm.exe  C:/Users/filip/source/repos/test_com/bin/Debug/test_com.dll /codebase /tlb
# runas /user:Adminstrator C:/Windows/Microsoft.NET/Framework/v4.0.30319/RegAsm.exe  /u C:/Users/filip/source/repos/test_com/bin/Debug/test_com.dll
# runas /user:Adminstrator C:/Windows/Microsoft.NET/Framework/v4.0.30319/RegAsm.exe c:/Users/filip/AppData/Roaming/python/acad2/comserver/test_com/bin/Debug/test_com.dll /codebase /tlb
# runas /user:Adminstrator C:/Windows/Microsoft.NET/Framework/v4.0.30319/RegAsm.exe /u c:/Users/filip/AppData/Roaming/python/acad2/comserver/bin/Debug/test_com.dll
#Set obj = CreateObject("MyCOML")
#MsgBox obj.SayHello("John")
#Set calculator = CreateObject("SimpleComServer.Calculator")
#MsgBox calculator.Add(5, 3)  ' Should show 8

myc = "MyCOMLibrary.SimpleComClass"
myc = "SimpleComServer.Calculator"
myc = "SimpleComServer.Calculator"
ac = win32com.client.Dispatch(myc)

dispname = "SimpleComServer.MeshFile"
msh = win32com.client.Dispatch(dispname)

ac.Add(1,2)

ac.GetNumbers()

ac.GetDoubles()
ac.GetStrings()

ac.GetBools()

ac.multiply(2,3)

ac.a = 3
ac.b = 5
ac.InAdd()


fpath =  r"C:\Users\filip\AppData\Roaming\python\cad2\draw\free\filters.py"
fpath = r"C:\Users\filip\AppData\Roaming\fem\elmer_fem\sound_test_again\navier_corridor2d\mesh.boundary"
my = msh.ReadCsv(fpath)

mm = msh.ReadMesh(fpath)




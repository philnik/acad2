import win32com.client
import pythoncom
from win32com.client import Dispatch, VARIANT
from pythoncom import VT_VARIANT
from win32com.client import gencache
import math
import sys
import clr

assembly_path = r"C:\Users\filip\source\repos\ClassLibrary2\bin\Debug"
assembly_path = r"c:/Users/f.nikolakopoulos/AppData/Roaming/source/acad2/netcad/vstudio/ClassLibrary2/bin/Debug/"
assembly_path = r"C:/Users/f.nikolakopoulos/AppData/Roaming/source/cad2/net/sldworks_csharp_lib/sldworks_csharp_lib/bin/Debug/"


import sys
sys.path.append(assembly_path)

clr.AddReference("sldworks_csharp_lib")

from sldworks_csharp_lib import Sld

s = Sld()

s.sldinit()

s.print_active_doc_name()

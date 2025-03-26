
import win32com.client
import pythoncom
from win32com.client import Dispatch, VARIANT
from pythoncom import VT_VARIANT
import sys
import datetime
import shutil
import block 

app = win32com.client.Dispatch("BricscadApp.AcadApplication")
doc = app.ActiveDocument

def now_string():
    """
    exports now string of the form yyyymmdd_hhmm
    """
    x = datetime.datetime.now()
    y = (str(format(int(x.year-2000), "02d"))
         + str(format(int(x.month),  "02d"))
         + str(format(int(x.day),    "02d"))
         + str( format(int(x.hour), "02d"))
         + str(format(int(x.minute), "02d"))
         + str(format(int(x.second), "02d")))
    
    return y



def backup_current_document(ns):
    if not(doc.path):
        doc.Save()
    dest_path = "C://Users//f.nikolakopoulos//AppData//Roaming//draw//plot//backup//"
    fsource = doc.path+doc.name
    fdest = dest_path+doc.name[:-4]+ '_' + ns + '.' + doc.name[-3:]
    shutil.copy(fsource, fdest)
    print(f"""copy {fsource} to {fdest}""")

ns = now_string()
block.change_drawing_no(ns)
block.change_at
backup_current_document(ns)

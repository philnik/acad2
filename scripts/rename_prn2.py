import win32com.client
import pythoncom
from win32com.client import Dispatch, VARIANT
from pythoncom import VT_VARIANT
import sys
import datetime
import shutil

sys.path.append("c:/Users/f.nikolakopoulos/AppDATA/Roaming/source/acad2/acad/")



from rename import (rename_prn_to_pdf,
                    rename_prn_to_pdf2,
                    clean_plot_folder)

import block

plot_folder = "C://Users//f.nikolakopoulos//AppData//Roaming//draw//plot//"


app = win32com.client.Dispatch("BricscadApp.AcadApplication")
doc = app.ActiveDocument

def fetch_args():
    res = []
    for i in range(1,5):
        try:
            fl = float(sys.argv[i])
            res.append(fl)
            print(f"""fl[{i}]={fl}""")
        except:
            print("Error: No more floats")
    return res

def now_string():
    """
    exports now string of the form yyyymmdd_hhmm
    """
    import datetime
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
res = fetch_args()
#block.change_attributes_on_region(res, ns)
rename_prn_to_pdf(plot_folder)
#prn2pdf()
#rename_prn_to_pdf2(plot_folder,ns)
backup_current_document(ns)
clean_plot_folder()

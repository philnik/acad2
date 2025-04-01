import win32com.client
import pythoncom
from win32com.client import Dispatch, VARIANT
from pythoncom import VT_VARIANT
import sys
import datetime
import shutil
import os

sys.path.append("c:/Users/f.nikolakopoulos/AppDATA/Roaming/source/acad2/acad/")



from acad.rename import (rename_prn_to_pdf,
                    rename_prn_to_pdf2,
                    clean_plot_folder)

#import acad.block


app = win32com.client.Dispatch("BricscadApp.AcadApplication")
doc = app.ActiveDocument

def get_plot_folder(doc):
    if doc:
        return doc.GetVariable("PlotOutputPath")
    else:
        print("I will need a doc object")

def get_backup_folder(doc):
    bfolder = get_plot_folder(doc)
    if not os.path.exists(bfolder):
        os.makedirs(bfolder)
    return bfolder

    
plot_folder = "C://Users//f.nikolakopoulos//AppData//Roaming//draw//plot//"
plot_folder = "C://temp///plot//"
plot_folder = get_plot_folder(doc)


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
    dest_path = get_backup_folder(doc)
    if not(doc.path):
        doc.SaveAs(dest_path+"//"+doc.name)
    dest_path = "C://Users//f.nikolakopoulos//AppData//Roaming//draw//plot//backup//"
    dest_path = "c://temp/plot/backup/"
    dest_path = get_backup_folder(doc)
    
    fsource = doc.path+doc.name
    fdest = dest_path+doc.name[:-4]+ '_' + ns + '.' + doc.name[-3:]
    shutil.copy(fsource, fdest)
    print(f"""copy {fsource} to {fdest}""")


def change_drawing_no(new_value):
    # Define the block name and the attribute tag you're looking to update
    block_name = "telaro_bom"  # Replace with the actual block name
    attribute_tag = "DRAWINGNO"  # Replace with the actual attribute tag
    #new_value = "20251010"  # The value to set for the attribute

    # Loop through each entity in ModelSpace to find the block reference
    for entity in doc.ModelSpace:
        if entity.EntityName == "AcDbBlockReference" and entity.Name == block_name:
            # Loop through the attributes of the block reference
            for att in entity.GetAttributes():
                if att.TagString == "DRAWINGNO":
                    # Update the attribute's value
                    att.TextString = new_value
                    print(f"Updated attribute {attribute_tag} in block {block_name} to {new_value}")
                if att.TagString == "DATE":
                    att.TextString = date_string()






ns = now_string()
change_drawing_no(ns)
#res = fetch_args()
res = ""
#change_attributes_on_region(res, ns)
rename_prn_to_pdf(plot_folder)
#prn22pdf()
rename_prn_to_pdf2(plot_folder,ns)
backup_current_document(ns)
clean_plot_folder(plot_folder)

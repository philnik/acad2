import win32com.client
import pythoncom
from win32com.client import Dispatch, VARIANT
from pythoncom import VT_VARIANT

app = win32com.client.Dispatch("BricscadApp.AcadApplication")
doc = app.ActiveDocument

#doc.SendCommand("(setq pt (get2p)) ")


orientation="Landscape"
new_string = [
    "-PLOT",
    "Y",
    "",
    "PDF.pc3",
    "A4",
    "",
    orientation,
    "No",
    "Window",
    "(car pt) ",
    "(cadr pt) ",
    "Fit",
    "Center",
    "Yes",
    "default.ctb",
    "Yes",
    "A",
    "Yes",
    "Yes"
    " "
           ]
n = '\n'.join(new_string)
doc.SendCommand(n)


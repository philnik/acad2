import win32com.client
import math

acad = win32com.client.Dispatch("BricscadApp.AcadApplication")
doc = acad.ActiveDocument
model = doc.ModelSpace
paper = doc.PaperSpace
util = doc.Utility
blocks = doc.Blocks
#print(acad, doc,model,paper, util,blocks)
sCurName = doc.Name
print(sCurName)
line = model.AddLine("0,0","0,10")

def toRadians(inDegrees):
    toRadians = inDegrees * 3.141592 / 180
    return toRadians

def axial_lines():
    for i in range(50):
        r  = 30
        degrees = 360.0*i/50.0
        theta = degrees*math.pi/180.0
        x = r*math.cos(theta)
        y = r*math.sin(theta)
        epoint = f"{x},{y}"
        line = model.AddLine("0,0",epoint)

axial_lines()

def addarcs(max):        
    x = 0
    y = 0
    ctrPt = f"{x},{y}"
    for i in range(max):
        myArc = model.AddArc(ctrPt, i, toRadians(0), toRadians(360))
        myArc.Update

addarcs(100)
        
def a():
    hello=0
    world=1
    he=0
    i=0
        
doc.SendCommand("(+ 1 1) ")
    
print(doc.name)

root = "c:/Users/filip/Documents/"

doc.SaveAs(root+"delme.dwg")


 
 
newlayer = f"""(command "-LAYER"
  "N" "C-05,C-18,C-18-HIDD,C-18-CENT,C-25,C-25-HIDD,C-25-CENT,C-35,
   C-35-HIDD,C-35-CENT,C-50,C-70,C-100,C-DIMS,CA-25,CA-35,CA-50,CA-70"
  "C" "1" "C-25,C-25-HIDD,C-25-CENT,CA-25"
  "C" "2" "C-100"
  "C" "3" "C-35,C-35-HIDD,C-35-CENT,CA-35"
  "C" "4" "C-18-HIDD,C-18-CENT"
  "C" "5" "C-70,CA-70"
  "C" "7" "C-50,CA-50"
  "C" "8" "C-05,C-18,C-DIMS"
  "L" "HIDDEN2" "C-18-HIDD,C-25-HIDD,C-35-HIDD"
  "L" "CENTER2" "C-18-CENT,C-25-CENT,C-35-CENT"
  "D" "LINEWORK : VERY THIN" "C-05" ;Very Thin Linework
  "D" "LINEWORK : THIN" "C-18,C-18-HIDD,C-18-CENT" ;Thin Linework
  "D" "LINEWORK : THIN - MEDIUM" "C-25,C-25-HIDD,C-25-CENT" ;Thin to Medium Linework
  "D" "LINEWORK : MEDIUM" "C-35,C-35-HIDD-C-35-CENT" ;Medium Linework
  "D" "LINEWORK : MEDIUM - THICK" "C-50" ;Medium - Thick Linework
  "D" "LINEWORK : THICK" "C-70" ;Thick Linework
  "D" "LINEWORK : VERY THICK" "C-100" ;Very Thick Linework
  "D" "DIMENSIONS : PUT ALL DIMENSIONS ON THIS LAYER" "C-DIMS" ;Dims
  ;Annotation
  "D" "ANNOTATION : 2.5mm" "CA-25"
  "D" "ANNOTATION : 3.5mm" "CA-35"
  "D" "ANNOTATION : 5.0mm" "CA-50"
  "D" "ANNOTATION : 7.0mm" "CA-70"

  "" ; end Layer

); command
"""

doc = acad.ActiveDocument
model = doc.ModelSpace
doc.SendCommand(newlayer)

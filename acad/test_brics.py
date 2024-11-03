

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

def axial_lines():
    for i in range(50):
        r  = 10
        degrees = 360.0*i/50.0
        theta = degrees*math.pi/180.0
        x = r*math.cos(theta)
        y = r*math.sin(theta)
        epoint = f"{x},{y}"
        line = model.AddLine("0,0",epoint)
    

doc.SendCommand("(+ 1 1) ")
    
print(doc.name)

root = "c:/Users/filip/Documents/"

# (command "_.-hatch" "S" e "" "P" "ANSI37" 1.0 0.0 "")



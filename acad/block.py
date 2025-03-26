

import win32com.client
import pythoncom
from win32com.client import Dispatch, VARIANT
from pythoncom import VT_VARIANT
import sys
import datetime
import shutil

app = win32com.client.Dispatch("BricscadApp.AcadApplication")
doc = app.ActiveDocument

# Get the ModelSpace (where objects like blocks are stored)
model_space = doc.ModelSpace


def date_string():
    """
    exports now string of the form yyyymmdd_hhmm
    """
    import datetime
    x = datetime.datetime.now()
    y = (str(format(int(x.day),    "02d")) + '-' 
         + str(format(int(x.month),  "02d")) + '-'
         + str(format(int(x.year-2000), "02d")))
    return y

def change_drawing_no(new_value):
    # Define the block name and the attribute tag you're looking to update
    block_name = "telaro_bom"  # Replace with the actual block name
    attribute_tag = "DRAWINGNO"  # Replace with the actual attribute tag
    #new_value = "20251010"  # The value to set for the attribute

    # Loop through each entity in ModelSpace to find the block reference
    for entity in model_space:
        if entity.EntityName == "AcDbBlockReference" and entity.Name == block_name:
            # Loop through the attributes of the block reference
            for att in entity.GetAttributes():
                if att.TagString == "DRAWINGNO":
                    # Update the attribute's value
                    att.TextString = new_value
                    print(f"Updated attribute {attribute_tag} in block {block_name} to {new_value}")
                if att.TagString == "DATE":
                    att.TextString = date_string()


def change_attributes_on_region(region, new_value):
    # Define the block name and the attribute tag you're looking to update
    block_name = "telaro_bom"  # Replace with the actual block name
    attribute_tag = "DRAWINGNO"  # Replace with the actual attribute tag
    #new_value = "20251010"  # The value to set for the attribute

    # Loop through each entity in ModelSpace to find the block reference

    x1 = region[0]
    y1 = region[1]
    x2 = region[2]
    y2 = region[3]
    
    for entity in model_space:
        if entity.EntityName == "AcDbBlockReference" and entity.Name == block_name:
            block_position = entity.InsertionPoint
            x, y, z = block_position
            if x1 <= x <= x2 and y1 <= y <= y2:
                # Loop through the attributes of the block reference
                for att in entity.GetAttributes():
                    if att.TagString == "DRAWINGNO":
                        # Update the attribute's value
                        att.TextString = new_value
                        print(f"Updated attribute {attribute_tag} in block {block_name} to {new_value}")
                    if att.TagString == "DATE":
                        att.TextString = date_string()


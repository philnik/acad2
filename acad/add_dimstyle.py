v=[["DIMADEC", 0], ["DIMALT", 0], ["DIMALTD", 3], ["DIMALTF", 0.0393701], ["DIMALTMZF", 100], ["DIMALTMZS", ""], ["DIMALTRND", 0], ["DIMALTTD", 3], ["DIMALTTZ", 0], ["DIMALTU", 2], ["DIMALTZ", 0], ["DIMAPOST", ""], ["DIMARCSYM", 0], ["DIMASZ", 2.17], ["DIMATFIT", 3], ["DIMAUNIT", 0], ["DIMAZIN", 0], ["DIMBLK", "Arrow, filled"], ["DIMBLK1", "Arrow, filled"], ["DIMBLK2", "Arrow, filled"], ["DIMCEN", 10], ["DIMCLRD", 256], ["DIMCLRE", 256], ["DIMCLRT", 256], ["DIMDEC", 0], ["DIMDLE", 0], ["DIMDLI", 4], ["DIMDSEP", ","], ["DIMEXE", 0.5], ["DIMEXO", 0.5], ["DIMFRAC", 0], ["DIMFXL", 1], ["DIMFXLON", 0], ["DIMGAP", 0.5], ["DIMJOGANG", 45], ["DIMJUST", 0], ["DIMLDRBLK", "Arrow, filled"], ["DIMLFAC", 1], ["DIMLIM", 0], ["DIMLTEX1", 256], ["DIMLTEX2", 256], ["DIMLTYPE", 256], ["DIMLUNIT", 2], ["DIMLWD", 15], ["DIMLWE", 256], ["DIMMZF", 100], ["DIMMZS", ""], ["DIMPOST", ""], ["DIMRND", 0], ["DIMSAH", 0], ["DIMSCALE", 10], ["DIMSD1", 0], ["DIMSD2", 0], ["DIMSE1", 0], ["DIMSE2", 0], ["DIMSOXD", 0], ["DIMTAD", 1], ["DIMTDEC", 0], ["DIMTFAC", 1], ["DIMTFILL", 0], ["DIMTFILLCLR", 256], ["DIMTIH", 0], ["DIMTIX", 0], ["DIMTM", 0], ["DIMTMOVE", 0], ["DIMTOFL", 1], ["DIMTOH", 0], ["DIMTOL", 0], ["DIMTOLJ", 0], ["DIMTP", 0], ["DIMTSZ", 0], ["DIMTVP", 0], ["DIMTXSTY", "CALIBRI"], ["DIMTXT", 2.17], ["DIMTXTDIREC", 0], ["DIMTZIN", 8], ["DIMUPT", 0], ["DIMZIN", 8]]
import win32com.client
import pythoncom
from win32com.client import Dispatch, VARIANT
import win32com
acad = win32com.client.Dispatch("BricscadApp.AcadApplication")
adoc = acad.ActiveDocument
amodel = adoc.ModelSpace


ns = adoc.DimStyles.Add("DIM5")
res =[]
for row in v:
    print(row)
    myrow = [str(row[0]), str(row[1]), str(row[2])]
    try:
        adoc.SetVariable(str(row[0]), str(row[1]))
    except:
        res.append(myrow)

ns.CopyFrom(adoc)
res

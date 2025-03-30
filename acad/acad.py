#c:/Users/filip/anaconda3/Scripts/pip3 install --editable ./
#c:/ProgramData/anaconda3/Scripts/pip3 install --editable ./
#pip3 install --editable ./

import win32com.client
import pythoncom
from win32com.client import Dispatch, VARIANT
from pythoncom import VT_VARIANT
import sys

#ac = win32com.client.Dispatch('MyPythonCOM.Server')
#ac = win32com.client.Dispatch('PythonCOM.test')



class BCAD(object):
    def __init__(self):
        """Initialize dispatch."""
        self.acad = win32com.client.Dispatch("BricscadApp.AcadApplication")

    def __getattr__(self, n):
        """Getattr."""
        try:
            attr = getattr(self.acad, n)
        except:
            attr = super(BCAD, self).__getattr__(n)
        return attr

    def __setattr__(self, attr, n):
        """Setattr."""
        try:
            setattr(self.acad, attr, n)
        except:
            super(BCAD, self).__setattr__(attr, n)

class DOC(object):
    """Initialize doc."""
    def __init__(self):
        app = BCAD()
        self.doc = app.ActiveDocument

    def __getattr__(self, n):
        try:
            attr = getattr(self.doc, n)
        except:
            attr = super(DOC, self).__getattr__(n)
        return attr

    def __setattr__(self, attr, n):
        try:
            setattr(self.doc, attr, n)
        except:
            super(DOC, self).__setattr__(attr, n)


class MODEL(object):
    def __init__(self):
        doc = DOC()
        self.model = doc.ModelSpace

    def __getattr__(self, n):
        try:
            attr = getattr(self.model, n)
        except:
            attr = super(MODEL, self).__getattr__(n)
        return attr

    def __setattr__(self, attr, n):
        try:
            setattr(self.model, attr, n)
        except:
            super(MODEL, self).__setattr__(attr, n)


def start():
    acad = win32com.client.Dispatch("BricscadApp.AcadApplication")
    adoc = acad.ActiveDocument
    amodel = adoc.ModelSpace
    return [acad,adoc,amodel]

def add_table(model,v):
    """
    adds table to model from double list of the form v[][]
    """
    h = len(v)
    w = len(v[0])
    l = 2.17
    mytable = model.AddTable("0.0, 0.0",
                             h,
                             w,
                             l,
                             l*10)

    res = []
    for i in range(h):
        row = []
        for j in range(w):
            print("i="+str(i))
            value = v[i][j]
            print(value)
            row.append(value)
            mytable.SetCellValue(i,
                                 j,
                                 str(value))
            mytable.SetCellTextHeight(i,
                                      j,
                                      l)
    res.append(row)
    res
    return mytable


def work_with_ucs():
    coord_list = [[0,0,'ucs1'],
                  [297,0,'ucs2'],
                  [0,210,'ucs3'],
                  [297,210,'ucs4']]

    for p in coord_list:
        x = p[0]
        y = p[1]
        ucs_name = p[2]
        c = f"{x},{y}"
        xdir = f"{x+1},{y}"
        ydir = f"{x},{y+1}"
        print(c)
        ucs1 = adoc.UserCoordinateSystems.Add(c,
                                              xdir,
                                              ydir,
                                              ucs_name)
        adoc.ActiveUCS  = ucs1

def get_ucs_offset():
    adoc = acad.ActiveDocument
    amodel = adoc.ModelSpace
    ucs = adoc.ActiveUCS
    m = ucs.GetUCSMatrix()
    return [m[0][3], m[1][3]]


def create_new_ucs(mtext):
    l = ['ucs1', 'ucs2', 'ucs3', 'ucs4']
    for u in l:
        adoc.SendCommand("ucs NA R " + u + "\n")
        # adoc.ActiveUCS  = u
        m = get_ucs_offset()
        p = f"{m[0]},{m[1]}"
        print(u+":"+str(m))
        mo =  amodel.AddMtext(p, 500, mtext)
        print(mo.StyleName)
        print(mo.TextString)

#work_with_ucs()

def write_table_to_temp(v):
    """
    exports array to temp file
    """
    s0 = ""
    for row in v:
        srow = [str(i) for i in row]
        s = '\t'.join(srow)
        s0 = s0+s+'\n'
    s0
    file = open("c:/tmp/table.txt","w")
    file.write(s0)
    file.close()
    return s0


def test_greek(acad):
    mtext = f"""
    ÎµÎ»Î»Î·Î½Î¹ÎºÎ±
    """
    enc = sys.stdout.encoding
    #create_new_ucs(mtext.encode('utf-8'))

    adoc = acad.ActiveDocument
    amodel = adoc.ModelSpace
    me = mtext.encode('utf-8')
    me = me.decode('utf-8')
    me=mtext
    mo =  amodel.AddMtext("0,0", 500, mtext)
    mo =  amodel.AddMtext("500,0", 500, mtext)


def test_greek2(model,mtext="""Εδω τώρα γράφει ελληνικα"""):
    """Test greek with object"""
    mo = model.AddMtext("0,0",500,mtext)
    return mo

    
def newtextstyle():
    m = adoc.TextStyles.Add("Standard")
    m.FontFile = "Calibri Light"
    m.Height = 2.17



def change_dimensions_to_layer(adoc,layer_name):
    command = f"""(setvar "CMDECHO" 0)
    (setq sdim (ssget "_X" (list '(0 . "Dimension"))))
    (repeat (setq n (sslength sdim))
    (setq ed (entget (ssname sdim (setq n (1- n)))))
    (setq ed (subst (cons 8 "{layer_name}") (assoc 8 ed) ed ))
    (entmod ed)
    )
    (setvar "CMDECHO" 1)
    """
    adoc.SendCommand(command)



    

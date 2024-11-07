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
assembly_path = r"C:/Users/f.nikolakopoulos/AppData/Roaming/source/cad2/net/sldworks_csharp_lib/sldworks_csharp_lib/bin/Debug/sldworks_csharp_lib.dll"


import sys
sys.path.append(assembly_path)

clr.AddReference("ClassLibrary2")


from ClassLibrary2 import (Sql,
                           Acad,
                           Add)


def old_method():
    s= MyClass()
    s.Add(1,2)

    k = Sql()
    l = Acad()
    l.Init_acad()
    m = Add()
    m.acad = l
    sharpadd.acad = l


class acad():
    """
    references to local acad
    """
    def __init__(self):
        self.sharpcad = Acad()
        self.sharpcad.Init_acad()
        self.add = Add()
        self.add.acad = self.sharpcad

    def connect_to_cad(self):
        "start up COM connection on acad"
        self.sharpcad.Init_acad()



q0 = acad()


#q0.add.Line(1,2,3,4)


class add():
    """implements add functions"""
    def __init__(self):
        self.acad = acad()
        self.Add = self.acad.add

    def Random_Lines(self):
        self.Add.Line(0,0,10,0)
        self.Add.Line([0,0,1,2])
        self.Add.Line(0,1,0,1)
        self.Add.Line([0,1],[10,0])


def circle(Add):
    m = Add.Add
    for i in range(20):
        m.Line(0,0, math.cos(i), math.sin(i))

#circle(add())

def test_add1():
    myadd = add()
    myadd.Random_Lines()

#test_add1()




q0.add.MText([0,0], 100, """hello world
ελληνικα
αγγλικα
και αλλες γλωσσες""")


def add_more_circles(Add):
    m = Add.Add
    for i in range(100):
        m.Circle(0.0,100.0,i)
        m.Circle([0,0],i)
    

def add_lot_of_lines():
    for i in range(5000):
        c = 4
        angle = c*i/100.0*math.pi*2
        r = 10+i
        x = r*i*math.sin(angle*0.5)
        y = r*i*math.cos(angle)
        m.Line(x,0,0,y)


# add_lot_of_lines()
"""
    Sql.Get_sql_version()
    MyClass.Myfunc()
"""



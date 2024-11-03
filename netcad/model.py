
import clr
import sys

assembly_path = r"C:\Users\filip\source\repos\ClassLibrary2\bin\Debug"
sys.path.append(assembly_path)

clr.AddReference("ClassLibrary2")

from ClassLibrary2 import (Sql,
                           Acad,
                           Add,
                           Run)


class BCAD(object):

    def __init__(self):
        self.acad = Acad()
        self.acad.Init_acad()

    def __getattr__(self, n):
        try:
            attr = getattr(self.acad, n)
        except:
            attr = super(BCAD, self).__getattr__(n)
        return attr

    def __setattr__(self, attr, n):
        try:
            setattr(self.acad, attr, n)
        except:
            super(BCAD, self).__setattr__(attr, n)



class ADD(object):

    def __init__(self):
        self.Add = Add()
        self.parent = BCAD()
        self.Add.acad = self.parent.acad
        #Add.acad = parent.acad


    def __getattr__(self, n):
        try:
            attr = getattr(self.Add, n)
        except:
            attr = super(ADD, self).__getattr__(n)
        return attr

    def __setattr__(self, attr, n):
        try:
            setattr(self.Add, attr, n)
        except:
            super(ADD, self).__setattr__(attr, n)


class RUN(object):

    def __init__(self):
        self.Run = Run()
        self.parent = BCAD()
        self.Run.acad = self.parent.acad
        #Add.acad = parent.acad


    def __getattr__(self, n):
        try:
            attr = getattr(self.Run, n)
        except:
            attr = super(RUN, self).__getattr__(n)
        return attr

    def __setattr__(self, attr, n):
        try:
            setattr(self.Run, attr, n)
        except:
            super(RUN, self).__setattr__(attr, n)


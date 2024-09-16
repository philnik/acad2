
from acad.acad import BCAD

class document():
    """
    Class to describe documents

    docs, holds a list of all opened documents
    """
    docs = {}
    opened = []
    def __init__(self):
        self.b = BCAD()
        self.name = ""
        self.handle = ""
        self.template = "C:\\Users\\filip\\AppData\\Local\\Bricsys\\BricsCAD\\V24x64\\en_US\\Templates\\Default-mm.dwt"
        opened = self.get_opened()

    def new(self):
        """Creates a new document"""
        template = self.template
        b=self.b
        new_doc = b.Documents.Add(template)
        print(new_doc.name)
        self.handle = new_doc
        self.name = new_doc.name
        document.docs[self.name]=[self.handle, self]
        return new_doc

    def close(self):
        self.handle.close()
        del(self)

    def get_opened(self):
        b = self.b
        res = []
        for i in b.Documents:
            res.append([i.name,i])
        document.opened = res    
        return res

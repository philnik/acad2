import pythoncom
from win32com.server.exception import COMException
from win32com.server.util import wrap
from win32com.server.register import UseCommandLine
from acad.acad import DOC

#register comserver using shell
#python comserver.py --register

# Generate a unique GUID for your COM object (use pythoncom.CreateGuid())
MY_COM_CLASS_GUID = "{04231AAD-D8E9-464C-B95A-B1F5B033207A}"

#// {04231AAD-D8E9-464C-B95A-B1F5B033207A}
#static const GUID <<name>> = 
#{ 0x4231aad, 0xd8e9, 0x464c, { 0xb9, 0x5a, 0xb1, 0xf5, 0xb0, 0x33, 0x20, 0x7a } };

# Generate a GUID for your COM object (replace with your own)
#MY_COM_CLASS_GUID = pythoncom.CreateGuid()

class MyCOMServer:
    # Required COM attributes
    _public_methods_ = ['AddNumbers', 'Greet']
    _reg_clsid_ = MY_COM_CLASS_GUID
    _reg_progid_ = 'MyPythonCOM.Server'  # Unique ProgID
    _reg_desc_ = 'My Python COM Server'

    def AddNumbers(self, a, b):
        """Add two numbers."""
        return a + b + 1

    def Greet(self, name):
        """Return a greeting."""
        return f"Hello, {name}!"

    def plot_window_landscape(self):
        d=DOC()
        doc=d.doc
        doc.SendCommand("bpl ")
        

if __name__ == '__main__':
    # Register/Unregister the COM server using command-line arguments
    UseCommandLine(MyCOMServer)


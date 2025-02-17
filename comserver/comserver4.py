# SimpleCOMServer.py - A sample COM server - almost as small as they come!
# 
# We simply expose a single method in a Python COM object.
#import win32com.client
#ac = win32com.client.Dispatch('PythonDemos.Utilities')
import sys
sys.path.append("c://Users//filip//AppData//Roaming//python//acad2//acad")


class PythonUtilities:
    _public_methods_ = [ 'greet','get_BCAD','bpl' ]
    _reg_progid_ = "PythonDemos.Utilities"
    # NEVER copy the following ID 
    # Use "print pythoncom.CreateGuid()" to make a new one.
    _reg_clsid_ = "{11406e50-15e6-4cc1-afa5-51430eb3f64a}"

    def greet(self):
        print("hello")
        
    def get_BCAD(self):
        from acad.acad import BCAD
        return BCAD()

    def bpl(self):
        from acad.plot import plot_window_landscape
        plot_window_landscape()
    


# Add code so that when this script is run by
# Python.exe, it self-registers.
if __name__=='__main__':
    print("Registering COM server...")
    import win32com.server.register
    win32com.server.register.UseCommandLine(PythonUtilities)
    

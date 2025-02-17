# SimpleCOMServer.py - A sample COM server - almost as small as they come!
# 
# We simply expose a single method in a Python COM object.
#import win32com.client
#ac = win32com.client.Dispatch('PythonDemos.Utilities')

class PythonUtilities:
    _public_methods_ = [ 'greet' ]
    _reg_progid_ = "PythonDemos.Utilities"
    # NEVER copy the following ID 
    # Use "print pythoncom.CreateGuid()" to make a new one.
    _reg_clsid_ = "{11406e50-15e6-4cc1-afa5-51430eb3f64a}"

    def greet(self):
        print("hello")
    


# Add code so that when this script is run by
# Python.exe, it self-registers.
if __name__=='__main__':
    print("Registering COM server...")
    import win32com.server.register
    win32com.server.register.UseCommandLine(PythonUtilities)

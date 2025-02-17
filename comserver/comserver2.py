


import pythoncom
from win32com.server import (dispatcher,
                             register)
import uuid

#python comserver2.py /regserver

class MyCOMServer:
    _reg_clsid_ = '{E2D58075-422E-4732-9C30-DB9555CE4344}'
    _reg_progid_ = 'PythonCOM.test'  # The ProgID used to call the COM object
    _reg_desc_ = 'Python COM Server Example'

    def MyMethod(self):
        return "Hello from Python COM Server!"



if __name__ == "__main__":
    # Register the COM server when the script is run
    register.UseCommandLine(MyCOMServer)
    
    # Keep the server alive to handle incoming COM requests
    pythoncom.PumpMessages()  # This call keeps the server running

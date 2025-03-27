
class PythonUtilities:
    _public_methods_ = [ 'greet']
    _reg_progid_ = "cad.python"
    _reg_clsid_ = "{6c83a9f3-8bb6-48fb-ad54-3b428234f402}"

    def greet(self):
        print("hello")
        

if __name__=='__main__':
    print("Registering COM server...")
    import win32com.server.register
    win32com.server.register.UseCommandLine(PythonUtilities)

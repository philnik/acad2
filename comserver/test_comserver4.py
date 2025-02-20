import win32com.client
ac = win32com.client.Dispatch('cad.python')

ac.get_BCAD()

ac.bpl()

ac.greet()

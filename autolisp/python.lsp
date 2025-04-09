
;;; testing how to run 
(defun c:RunPythonFile ()
  ;;;update to run the python  file silently
  (vl-load-com)
  (setq wsh (vlax-create-object "WScript.Shell"))  ; Create Windows Shell object
  (vlax-invoke wsh 'Run "cmd /c python C:\\scripts\\example.py" 0  1)  ; Run Python script
  (vlax-release-object wsh)  ; Clean up
  (princ "\nPython script executed silently.")
)


;;; testing how to run 
(defun c:rename_prn ()
  ;;;update to run the python  file silently
  (vl-load-com)
  (setq wsh (vlax-create-object "WScript.Shell"))  ; Create Windows Shell object
  (vlax-invoke wsh 'Run
               "cmd /c python c:/Users/f.nikolakopoulos/AppData/Roaming/source/acad2/scripts/rename_prn.py"
               0  1)  ; Run Python script
  (vlax-release-object wsh)  ; Clean up
  (princ "\nPython script executed silently.")
)



;;; testing how to run 
(defun test_server2 (a b)
  ;;;update to run the python  file silently
  (vl-load-com)
  (setq scc (vlax-create-object "SimpleComServer.Calculator"))  ; Create Windows Shell object
  (setq mysum (vlax-invoke scc 'Add a b))
  (vlax-release-object scc)  ; Clean up
  
  mysum
  
)



;;; testing how to run 
(defun test_server2 ()
  ;;;update to run the python  file silently
  (vl-load-com)
  (setq scc (vlax-create-object "SimpleComServer.Brics2d"))  ; Create Windows Shell object
  (setq mysum (vlax-invoke scc 'Init_acad))
  (setq mysum (vlax-invoke scc 'GetPlotPath))
              
  (vlax-release-object scc)  ; Clean up
  (setq scc nil)
  (gc)
  mysum
)
  
(test_server2)



;;; testing how to run 
(defun test_server3 (a b)
  ;;;update to run the python  file silently
  (vl-load-com)
  (setq scc (vlax-create-object "SimpleComServer.Calculator"))  ; Create Windows Shell object
  (setq mysum (vlax-invoke scc 'GetNumbers))
  (vlax-release-object scc)  ; Clean up
  
  mysum
  
)

(vl-unload-vlx scc)

;;; testing how to run 
(defun test_divide (a b)
  (if scc (setq scc nil))
  (gc)
  (gc)
  ;;;update to run the python  file silently
  (vl-load-com)
  (setq scc (vlax-create-object "SimpleComServer.Calculator"))  ; Create Windows Shell object
  (setq mysum (vlax-invoke scc 'Divide2 a b))
  (vlax-release-object scc)  ; Clean up
  
  mysum
  
)

(if scc (setq scc nil))
  (gc)
  (gc)


;;; testing how to run 
(defun test_server4 ()
  ;;;update to run the python  file silently
  (vl-load-com)
  (setq scc (vlax-create-object "SimpleComServer.Calculator"))  ; Create Windows Shell object
  (setq mysum (vlax-invoke scc 'GetStrings))
  (setq csum mysum)
  (vlax-release-object scc)  ; Clean up
  (setq scc nil)
  csum
  
)

(test_server4)



;;; testing how to run 
(defun c:rename_prn2 (pt)
  ;;;update to run the python  file silently
  ;; it does not load local packagers
  (vl-load-com)
  (setq wsh (vlax-create-object "WScript.Shell"))  ; Create Windows Shell object
  (setq sx (rtos (car (car pt))))
  (setq sy (rtos (car (cadr pt))))
  (setq ex (rtos (cadr (car pt))))
  (setq ey (rtos (cadr (cadr pt))))
  
  (vlax-invoke wsh 'Run
               (strcat 
                "cmd /c "
                "set PATH=C:/ProgramData/anaconda3/;%PATH%"
                " "
                " && "
                " C:/ProgramData/anaconda3/condabin/activate.bat "
                " "
                " && "
                "C:/ProgramData/anaconda3/python.exe "
                "c:/Users/f.nikolakopoulos/AppData/Roaming/source/acad2/scripts/rename_prn2.py "
                " "
                sx sy ex ey)
               0  1)  ; Run Python script
  (vlax-release-object wsh)  ; Clean up
  (princ "\nPython script executed silently.")
)



;;; testing how to run 
(defun c:rename_prn_home ()
  ;;;update to run the python  file silently
  ;; it does not load local packagers
  (vl-load-com)
  (setq wsh (vlax-create-object "WScript.Shell"))  ; Create Windows Shell object
  (setq sx (rtos (car (car pt))))
  (setq sy (rtos (car (cadr pt))))
  (setq ex (rtos (cadr (car pt))))
  (setq ey (rtos (cadr (cadr pt))))
  
  
  ;;;"C:\Users\filip\anaconda3\condabin\activate.bat"
  
  (vlax-invoke wsh 'Run
               (strcat 
                "cmd /c "
                "set PATH=C:/Users/filip/anaconda3/;%PATH%"
                " "
                " && "
                " C:/Users/filip/anaconda3/condabin/activate.bat "
                " "
                " && "
                "C:/Users/filip/anaconda3/python.exe "
                
                "c:/Users/filip/AppData/Roaming/python/acad2/scripts/rename_prn2.py "
                " "
                sx sy ex ey)
               0  1)  ; Run Python script
  (vlax-release-object wsh)  ; Clean up
  (princ "\nPython script executed silently.")
)






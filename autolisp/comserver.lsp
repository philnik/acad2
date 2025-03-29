

;;; testing how to run 
(defun c:vbpl ()
  (vl-load-com)
  (setq wsh (vlax-create-object "PythonDemos.Utilities"))  ; Create Windows Shell object
  (vlax-invoke wsh 'bpl)
  (vlax-release-object wsh)  ; Clean up
  (princ "\make this")
)



;;; testing how to run 
(defun c:greet ()
  (vl-load-com)
  (setq wsh (vlax-create-object "PythonDemos.Utilities"))  ; Create Windows Shell object
  (vlax-invoke wsh 'greet)
  (vlax-release-object wsh)  ; Clean up
  (princ "\make this")
)


;; mode :is an integer to control the behaviour of the OS shell box :
;; 0        show the shell window in normal (last-used) mode
;; 1        show the shell window in normal (last-used) mode, but is not activated
;; 2        show the shell window in minimised, but inactive state
;; 3        show the shell window in minimised, and active state
;; 4        show the shell window in maximised state


;;(dos_command "ls" 2)
(defun a ()
(dos_command "python -c '''
import sys

def a():
 print('hello')

a()
''' &&
sleep 10
 " 0)
)
 
 
 

;;; testing how to run 
(defun c:newgreet ()
  (vl-load-com)
  (setq wsh (vlax-create-object "cad.python"))  ; Create Windows Shell object
  (vlax-invoke wsh 'bpl)
  ;;(vlax-release-object wsh)  ; Clean up
  (princ "\make this")
)




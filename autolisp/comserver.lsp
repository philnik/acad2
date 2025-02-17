

;;; testing how to run 
(defun c:vbpl ()
  (vl-load-com)
  (setq wsh (vlax-create-object "PythonDemos.Utilities"))  ; Create Windows Shell object
  (vlax-invoke wsh 'bpl)
  (vlax-release-object wsh)  ; Clean up
  (princ "\make this")
)


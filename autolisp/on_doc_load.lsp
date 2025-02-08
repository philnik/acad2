



(defun c:reload ()
  (load "parametric.lsp")
(load "textstyles.lsp")
(load "setlayers.lsp")
(load "add_dim.lsp")
(load "change_objects.lsp")
(load "text.lsp")


)


(defun c:cdef  (/ DS)
  (setq DS "mydim")
  (c:addlayers)
  (c:addstyles)
  (c:setdim)
  (if (tblsearch "dimstyle" DS)
      (command "-dimstyle" "S" DS "yes")
    (command ".-dimstyle" "S" DS)
    )
  
)

;;; testing how to run 
(defun c:RunPythonScript ()
  (vl-load-com)
  (setq wsh (vlax-create-object "WScript.Shell"))  ; Create Windows Shell object
  (vlax-invoke wsh 'Run "python C:\\scripts\\example.py")  ; Run Python script
  (vlax-release-object wsh)  ; Clean up
  (princ "\nPython script executed.")
)

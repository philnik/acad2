

(defun get-current-drawing-path ()
  (vlax-get-property (vla-get-ActiveDocument (vlax-get-Acad-Object)) 'FullName)
)



(defun save-copy-of-file (new-path)
  (vl-file-copy (get-current-drawing-path) new-path)
)

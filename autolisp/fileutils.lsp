

(setq wpath "c:/temp/")



(defun get-datetime-now ()
  (remove-dots (rtos (getvar "CDATE") 2 6))
)

(defun get-document-title ()
  (setq full (vlax-get-property (vla-get-ActiveDocument (vlax-get-Acad-Object)) 'Name))
  (setq noext (vl-filename-base full))
  noext
)

(defun get-current-drawing-path ()
  (vlax-get-property (vla-get-ActiveDocument (vlax-get-Acad-Object)) 'FullName)
)

(defun remove-dots (s)
  (vl-string-subst "" "." s)
)

(defun save-copy-of-file (new-path)
  (vl-file-copy (get-current-drawing-path) new-path)
)


(defun backup-file ()
  (setq full-name (strcat wpath (get-document-title) "_" (get-datetime-now) ".dwg"))
  (vl-file-copy (get-current-drawing-path) full-name)
)



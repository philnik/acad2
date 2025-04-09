

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

(defun get-newest-file (folder ext)
  (setq folder (vl-string-right-trim "\\" folder)) ; clean up folder path
  (setq files '())
  (setq newest-file nil)
  (setq newest-time 0)

  ;; get all matching files
  (foreach file (vl-directory-files folder (strcat "*." ext) 1)
    (setq fullpath (strcat folder "\\" file))
    (setq filetime (vl-file-systime fullpath))
    (if (> filetime newest-time)
      (progn
        (setq newest-time filetime)
        (setq newest-file fullpath)
      )
    )
  )
  newest-file
)

(defun get-print-file ()
  (get-newest-file "C://temp//plot" "prn"))




(defun backup-file ()
  (setq full-name (strcat wpath (get-document-title) "_" (get-datetime-now) ".dwg"))
  (vl-file-copy (get-current-drawing-path) full-name)
)



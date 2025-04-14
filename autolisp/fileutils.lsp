(setq wpath "c://temp//")
(setq wpath "c://draw//plot//")



(defun get-datetime-now ()
  (remove-dots (rtos (getvar "CDATE") 2 6))
)

(defun get-date ()
  ;;;20250414160659
  ;;;12345678__
  (setq cdate (get-datetime-now))
  (setq YY (substr cdate 3 2))
  (setq MM (substr cdate 5 2))
  (setq DD (substr cdate 7 2))
  (strcat DD "." MM "." YY)
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

(defun multi (list1)
  (progn
    (setq coeff '(1e8 1e7 1e6 1e5 1e4 1e3 1e2 1e1)) 
    (setq test2 (mapcar (lambda (a b) (* a b)) list1 coeff))
    (setq test3 (apply '+ test2))
    test3))

(defun get-newest-prn-file (folder ext)
  ;;;still not works
  (setq folder (vl-string-right-trim "//" folder)) ; remove trailing slash
  (setq files '())
  (setq newest-file nil)
  (setq newest-time 0) ; earliest possible systime

  (setq ns
  (foreach file (vl-directory-files folder (strcat "*." ext) 1)
    (setq fullpath (strcat folder "//" file))
    (setq ft (vl-file-systime fullpath))
    (setq filetime (multi ft))
    ;; compare using greater-than for time list
    (if (> filetime newest-time)
      (progn
        (setq newest-time filetime)
        (setq newest-file fullpath)
        newest-file
      )
    )
  ))
  ns
)

(defun get-print-file ()
  (get-newest-prn-file wpath "prn"))

(setq abc (get-print-file))


(defun backup-file ()
  (setq full-name (strcat wpath (get-document-title) "_" (get-datetime-now) ".dwg"))
  (vl-file-copy (get-current-drawing-path) full-name)
)

(defun rename_plot_file (ENTOBJ)
  (PROGN
    (setq doc_title (get-document-title))
    (setq block-date (get-block-tag ENTOBJ "DRAWINGNO"))
    (if (not block-date)
      (setq block-date (get-datetime-now))
    )
    (setq export_pdf_name (strcat wpath doc_title "_" block-date ".pdf"))
    (setq export_dwg_name (strcat wpath doc_title "_" block-date ".dwg"))
    (vl-file-copy (get-print-file) export_pdf_name)
    (vl-file-copy (get-current-drawing-path) export_dwg_name)
    
  )
)
  


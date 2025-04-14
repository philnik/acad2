"load autolisp plot file"

(defun after-plot-hook (pt)
  (c:rename_prn2 pt)
  )


(defun after-plot-hook-0 (pt)
  ;;;called from block
  ;;;send to fileutis.lsp
  (rename_plot_file pt)
  )



;;;plot pdf extensions
(defun bt (orientation window)
  (command "-PLOT"
           "Y"
           "Model"
           "PDF.pc3"
           "A4"
           ""
           orientation
           "No"
           window ;; "Extents" or "Window"
           "Fit"
           "Center"
           "Yes"
           "default.ctb"
           "Yes"
           "A"
           "Yes"
           "Yes"
           )
  )

(defun c:btl ()
  (bt "Landscape" "Extends")
  ;;;(after-plot-hook pt)
  )



(defun c:btp ()
  (bt "Portrait" "Extends")
  ;;;(after-plot-hook pt)
  )
;;;;


;;; plot pdf window
(defun get2p ()
  (setq pt1 (getpoint "\nLower-left corner: "))  ; Get the first point
  (setq pt2 (getpoint "\nTop-right corner: ")) ; Get the second point
  (list pt1 pt2)
)


(defun bp (orientation pt1 pt2)
  (command "-PLOT"
           "Y"
           "Model"
           "PDF.pc3"
           "A4"
           ""
           orientation
           "No"
           "Window"
           pt1
           pt2
           "Fit"
           "Center"
           "Yes"
           "default.ctb"
           "Yes"
           "A"
           "Yes"
           "Yes"
           )
  )

;;;;
(defun c:bpl ()
  (setq pt (get2p))
  (bp "Landscape" (car pt) (cadr pt))
  (after-plot-hook pt)
  )

(defun c:bcpl ()
  (setq ret (GetBlockCoords))
  (setq pt (cadr ret))
  (setq entobj (car ret))
  (setq now (get-datetime-now))
  (SET-BLOCK-DATE entobj)
  (bp "Landscape" (car pt) (cadr pt))
  (rename_plot_file entobj)
  
  )



(defun c:abpl ()
  (setq pt (get2p))
  (bp "Landscape" (car pt) (cadr pt))
;  (after-plot-hook pt)
  )


(defun c:bpp ()
  (setq pt (get2p))
  (bp "Portrait" (car pt) (cadr pt))
  (after-plot-hook pt)
  )
;;;;



(defun c:abpp ()
  (setq pt (get2p))
  (bp "Portrait" (car pt) (cadr pt))
;;  (after-plot-hook pt)
  )


(defun c:plotme ()
  (print " plotme ")
  )



(defun c:getbb ()
  (setq ss (ssget))
  
  (if ss
    (progn
      (setq ent (ssname ss 0))  ; Get the first selected entity
      (setq data (entget ent))  ; Get the entity data

      ; Extract the BBOX data using the 10 (point) and 11 (BBOX) codes
      (setq bbox (cdr (assoc 10 data)))  ; Get the base point from the data (code 10)
      
      ; Get the bounding box values (assuming the entity has extents)
      (setq minpt (cdr (assoc 10 data)))  ; Extract the minimum point from the entity's data
      (setq maxpt (cdr (assoc 11 data)))  ; Extract the maximum point from the entity's data

      ; Extract X, Y, and Z coordinates from minpt and maxpt
      (setq xmin (car minpt))
      (setq ymin (cadr minpt))
      (setq xmax (car maxpt))
      (setq ymax (cadr maxpt))

      ; Display the results
      (princ (strcat "\nBounding Box: "
                    "\nX Min: " (rtos xmin 2 4)
                    "\nY Min: " (rtos ymin 2 4)
                    "\nX Max: " (rtos xmax 2 4)
                    "\nY Max: " (rtos ymax 2 4)))
    )
    (princ "\nNo object selected.")
  )
  (princ)
)



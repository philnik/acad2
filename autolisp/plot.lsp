

"load autolisp plot file"


(defun c:bt ()
  (command "-PLOT"
           "Y"
           "Model"
           "PDF.pc3"
           "A4"
           ""
           "Landscape"
           "No"
           "Extents"
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



(defun c:plotme ()
  " plotme "
  )


(defun c:getbb ()
  (setq ss (ssget))  ; Prompt the user to select an object
  (if ss
    (progn
      (setq ent (ssname ss 0))  ; Get the first selected entity
      (setq obj (vlax-ename->vla-object ent))  ; Get the VLA-object reference
      (setq bbox (vlax-invoke obj 'GetBoundingBox))  ; Get the bounding box

      ; Extract the minimum and maximum points from the bounding box
      (setq minpt (vlax-get bbox 'Item 0))  ; Minimum point
      (setq maxpt (vlax-get bbox 'Item 1))  ; Maximum point

      ; Extract X, Y, and Z coordinates of the bounding box
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
   

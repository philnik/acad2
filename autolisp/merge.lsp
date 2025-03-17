(defun c:GetExtents ()
  (setq minPt (getvar "EXTMIN"))  ; Get minimum extents
  (setq maxPt (getvar "EXTMAX"))  ; Get maximum extents

  (princ "\nDrawing Extents:")
  (princ "\nMin Extent: ") (princ minPt)
  (princ "\nMax Extent: ") (princ maxPt)

  (princ)
)



(defun c:InsertDrawing ()
  (progn
  (vl-load-com)
  
  (setq current_minPt (getvar "EXTMIN"))  ; Get minimum extents
  (setq current_maxPt (getvar "EXTMAX"))  ; Get maximum extents


  (setq dwgFile (getfiled "Select DWG to Insert" "" "dwg" 8))
  (if (not dwgFile)
    (progn
      (princ "\nNo file selected.")
      (exit)
    )
  )


  (setq acadObj (vlax-get-acad-object))
  (setq currentDoc (vla-get-ActiveDocument acadObj)) ; Get current drawing
  (setq newDoc (vla-Open (vla-get-Documents acadObj) dwgFile)) ; Open external drawing

  (setq minPt (getvar "EXTMIN"))  ; Get minimum extents
  (setq maxPt (getvar "EXTMAX"))  ; Get maximum extents


  (setq minList minPt)
  (setq maxList maxPt)

  (princ "\nExtents of Opened Drawing:")
  (princ "\nMin Extent: ") (princ minList)
  (princ "\nMax Extent: ") (princ maxList)

  ;; Close the external drawing (must be closed before inserting)
  (vla-Close newDoc)

  ;; Insert the external drawing into the current drawing
  (setq insPoint (list 0 0 0)) ; Insert at origin, adjust if needed
  (setq new_x (+ (car current_maxPt) (car maxPt)))
  (setq new_y (+ (cadr current_maxPt) (cadr maxPt)))
	
  (setq insPoint (list new_x new_y 0))
  (setq scale 1.0) ; Scale factor
  (setq rotation 0.0) ; Rotation angle

  (setq blockRef (vla-InsertBlock
                    (vla-get-ModelSpace currentDoc)
                    (vlax-3d-point insPoint)
                    dwgFile
                    scale scale scale
                    rotation
                 ))

  (princ "\nDrawing inserted successfully!")

  (vlax-release-object acadObj) ; Release COM object
  (princ)
)
)

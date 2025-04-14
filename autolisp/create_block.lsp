
(defun GetBlockCoords ()
  (setq ent (entsel "\nSelect a block: "))
  (if ent
    (progn
      (setq entObj (vlax-ename->vla-object (car ent)))
      (if (eq (vla-get-ObjectName entObj) "AcDbBlockReference")
        (progn
          (setq ext (vlax-invoke entObj 'GetBoundingBox 'minPt 'maxPt))
          (setq minPt (vlax-safearray->list minPt))
          (setq maxPt (vlax-safearray->list maxPt))
          (princ (strcat "\nMin Coord: " (vl-prin1-to-string minPt)))
          (princ (strcat "\nMax Coord: " (vl-prin1-to-string maxPt)))
	  (list entObj (list minPt MaxPt))
        )
        (princ "\nSelected entity is not a block reference.")
      )
    )
    (princ "\nNo entity selected.")
  )
  (princ)
  (list entObj (list minPt MaxPt))
)



(defun c:GetBlockCoords ()
  (GetBlockCoords)
)


(defun c:cav (/ ent obj tag newval)
  (setq ent (car (entsel "\nSelect block: ")))
  (setq obj (vlax-ename->vla-object ent))
  (setq tag1 "DRAWINGNO")            ;; <-- Replace with your actual tag
  (setq val1 (get-datetime-now))
  
  (setq tag2 "DATE")            ;; <-- Replace with your actual tag
  (setq val2 (get-date))   

  (if (and obj (= (vla-get-hasattributes obj) :vlax-true))
    (foreach att (vlax-invoke obj 'GetAttributes)
      (setq attstring (strcase (vla-get-tagstring att)))
     
      (cond 
        ((eq attstring (strcase tag1))
         (vla-put-textstring att val1)
        )
        
        ((eq attstring (strcase tag2))
         (vla-put-textstring att val2)
        )
    )
  ) 
  )
  (princ)
)



(defun set-block-date (obj)
  ;;(setq ent (car (entsel "\nSelect block: ")))
  ;;(setq obj (vlax-ename->vla-object ent))
  (setq tag1 "DRAWINGNO")            ;; <-- Replace with your actual tag
  (setq val1 (get-datetime-now))
  
  (setq tag2 "DATE")            ;; <-- Replace with your actual tag
  (setq val2 (get-date))   

  (if (and obj (= (vla-get-hasattributes obj) :vlax-true))
    (foreach att (vlax-invoke obj 'GetAttributes)
      (setq attstring (strcase (vla-get-tagstring att)))
     
      (cond 
        ((eq attstring (strcase tag1))
         (vla-put-textstring att val1)
        )
        
        ((eq attstring (strcase tag2))
         (vla-put-textstring att val2)
        )
    )
  ) 
  )
  (princ)
)

(defun get-block-tag (obj tag)
  ;;(setq tag "DRAWINGNO")

  (progn  
    (setq ret nil)
    ( if (and obj (= (vla-get-hasattributes obj) :vlax-true))
      (foreach att (vlax-invoke obj 'GetAttributes)
        (setq attstring (strcase (vla-get-tagstring att)))
     
        (if (eq attstring (strcase tag))
         (setq ret (vla-get-textstring att))
        )
      ))
    ret)
)

(defun c:get-block-date ()
  (progn
    (setq tag "DRAWINGNO")
    (setq ent (car (entsel "\nSelect block: ")))
    (setq obj (vlax-ename->vla-object ent))
    (get-block-tag obj tag)
  ))
    
        
        
        

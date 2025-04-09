
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
	  (list minPt MaxPt)
        )
        (princ "\nSelected entity is not a block reference.")
      )
    )
    (princ "\nNo entity selected.")
  )
  (princ)
  (list minPt MaxPt)
)



(defun c:GetBlockCoords ()
  (GetBlockCoords)
)


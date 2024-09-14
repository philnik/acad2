



(defun c:Example_AddMtext()
    (vl-load-com)
    ;; This example creates an MText object in model space.
    (setq acadObj (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acadObj))
    
    ;; Define the multiline text object
    (setq corner (vlax-3d-point 0 10 0)
          width 100
          text "First line:\t this is the first line\nSecond line:\t this is the second\nThird line:\t 3"
	  )

    ;; Creates the mtext Object
    (setq modelSpace (vla-get-ModelSpace doc))
    (setq MTextObj (vla-AddMText modelSpace corner width text))
    (vla-ZoomAll acadObj)
)
(defun c:read_file ()
  (setq fl (open "c:/tmp/table.txt" "r")
	)
  (setq s0 "")
  (while (setq fil (read-line fl))
    (if (not (null fil))
	(setq s0 (strcat s0 fil "\n"))
      )
    )
  (close fl)
  s0)



(defun change_text_size (ed / scale l el)
  (vl-load-com)
  (setq scale (getvar "DIMSCALE"))
  (setq l (cons 40 (* 2.17 scale)))
  (setq el (subst l (assoc 40 ed) ed))
  (entmod el)
  )



(defun c:AddMtext2()
  (vl-load-com)
  ;; This example creates an MText object in model space.
  (setq acadObj (vlax-get-acad-object))
  (setq doc (vla-get-ActiveDocument acadObj))

  (setq pnt (getpoint "point to place:"))
    ;; Define the multiline text object
  (setq corner (vlax-3d-point (car pnt) (cadr pnt))
	width 100
	text (c:read_file)
	  )

    ;; Creates the mtext Object
  (setq modelSpace (vla-get-ModelSpace doc))
  (setq MTextObj (vla-AddMText modelSpace corner width text))
  (setq ent (vlax-vla-object->ename MTextObj))
  (setq mdata (entget ent))
;  (change_text_size mdata)
)

(defun c:add_scale_text (/ ed scale el )
  (progn 
  (setq ed ( c:AddMtext2 ))
  (setq scale (getvar "DIMSCALE"))
  (setq l (cons 40 (* 2.17 scale)))
  (setq ed (subst l (assoc 40 ed) ed))

  (setq l (cons 41 (* 100 scale)))
  (setq ed (subst l (assoc 41 ed) ed))

  (entmod ed)
    
  )
  )


(defun C:DEBA ( / ff1 xx1)
  (Setq selectionset (ssget "_A" '((0 . "MTEXT") (40 . 100.0))))
  (repeat (setq N (sslength selectionset))
	  (setq Data (ssname selectionset (setq N (- N 1))))
	  (setq EntityData (entget Data))
	  (setq ff1(assoc 40 EntityData))
	  (setq xx1 (cons 40 150.0))
	  (entmod(subst xx1 ff1 EntityData))
	  )
  (princ)
  )

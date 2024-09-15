

(setq nlayer "dimension")


;;   (setvar "CMDECHO" 0)


(defun C:c_textstyle ()
  (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))
  (setq styleCol (vla-get-TextStyles doc))
  (setq newStyle (vla-Add styleCol "Calibri"))
  (vla-put-FontFile newStyle "Calibri.ttf")
  (vla-put-Height newStyle 2.17)
;  (vla-put-WidthFactor newStyle 1.0)
;  (vla-put-ObliqueAngle newStyle 0.0)
;  (vla-put-TextGenerationFlag newStyle 0)
  (princ "\nNew text style 'NewStyle' created.")
)


(defun c_dim_scale (scale)
  (command "_.dimoverride" "DIMSCALE" scale "" (ssget "_C" '((0 . "Dimension"))) "")
)

(defun c:c_dim_scale (/ scale)
  (setq scale (getint "New Scale:"))
  (c_dim_scale scale)
)



(defun change_dimension_layer (layer_name)
 (progn
(setq sdim (ssget  '((0 . "Dimension"))))
(repeat (setq n (sslength sdim))
  (print n)
(setq ed (entget (ssname sdim (setq n (1- n)))))
(setq ed (subst (cons 8 layer_name) (assoc 8 ed) ed ))
(setq ed (subst (cons 3 "mydim") (assoc 3 ed) ed ))
(print ed)
(entmod ed))
))




 
(defun c:setdim_layer (/ nl)
x;  (setq nl (getstring "Layer name(Dimension):"))
  (setq nlayer
  (if (/= nl "")
      nl
      "dimension")
    )
  (print nlayer)
  (change_dimension_layer "dimension")
  )
;;(setvar "CMDECHO" 1)
;;(change_dimension_layer "1")
;;;change parameter - does not work from lisp
 (defun c:copyp ()
 (progn
   (setq ed (entget (ssname (ssget) 0)))
   (setq ed (subst (cons 42 200.0) (assoc 42 ed) ed ))
   (setq ed (subst (cons 1 "d3=200.0") (assoc 1 ed) ed ))
   (entmod ed))
 )

(defun c:get_objname ()
(progn 
(setq en_name (ssname (ssget) 0))
(setq obj_name (vla-get-objectname (vlax-ename->vla-object en_name)))
(print obj_name)
)
)

(defun c:get_handle ()
(progn 
  (setq en_name (ssname (ssget) 0))
  (setq handle (vla-get-handle (vlax-ename->vla-object (cdar elst))))
  (print handle )
  handle
  )
)


(defun c:get_line_length ()
(progn 
(setq en_name (ssname (ssget) 0))
(setq obj_name (vlax-ename->vla-object en_name))
(setq obj (vlax-get-property obj_name 'Length))
(print obj)
)
)


;;;no working
(defun c:set_line_length ()
  (progn
    (setq length (getdist "Length:"))
    (setq en_name (ssname (ssget) 0))
    (setq obj_name (vlax-ename->vla-object en_name))
    (vlax-put-property obj_name 'Length length)
    (print length)
    )
  )


(defun c:get_data ()
 (progn
   (setq en_name (ssname (ssget) 0))
   (setq ed (entget en_name))
   (print ed)
   ed
   ))

(defun c:set_line_endpoint ()
 (progn
   (setq en_name (ssname (ssget) 0))
   (setq ed (entget en_name))
   (setq ed (subst (cons 11 '(2.0 2.0 0.0)) (assoc 11 ed) ed ))
   (entmod ed)
   (print ed)
   ed
   )
 )

(defun c:get_line_length ()
 (progn
   (setq en_name (ssname (ssget) 0))
   (setq ed (entget en_name))
   (setq sp (cdr (assoc 10 ed)))
   (setq ep (cdr (assoc 11 ed)))
   (setq length (sqrt (+
		       (power (- (car  sp) (car  ep)) 2)
		       (power (- (cadr sp) (cadr ep)) 2)
		       )))
   length
   )
 )



;;;
;;;example of line
;((-1 . <Entity name: c4239cc0>) (0 . "LINE") (5 . "9C") (330 . <Entity name: c5168c50>) (100 . "AcDbEntity") (67 . 0) (410 . "Model") (8 . "0") (100 . "AcDbLine") (10 0.0 0.0 0.0) (11 1.0 1.0 0.0) (210 0.0 0.0 1.0)) ((-1 . <Entity name: c4239cc0>) (0 . "LINE") (5 . "9C") (330 . <Entity name: c5168c50>) (100 . "AcDbEntity") (67 . 0) (410 . "Model") (8 . "0") (100 . "AcDbLine") (10 0.0 0.0 0.0) (11 1.0 1.0 0.0) (210 0.0 0.0 1.0))
;;;




(defun c:change_layer ()
    (setq en_name (ssname (ssget) 0))
    (setq obj (vlax-ename->vla-object en_name))
    (vlax-put-property obj 'Layer "Defpoints")
    )


(setq origin
      "0,0"
      )

"AcDbRotatedDimension"




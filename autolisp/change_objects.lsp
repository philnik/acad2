

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




  (princ "\nI just have loaded parametric dimensions")

(defun c:ChangeDim ()
  (vl-load-com)

  ;; Get the active document
  (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))

  ;; Get the parameter manager (where parametric dimensions are stored)
  (setq paramMgr (vla-GetParametricManager doc))

  ;; Find the parameter by name (e.g., "Length1")
  (setq param (vla-GetParameter paramMgr "d1"))

  ;; Set a new value (e.g., change "Length1" to 50 units)
  (vla-put-Expression param "50")

  ;; Force update
  (vla-regen doc acActiveViewport)

  (princ "\nParametric dimension updated to 50.")
  (princ)
)


(defun c:UpdateParamDim ()
  (setq ent (car (entsel "\nSelect parametric dimension: ")))
  (if ent
      (progn
        (setq entData (entget ent))
        
        ;; Find the constraint parameter
        (setq param (assoc 1 entData))  ;; Group 1 contains the constraint expression

        (if param
            (progn
              ;; Change the expression (e.g., set it to 75)
              (setq newData (subst (cons 1 "75") param entData))
              (entmod newData)
              (princ "\nParametric dimension updated to 75.")
            )
            (princ "\nNo parametric constraint found.")
        )
      )
      (princ "\nNo object selected.")
  )
  (princ)
)


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

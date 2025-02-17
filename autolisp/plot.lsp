

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

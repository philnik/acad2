

"load plot file"
(setq output_folder "C://Users//filip//AppData//Roaming//draw//plots//")

(defun c:batchplot ()
  (setq fname "output.pdf")
  (setq full_name (strcat output_folder fname))
  (command "-PLOT" "Y" "Model" "Print As PDF.pc3" "A4" "Landscape" "No" "Extents" "Fit" "Yes" full_name "No" "Yes")
)



(defun c:plotme ()



  " plotme "


  )

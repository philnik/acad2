
(DEFUN C:ADDLAYERS (/ LAYERLIST)

(SETQ LAYERLIST '(
		  ("0" 7 "CONTINUOUS" 15)
		  ("DASHED" 8 "Dashed" 15)
		  ("DIMENSION" 162 "CONTINUOUS" 15)
		  ("STEEL" 7 "CONTINUOUS" 15)
		  ("TEXT" 162 "CONTINUOUS" 15)
		  ("CENTER" 1 "Center" 15))
      )

(vl-load-com)
(setq doc (vla-get-ActiveDocument (vlax-get-Acad-Object)))
(setq LayerCollection (vla-Get-Layers doc))

(mapcar '(lambda (x)
	   (setq NewLayer (vla-add LayerCollection (nth 0 x)))
	   (vla-put-color NewLayer (nth 1 x))

	   (if (not (tblobjname "ltype" (nth 2 x)))			; IF LINETYPE DOESN'T EXIST, LOAD IT. (STANDARD ACAD LINETYPES)
	       (vla-load (vla-Get-Linetypes doc) (nth 2 x) "iso.lin")
	     ); _end if
	   (vla-put-linetype NewLayer (nth 2 x))
	   (vla-put-Lineweight NewLayer (nth 3 x))
	   )
	LAYERLIST
	)
)


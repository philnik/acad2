


(setq fname_nodes "C:/Users/filip/AppData/Roaming/fem/elmer_fem/sound_test_again/sound2/mesh.nodes")


(defun read-coordinates (fname)
  (progn
(setq file (open fname "r") 
        coord-list '())

(if file
    (progn
      (while (setq line (read-line file))
        (setq pl (vl-string-split " " line))
        (setq row (list (atoi (nth 0 pl))
                        (atof (nth 2 pl))
                        (atof (nth 3 pl))
                        (atof (nth 4 pl))))
                              
        (setq coord-list (cons row coord-list))
        ;;;(print parts)
      ))
      (close file))
coord-list
  ))

(setq coord-list (read-coordinates fname_nodes))


(setq filename1 "C:/Users/filip/AppData/Roaming/fem/elmer_fem/sound_test_again/sound2/mesh.elements")

(setq filename2 "C:/Users/filip/AppData/Roaming/fem/elmer_fem/sound_test_again/sound2/mesh.boundary")

;;;0 1  2   3    4   5
;;;1 1 303 5011 6252 6254

;;;0 1  2  3  4   5  6 7
;;;1 1 763 0 303 573 1 2


(defun c:drawboundary (filename)
(setq f0 (open filename "r"))

    (progn
      (while (setq line (read-line f0))
        (setq parts (mapcar 'atoi (vl-string-split " " line)))  ; Split and convert to numbers
        (setq coord1 (cdr (assoc (nth 5 parts) coord-list)))
        (setq coord2 (cdr (assoc (nth 6 parts) coord-list)))
        (setq coord3 (cdr (assoc (nth 7 parts) coord-list)))
        (setq col (nth 1 parts))
        
         (if (and coord1 coord2)
          (entmake
            (list '(0 . "LINE")
                  '(100 . "AcDbEntity")
                  '(100 . "AcDbLine")
                    (cons 62 col)
                  (cons 10 coord1)
                  (cons 11 coord2)))
         )
         
         (if (and coord2 coord3)
          (entmake
            (list '(0 . "LINE")
                  '(100 . "AcDbEntity")
                  '(100 . "AcDbLine")
                    (cons 62 col)
                  (cons 10 coord2)
                  (cons 11 coord3)))
         )
          
        (if (and coord1 coord3)
          (entmake
            (list '(0 . "LINE")
                  '(100 . "AcDbEntity")
                  '(100 . "AcDbLine")
                  (cons 62 col)
                  (cons 10 coord3)
                  (cons 11 coord1)))
        )
         ))
      
      (print "end")
      (close f0)
  
)

(c:drawboundary filename2 )
;; Example usage:
;; (draw-edges "C://coordinates.txt" "C://edges.txt")

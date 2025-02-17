


(defun c:addstyles ()
;;(setvar "cmdecho" 0)
(command "-Style" "Italict" "Italict.shx"  ""    "" "" "" "" "");shx needs one more ""
(command "-Style" "calibri" "calibri"            "" "" "" "" "")
(command "-Style" "arial"   "arial.ttf"          "" "" "" "" "")
(command "-Style" "consolas" "consolas.ttf"      "" "" "" "" "")
(command "_.STYLE" "Standard" "Calibri Light" 0 1 "" "" "")
(command "_.STYLE" "SLDTEXTSTYLE0" "Calibri Light" 0 1 "" "" "")
(command "_.STYLE" "SLDTEXTSTYLE1" "Calibri Light" 0 1 "" "" "")
(command "_.STYLE" "SLDTEXTSTYLE2" "Calibri Light" 0 1 "" "" "")
;;(setvar "cmdecho" 1)
)


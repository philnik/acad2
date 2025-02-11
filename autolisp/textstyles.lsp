


(defun c:addstyles ()
;;(setvar "cmdecho" 0)
(command "-Style" "Italict" "Italict.shx"  ""    "" "" "" "" "");shx needs one more ""
(command "-Style" "calibri" "calibri"            "" "" "" "" "")
(command "-Style" "Standard" "calibri"           "" "" "" "" "")
(command "_.STYLE" "Standard" "Calibri Light" 0 1 "" "" "")
(command "-Style" "arial"   "arial.ttf"          "" "" "" "" "")
(command "-Style" "consolas" "consolas.ttf"      "" "" "" "" "")
;;(setvar "cmdecho" 1)
)


(command "_.STYLE" "Standard" "Calibri Light" 0 1 "" "" "")

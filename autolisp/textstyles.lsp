


(defun c:addstyles ()
;;(setvar "cmdecho" 0)
(command "-Style" "Italict" "Italict.shx"  ""    "" "" "" "" "");shx needs one more ""
(command "-Style" "calibri" "calibri"            "" "" "" "" "")
(command "-Style" "Standard" "calibri"           "" "" "" "" "")
(command "-Style" "arial"   "arial.ttf"          "" "" "" "" "")
(command "-Style" "consolas" "consolas.ttf"      "" "" "" "" "")
;;(setvar "cmdecho" 1)
)

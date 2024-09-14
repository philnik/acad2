(defun c:MyToggles (/ Dcl_Id% Toggle1$ Toggle2$ Toggle3$ Toggle4$ Toggle5$ Return#)
  (princ "\nMyToggles")(princ)
  ; Set Default Variables
  (if (not *MyToggles@);Unique global variable name to store dialog info
    (setq *MyToggles@ (list nil "0" "0" "0" "0" "0"))
  );if
  (setq Toggle1$ (nth 1 *MyToggles@)
        Toggle2$ (nth 2 *MyToggles@)
        Toggle3$ (nth 3 *MyToggles@)
        Toggle4$ (nth 4 *MyToggles@)
        Toggle5$ (nth 5 *MyToggles@)
  );setq
  ; Load Dialog
  (setq Dcl_Id% (load_dialog "mytoggles.dcl"))
  (new_dialog "MyToggles" Dcl_Id%)
  ; Set Dialog Initial Settings
  (set_tile "Title" " My Toggles")
  (set_tile "Toggle1" Toggle1$)
  (set_tile "Toggle2" Toggle2$)
  (set_tile "Toggle3" Toggle3$)
  (set_tile "Toggle4" Toggle4$)
  (set_tile "Toggle5" Toggle5$)
  ; Dialog Actions
  (action_tile "Toggle1" "(setq Toggle1$ $value)")
  (action_tile "Toggle2" "(setq Toggle2$ $value)")
  (action_tile "Toggle3" "(setq Toggle3$ $value)")
  (action_tile "Toggle4" "(setq Toggle4$ $value)")
  (action_tile "Toggle5" "(setq Toggle5$ $value)")
  (setq Return# (start_dialog))
  ; Unload Dialog
  (unload_dialog Dcl_Id%)
  (setq *MyToggles@ (list nil Toggle1$ Toggle2$ Toggle3$ Toggle4$ Toggle5$))
  (princ)
);defun c:MyToggles

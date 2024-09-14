



(defun c:reload ()
(load "textstyles.lsp")
(load "setlayers.lsp")
(load "add_dim.lsp")
(load "change_objects.lsp")
(load "text.lsp")
)


(defun c:cdef  (/ DS)
  (setq DS "mydim")
  (c:addlayers)
  (c:addstyles)
  (c:setdim)
  (if (tblsearch "dimstyle" DS)
      (command "-dimstyle" "S" DS "yes")
    (command ".-dimstyle" "S" DS)
    )
  
)

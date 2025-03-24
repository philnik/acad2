



(defun c:reload0 ()
                                        ;  (load "on_doc_load.lsp")
  (load "python.lsp")
  (load "parametric.lsp")
  (load "textstyles.lsp")
  (load "setlayers.lsp")
  (load "add_dim.lsp")
  (load "change_objects.lsp")
  (load "text.lsp")
  (load "plot.lsp")
  (load "comserver.lsp")
  (load "merge.lsp")
  (load "log.lsp")
  (load "colors.lsp")

)

(c:reload0)

(defun c:mktmpl ()
  (C:addstyles) ;; from text styles

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

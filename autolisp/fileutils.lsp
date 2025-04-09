





(defun save-copy-of-file (new-path)
  (vl-file-copy (getenv "DWGNAME") new-path)
)

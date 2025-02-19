(defun read-file-to-string (file-path)
  (setq file (open file-path "r"))  ; Open the file for reading
  (setq content "")  ; Initialize an empty string to store content
  
  (if file
    (progn
      (while (setq line (read-line file))  ; Read each line
        (setq content (strcat content line "\n"))  ; Append line to content
      )
      (close file)  ; Close the file when done
    )
    (princ "\nFile not found or cannot be opened.")
  )
  
  content  ; Return the full content of the file
)

(defun create-mtext-from-file (file-path insertion-point)
  (setq file-content (read-file-to-string file-path))  ; Get file content
  
  (if (not (zerop (strlen file-content)))  ; Check if the content is not empty
    (progn
      (setq mtext (entmake 
                    (list
                      (cons 0 "MTEXT")  ; Create an MText entity
                      (cons 10 insertion-point)  ; Set the insertion point
                      (cons 1 file-content)  ; Set the text content
                      (cons 40 40)  ; Set text height (optional)
                      (cons 71 1)  ; Set text style (optional)
                    )
                  )
      )
      (princ "\nMText object created from file.")
    )
    (princ "\nNo content to create MText.")
  )
)

;; Example usage:
;; Call the function with the file path and the insertion point (for example, (0 0 0))

(defun c:buffer_text ()
(create-mtext-from-file "c:/Users/filip/AppData/Roaming/python/acad2/autolisp/buffer_data.csv" '(0 0 0))
)

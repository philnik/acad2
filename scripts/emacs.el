(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq default-directory "C:/Users/filip/" )

(setenv "HOME" "c:/Users/filip/AppData/Roaming/")

(defun lsp-modeline-workspace-status-mode () 1 )
(defun lsp-modeline-diagnostics-mode () 1)
(defun lsp-modeline-code-actions-mode () 1)
(defun lsp-headerline-breadcrumb-mode () 1)

(defun install_packages ()
(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs
    projectile hydra flycheck company avy which-key  dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))
)


(defun load_yasnippets()
  (progn
    (use-package yasnippet
      :ensure t
      :config
      (yas-global-mode 1))  ;; Enable yasnippet globally

    (use-package yasnippet-snippets
      :ensure t)
    

    (define-key yas-minor-mode-map (kbd "C-c y") 'yas-expand)
    )
  )

(load_yasnippets)


(defun load_lsp ()
  
(use-package lsp-mode
  :hook ((python-mode . lsp)  ;; Start LSP in programming modes
         (lsp-mode . lsp-enable-which-key-integration)) ;; Enable `which-key` integration
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode)

;; (use-package company
;;   :hook (prog-mode . company-mode))

;; (use-package flycheck
;;   :hook (prog-mode . flycheck-mode))

(use-package which-key
  :config (which-key-mode))


(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0))

(use-package lsp-ui
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-delay 0.3
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-code-actions nil
	))


(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

)

(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode
  :hook ((elisp-mode . rainbow-delimiters-mode)
	 (python-mode .  rainbow-delimiters-mode))
  )

(load_lsp)

(server-start)

(tool-bar-mode -1)
(menu-bar-mode -1)


(add-hook 'prog-mode-hook 'auto-revert-mode)
(add-hook 'text-mode-hook 'auto-revert-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(custom-safe-themes
   '("d9e811d5a12dec79289c5bacaecd8ae393d168e9a92a659542c2a9bab6102041" "a455366c5cdacebd8adaa99d50e37430b0170326e7640a688e9d9ad406e2edfd" default))
 '(org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)"))
 '(package-selected-packages
   '(prettier ligature lua-mode yasnippet-classic-snippets yasnippet-snippets lsp-mode yasnippet projectile hydra flycheck company avy which-key))
 '(safe-local-variable-values
   '((Syntax . COMMON-LISP)
     (indent-tabs-mode)
     (eval cl-flet
	   ((enhance-imenu-lisp
	     (&rest keywords)
	     (dolist
		 (keyword keywords)
	       (let
		   ((prefix
		     (when
			 (listp keyword)
		       (cl-second keyword)))
		    (keyword
		     (if
			 (listp keyword)
			 (cl-first keyword)
		       keyword)))
		 (add-to-list 'lisp-imenu-generic-expression
			      (list
			       (purecopy
				(concat
				 (capitalize keyword)
				 (if
				     (string=
				      (substring-no-properties keyword -1)
				      "s")
				     "es" "s")))
			       (purecopy
				(concat "^\\s-*("
					(regexp-opt
					 (list
					  (if prefix
					      (concat prefix "-" keyword)
					    keyword)
					  (concat prefix "-" keyword))
					 t)
					"\\s-+\\(" lisp-mode-symbol-regexp "\\)"))
			       2))))))
	   (enhance-imenu-lisp
	    '("bookmarklet-command" "define")
	    '("class" "define")
	    '("command" "define")
	    '("ffi-method" "define")
	    '("ffi-generic" "define")
	    '("function" "define")
	    '("internal-page-command" "define")
	    '("internal-page-command-global" "define")
	    '("mode" "define")
	    '("parenscript" "define")
	    "defpsmacro"))))
 '(shr-max-width 1200)
 '(warning-suppress-log-types '((comp) (comp) (comp) (comp)))
 '(warning-suppress-types '((emacs) (comp) (comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 136 :width normal :foundry "outline" :family "Cascadia Code"))))
 '(rainbow-blocks-base-face ((t (:inherit nil :foreground "green"))))
 '(rainbow-blocks-depth-1-face ((t (:inherit rainbow-blocks-base-face :foreground "white"))))
 '(rainbow-blocks-depth-2-face ((t (:inherit rainbow-blocks-base-face :foreground "cyan"))))
 '(rainbow-blocks-depth-3-face ((t (:inherit rainbow-blocks-base-face :foreground "green"))))
 '(rainbow-blocks-depth-4-face ((t (:inherit rainbow-blocks-base-face :foreground "goldenrod"))))
 '(rainbow-blocks-depth-5-face ((t (:inherit rainbow-blocks-base-face :foreground "gold"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "cornflower blue")))))



;;;;;

(global-set-key (kbd "C-x C-n") 'find-file-at-point)


(setq visible-bell 1)

(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%a %e-%b %Y %H:%M>"))


(add-hook 'python-mode-hook
	  (lambda () (setq indent-tabs-mode nil)))

(require 'whitespace)
(setq whitespace-style '(tabs tab-mark)) ;turns on white space mode only for tabs
(global-whitespace-mode 1)




(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((lisp . t)
   (emacs-lisp . t)
   (ditaa . t)
   (dot . t)
   (sqlite . t)
;  (ledger . t)
   (maxima . t)
   (eshell . t)
   (lisp . t)
   (python . t)
   (gnuplot . t)
   (latex . t)
   (org . t)
   (shell . t)
   (fortran . t)
   ))


(defun my-tab-related-stuff ()
   (setq indent-tabs-mode nil)
   (setq tab-stop-list (number-sequence 4 200 4))
   (setq tab-width 4)
   (setq indent-line-function 'insert-tab))

(add-hook 'org-mode-hook 'my-tab-related-stuff)

;;c:/Users/filip/anaconda3/Scripts/pip3 install --editable ./

(setq anaconda-python "C:/Users/filip/anaconda3/python.exe")
(setq mspython "c:/Users/filip/AppData/Local/Microsoft/WindowsApps/python.exe")

(setq my-python anaconda-python)
(setq python-shell-interpreter my-python)
(setq python-shell-virtualenv-path "C:/Users/filip/anaconda3/")

(setq org-babel-python-command python-shell-interpreter)

(setq org-babel-lisp-eval-fn #'slime-eval)

(setq default-process-coding-system '(utf-8 . utf-8))

(setq inferior-lisp-program "sbcl")

(getenv "PATH")
(setq msbuild "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\")
(setenv "PATH" (concat (getenv "PATH") ";" msbuild))
(setenv "PATH" (concat (getenv "PATH") ";" "C://mingw64//bin//" ";"))
"C://mingw64//bin//mingw32-make.exe"


(setenv "PATH" (concat (getenv "PATH") ";" "c:/Users/filip/anaconda3/Library/bin/" "C:/Users/filip/anaconda3/"))
(setenv "PATH" (concat python-shell-virtualenv-path (getenv "PATH")))
(setenv "PATH" (concat "C:\\msys64\\usr\\bin\\" (getenv "PATH")   ))
(setenv "FIND" "C:\\msys64\\usr\\bin\\find.exe")
(setenv "ACAD" "c:/Users/filip/AppData/Roaming/python/acad2/")
(setenv "ACAD" "c:/Users/filip/AppData/Roaming/python/acad2/")
(setenv "FEM" "c:/Users/filip/AppData/Roaming/fem/elmer_fem/")
(setenv "gmsh" "C:/Program Files/FreeCAD 1.0/bin/gmsh.exe")
(setenv "gimp" "C:/Users/filip/AppData/Local/Programs/GIMP 2/bin/gimp-2.10.exe")
(setenv "mpiexec" "C:/Program Files (x86)/Intel/oneAPI/mpi/2021.13/bin/mpiexec.exe")
(setenv "freecadcmd" "C:/Program Files/FreeCAD 1.0/bin/freecadcmd.exe")


;; (with-eval-after-load 'eshell
;;   (eshell/alias "t" "wsl task $*")
;;   (eshell/alias "gmsh" "'C://Program Files//FreeCAD 1.0//bin//gmsh.exe' $*")
;;   (eshell/alias "gimp" "'C:\\Users\\filip\\AppData\\Local\\Programs\\GIMP 2\\bin\\gimp-2.10.exe'")
;;   (eshell/alias "FIND" "'C:\\msys64\\usr\\bin\\find.exe'")
;;   (eshell/alias "mpiexec" "'C:\\Program Files (x86)\\Intel\\oneAPI\\mpi\\2021.13\\bin\\mpiexec.exe'")
;;   )



(setq grep-find-template
      "C:\\msys64\\usr\\bin\\find.exe <D> <X> -type f <F> -exec grep <C> -nH -e <R> \\{\\} +")



;;;not accepted
(setq %python "C:\\Users\\filip\\anaconda3\\python.exe")
(setq @pip3 "C:\\Users\\filip\\anaconda3\\Scripts\\pip3.exe")
;;;"C:\msys64\usr\bin\ls.exe
(setq fls "C:\\msys64\\usr\\bin\\ls.exe -lrt -d -1 \"$PWD\"/")
(setenv "ffls" "C:\\msys64\\usr\\bin\\ls.exe -lrt -d -1 \"$PWD\"/")



(setq apip3 "C:\\Users\\filip\\anaconda3\\Scripts\\pip3.exe")

(setq make "C:\\mingw64\\bin\\mingw32-make.exe")

;; (defun my/dired-copy-full-path ()
;;   "Copy the full path of the file at point in dired mode."
;;   (interactive)
;;   (let ((filepath (dired-get-file-for-visit)))
;;     (kill-new filepath)
;;     (message "Copied: %s" filepath)))


;; (define-key dired-mode-map (kbd "C-c p") 'my/dired-copy-full-path)



(defun load_javascript ()
(progn 
  (require 'ob-js)

  (add-to-list 'org-babel-load-languages '(js . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))
  (add-hook 'js-mode 'nodejs-repl-minor-mode)
  (add-hook 'js-mode 'rainbow-mode)
  (add-hook 'js-mode 'rainbow-delimiters-mode)
  )
)


(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(setq inferior-lisp-program "C:/Data/ECL/ECL.exe")
(setq inferior-lisp-program "C:/Users/filip/opt/sbcl/sbcl.exe")
;(require 'omnisharp)

(defun load_csharp ()
  (progn 
;(add-hook 'csharp-mode-hook #'flycheck-mode)
    (add-hook 'csharp-mode-hook 'omnisharp-mode)
    )
  )


(defun load_utf ()

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
)
(load_utf)

(require 'htmlize)

(setq org-html-htmlize-output-type 'css) ;; or 'inline-css




(defun print_message ()
  (message "hello")
  )

(print_message)

(add-hook 'org-table-after-recalculate-hook #'print_message)


;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with C-x C-f and enter text in its buffer.

(add-to-list 'default-frame-alist '(alpha . (95 . 95)))

;; Enable prettify-symbols-mode globally
(global-prettify-symbols-mode 1)


;; Set Fira Code font
(add-to-list 'default-frame-alist
             '(font . "Cascadia Code-12"))

;; Enable prettify-symbols-mode for ligatures
(global-prettify-symbols-mode 1)

;; Set ligatures
(setq prettify-symbols-alist
      '(("->" . ?→)
        ("<-" . ?←)
        ("<=" . ?≤)
        (">=" . ?≥)
        ("==" . ?≡)
        ("!=" . ?≠)
        ("..." . ?…)))

;; Apply prettify-symbols-mode to programming modes
(add-hook 'prog-mode-hook 'prettify-symbols-mode)




;; Define some ligatures (example for some common code symbols)




(setq ligatures_list '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://")) 



(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures 't ligatures_list)
  )



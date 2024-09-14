; Copyright 2001 by EMT Software Inc. - by Scott Hull 05/14/01
;
; updated: 07/20/01
;
; This program will draw a 2D profile of an involute tooth gear.
;
(defun C:2DGEAR (/ #DCL-FILE #DCL-ID #DCL-LIST #FILE #HELP #PITCH #PITCHLIST
 #PREC #TEETH @ARC @BLOCK @GEAR-DRAW @GEAR-PTS @INSERT @LINE @PANG
 @POLYARC @POLYLINE @TEETH *error*)

; start or R14 compatibility library
(if (= (substr (getvar "acadver") 1 2) "14")
 (progn
(defun vl-file-delete (%A) nil)

(defun vl-filename-mktemp (%A / #DIR)
 (cond
  ((setq #DIR (getenv "tmp")) nil)
  ((setq #DIR (getenv "temp")) nil)
  (T (setq #DIR "")))
 (strcat #DIR "\\" %A))

(defun vl-position (%A %B)
 (if (member %A %B) (- (length %B) (length (member %A %B)))))

(defun vl-string-right-trim (%CHR %STR / #COUNT #LEN #LST #STR)
 (setq #COUNT 1
       #STR %STR
       #LEN (strlen %CHR))
 (repeat #LEN
  (setq #LST (cons (substr %CHR #COUNT 1) #LST)
        #COUNT (1+ #COUNT)))
 (while (member (substr #STR (setq #LEN (strlen #STR))) #LST)
  (setq #STR (substr #STR 1 (1- #LEN))))
 #STR)
))
; end of R14 compatibility library

 (defun *error* (%A)
  (if (= (type #FILE) 'FILE) (close #FILE))
  (cond
   ((= %A "Function cancelled") nil)
   (t (princ (strcat "\nerror: " %A "\007\n"))))
  (princ))

 (if (not (and (equal (getvar "ucsorg") (list 0.0 0.0 0.0))
               (equal (getvar "ucsxdir") (list 1.0 0.0 0.0))
               (equal (getvar "ucsydir") (list 0.0 1.0 0.0))))
  (progn (alert "You must be in the World UCS to use this program")
         (quit)))

 (setq #DCL-LIST (list
"gear2d : dialog {"
"  label = \"2D Gear\";"
"    : row {"
"      : column {"
"        spacer;"
"        : row {"
"          fixed_height = true;"
"          : toggle {"
"            key = \"prec\";"
"            label = \"&Precicion\";"
"          }"
"          : popup_list {"
"            height = 3;    "
"            label = \"&Pitch\";"
"            key = \"pitch_pop\";"
"            width = 16;"
"          }"
"        }"
"        : row {"
"          alignment = right;"
"          fixed_width = true;"
"          : edit_box {"
"            edit_width = 3;"
"            key = \"teeth\";"
"            label = \"&Teeth:\";"
"          }"
"          : button {"
"            key = \"teeth_minus\";"
"            label = \"-\";"
"          }"
"          : button {"
"            key = \"teeth_plus\";"
"            label = \"+\";"
"          }"
"        }"
"      }"
"      : boxed_radio_column {"
"        fixed_height = true;"
"        key = \"pang\";"
"        label = \"&Pressure angle\";"
"        : radio_button {"
"          key = \"14.5\";"
"          label = \"14.5 deg\";"
"        }"
"        : radio_button {"
"          key = \"20\";"
"          label = \"20 deg\";"
"        }"
"        : radio_button {"
"          key = \"25\";"
"          label = \"25 deg\";"
"        }"
"      }"
"    }"
"  spacer;"
"  ok_cancel_help_cadalog_errtile;"
"}"
""
"cadalog_button : retirement_button {"
"  key = \"cadalog\";"
"  label = \"&CADalog.com...\";"
"}"
""
"ok_cancel_help_cadalog : column {"
"  : row {"
"    fixed_width = true;"
"    alignment = centered;"
"    ok_button;"
"    : spacer {"
"      width = 2;"
"    }"
"    cancel_button;"
"    : spacer {"
"      width = 2;"
"    }"
"    help_button;"
"    : spacer {"
"      width = 2;"
"    }"
"    cadalog_button;"
"  }"
"}"
""
"ok_cancel_help_cadalog_errtile : column {"
"  ok_cancel_help_cadalog;"
"  errtile;"
"}"))

(setq #HELP (strcat
 "2D Gear Profiles\n\n"
 "This program draws 2D profiles of standard involute tooth gears. \n"
 "You can specify the pitch, pressure angle, number of teeth, and \n"
 "insertion point.\n\n"
 "The Precision check box will cause the gear to be created with a more\n"
 "accurate involute."))

(setq #PANG (* pi (/ 20.0 180.0)) #PITCH 12.0
      #PITCHLIST (list 1.0 2.0 2.25 2.5 3.0 4.0 6.0 8.0 10.0 12.0
  16.0 20.0 24.0 32.0 40.0 48.0 64.0 80.0 96.0 120.0 200.0))

 (defun @ARC (%A %B %C %D / #CEN)
  (setq #CEN (list (car %A) (cadr %A) (if (caddr %A) (caddr %A) 0)))
  (entmake (append (list '(0 . "ARC") '(8 . "0") (cons 10 #CEN)
   (cons 40 %B) (cons 50 %C) (cons 51 %D)))))

 (defun @BLOCK ()
  (entmake '((0 . "ENDBLK")))
  (entmake (list '(0 . "BLOCK") '(2 . "*XXX") '(70 . 1) '(10 0 0 0))))

 (defun @GEAR-DRAW (/ #INV #PT0 #PTS)
  (initget 1)
  (cond
   ((/= #PREC 1) (setq #INV 1))
   ((> #TEETH 134) (setq #INV 1))
   ((> #TEETH 54) (setq #INV 2))
   ((> #TEETH 34) (setq #INV 3))
   ((> #TEETH 25) (setq #INV 4))
   ((> #TEETH 20) (setq #INV 5))
   ((> #TEETH 16) (setq #INV 6))
   ((> #TEETH 13) (setq #INV 7))
   (T (setq #INV 8)))
  (setq #PT0 (getpoint "\nInsert point: ")
        #PTS (@GEAR-PTS (/ 1.0 #PITCH) #PANG #TEETH #INV))
  (@BLOCK)
  (@POLYLINE #PTS)
  (@INSERT (list (cons 10 #PT0))))

 (defun @GEAR-PTS (%PITCH %PANG %TEETH %TOOTHSEG / #A #B #C
  #ADDENDUM #ADDRAD #ANG #ANGCON #ANGCORRECT #ANGCRV #ANGDFF #ANGFILCTR 
  #ANGINC #ANGMIDCRV #ANGOUT #ANGTOPHLF #ANGTOPLND #BASERAD #BIGANGSTRT 
  #BOTPT1 #BOTPT2 #COUNT #DEDENDUM #DEDRAD #FILLIST #FILPT0 #FILPT1 
  #FILPT2 #FILPT3 #FILRAD #INC #INV_LG #LIST #P #PITCHRAD #PT0 #PTLIST
  #PTLIST0 #PTRAD #RADFILCTR #STRTANG #STRTRAD #STRTRADFIL #TMP #TOOTHANG 
  #TOOTHLIST #TOPLNDPT #X @ACOS @BOTFIL #PTANG #PTRAD @ACOS @ASIN @BOTFIL 
  @PTANG @PTRAD @TAN)

  (defun @ACOS (%A)
   (if (= %A 1.0) 0.0
   (setq %A (- (/ pi 2.0) (atan (/ %A (sqrt (- 1.0 (* %A %A)))))))))
   
 (defun @ASIN (%A) 
  (if (= %A 1) 1.0 (atan (/ %A (sqrt (- 1.0 (expt %A 2)))))))

;calculate fillet center
  (defun @BOTFIL (%R %BR %DR %SR / #RT #Y)
   (setq #Y (* (@TAN (@ACOS (/ %BR %SR))) %BR)
         #RT (/ (- (* %DR %DR) (* #Y #Y) (* %BR %BR)) (* 2.0 (- #Y %DR)))))
   
  (defun @PTANG (%RAD %BASERAD / #INTANG)
   (setq #INTANG (@ACOS (/ %BASERAD %RAD)))
   (- (@TAN #INTANG) #INTANG))

  (defun @PTRAD (%BIGANG %BASERAD)
   (/ %BASERAD (cos (atan %BIGANG))))

  (defun @TAN (%A) (/ (sin %A) (cos %A))) 

  (setq #ADDENDUM 1.0 #DEDENDUM 1.250 #FILRAD (* %PITCH 0.300))
 
  (setq #PT0 '(0.0 0.0)
        #PITCHRAD (* 0.5 %TEETH %PITCH)
        #BASERAD (* #PITCHRAD (cos %PANG))
        #ADDRAD (+ #PITCHRAD (* #ADDENDUM %PITCH))
        #DEDRAD (- #PITCHRAD (* #DEDENDUM %PITCH))
        #ANGCRV (@ACOS (/ #BASERAD #ADDRAD))
        #ANGCON (@TAN #ANGCRV)
        #ANGDFF (- #ANGCON #ANGCRV)
        #ANGMIDCRV (@PTANG #PITCHRAD #BASERAD)
        #ANGINC (/ (* 2.0 pi) %TEETH)
        #ANGTOPHLF (- #ANGDFF #ANGMIDCRV)
        #ANGTOPLND (- (* 0.5 #ANGINC) (* 2.0 #ANGTOPHLF))
        #RADFILCTR (+ #DEDRAD #FILRAD)
        #INC (max 2 (* 2 %TOOTHSEG)))

  (if (> #BASERAD #RADFILCTR)
   (setq #STRTANG 0.0 #STRTRAD #BASERAD
         #STRTRADFIL (sqrt (- (expt #RADFILCTR 2.0) (expt #FILRAD 2.0))))
   (setq #A #BASERAD 
         #C #RADFILCTR
         #B (sqrt (- (expt #C 2.0) (expt #A 2.0)))
         #INV_LG (- #B #FILRAD)
         #STRTRAD (sqrt (+ (expt #A 2.0) (expt #INV_LG 2.0)))
         #STRTRADFIL #STRTRAD
         #STRTANG (@PTANG #STRTRAD #BASERAD)))
 
  (setq #BIGANGSTRT (@TAN (@ACOS (/ #BASERAD #STRTRAD)))
        #ANGINCCON (/ (- #ANGCON #BIGANGSTRT) #INC))
  (if (> #BASERAD #RADFILCTR)      
   (setq #ANG (@ASIN (/ #FILRAD #RADFILCTR)))
   (setq #ANG (@ACOS (/ (+ (expt #STRTRAD 2.0) (expt #RADFILCTR 2.0) 
                (- (expt #FILRAD 2.0))) (* 2.0 #STRTRAD #RADFILCTR)))))
  (setq #FILPT0 (polar #PT0 (- #STRTANG #ANG) #RADFILCTR)
        #ANGFILCTR (angle #PT0 #FILPT0))

;DEFINE TOOTH POINTS    
  (setq #N 0.0
        #TOOTHLIST (cons (list #STRTANG #STRTRAD) #TOOTHLIST))
  (repeat #INC
   (setq #N (+ #N 1.0)
         #ANGOUT (+ (* #N #ANGINCCON) #BIGANGSTRT)
         #PTRAD (@PTRAD #ANGOUT #BASERAD)
         #ENDANG (@PTANG #PTRAD #BASERAD)
         #TOOTHLIST (cons (list #ENDANG #PTRAD) #TOOTHLIST)))  

;DEFINE GEAR POINTS 
  (setq #TOPLNDPT
   (polar #PT0 (+ #ANGDFF (* 0.5 #ANGTOPLND)) #ADDRAD)
        #ANGCORRECT (- (angle #PT0 #TOPLNDPT)))
  (foreach #X #TOOTHLIST
   (setq #PTLIST0 (cons (polar #PT0 (+ (car #X) #ANGCORRECT) (cadr #X))
     #PTLIST0)))

;DEFINE FILLET POINTS
  (setq #FILPT1 (polar #PT0 #STRTANG #STRTRADFIL)
        #FILPT2  (polar #FILPT0 (* 0.5
           (+ (angle #FILPT0 #PT0) (angle #FILPT0 #FILPT1))) #FILRAD)
        #FILPT3  (polar #PT0 #ANGFILCTR #DEDRAD))

  (foreach #X (list #FILPT1 #FILPT2 #FILPT3)
   (setq #FILLIST (cons (polar #PT0 (+ (angle #PT0 #X) #ANGCORRECT) 
    (distance #PT0 #X)) #FILLIST)))

;DEFINE BOTTOM LAND
  (setq #TOOTHANG (/ pi %TEETH 0.5)
        #BOTPT1 (polar #PT0 (* 0.5 #TOOTHANG) #DEDRAD)
        #BOTPT2 
         (polar #PT0 (+ #TOOTHANG (angle #PT0 (car #FILLIST))) #DEDRAD)
        #BOTPT2 (list (car #BOTPT2) (cadr #BOTPT2) 1)
        #COUNT 0)
;BUILD PTLIST
  (foreach #X #FILLIST
   (if (= #COUNT 2) 
    (setq #TMP (list (car #X) (cadr #X) 1))
    (setq #TMP (list (car #X) (cadr #X))))
   (setq #PTLIST (cons #TMP #PTLIST)
         #COUNT (1+ #COUNT)))
  (if (= #STRTRAD #STRTRADFIL) 
   (setq #COUNT 0 #PTLIST0 (cdr #PTLIST0))
   (setq #COUNT -1))
  (foreach #X #PTLIST0
   (if (= #COUNT 1) 
    (setq #TMP (list (car #X) (cadr #X) 1))
    (setq #TMP (list (car #X) (cadr #X))))
   (setq #PTLIST (cons #TMP #PTLIST))
   (if (= #COUNT 1) (setq #COUNT 0) (setq #COUNT (1+ #COUNT))))
  (setq #PTLIST (cons (polar #PT0 0.0 #ADDRAD) #PTLIST)
        #PTLIST0 (reverse #PTLIST0)
        #PTLIST (cons (list (caar #PTLIST0) (- (cadar #PTLIST0)) 1) #PTLIST)
        #PTLIST0 (cdr #PTLIST0)
        #COUNT 0)
  (foreach #X #PTLIST0
   (if (= #COUNT 1) 
    (setq #TMP (list (car #X) (- (cadr #X)) 1))
    (setq #TMP (list (car #X) (- (cadr #X)))))
   (setq #PTLIST (cons #TMP #PTLIST))
   (if (= #COUNT 1) (setq #COUNT 0) (setq #COUNT (1+ #COUNT))))
  (setq #COUNT 1)
  (foreach #X (reverse #FILLIST)
   (if (and (= (length (car #PTLIST)) 2) (= #COUNT 1))
    (setq #TMP (list (car #X) (- (cadr #X)) 1))
    (setq #TMP (list (car #X) (- (cadr #X)))))
   (setq #PTLIST (cons #TMP #PTLIST))
   (if (= #COUNT 1) (setq #COUNT 0) (setq #COUNT (1+ #COUNT))))
  (setq #ANG 0
        #PTLIST (cons #BOTPT1 #PTLIST)
        #PTLIST (reverse (cons #BOTPT2 #PTLIST)))
  (repeat %TEETH
   (foreach #X (reverse (cdr (reverse #PTLIST)))
    (setq #P (list (car #X) (cadr #X))
          #TMP (polar #PT0 (+ (angle #PT0 #P) #ANG) (distance #PT0 #P)))
    (if (caddr #X) (setq #TMP (list (car #TMP) (cadr #TMP) 1)))
    (setq #LIST (cons #TMP #LIST)))
   (setq #ANG (+ #ANG #ANGINC)))
  (setq #LIST (cons (append (last #LIST) (list 1)) #LIST))
  (reverse #LIST))

 (defun @INSERT (%A)
  (entmake (append
    (list '(0 . "INSERT") (cons 2 (entmake '((0 . "ENDBLK")))))
     %A (list (cons 41 1.0) (cons 42 1.0) (cons 43 1.0)))))

;%A - start point
;%B - endpoint
 (defun @LINE (%A %B / #A #B)
  (setq #A (if (caddr %A) (caddr %A) 0))
  (setq #B (if (caddr %B) (caddr %B) 0))
  (entmake (append '((0 . "LINE") (8 . "0"))
   (list (list 10 (car %A) (cadr %A) #A)
         (list 11 (car %B) (cadr %B) #B)))))

 (defun @PANG (%A)
  (cond
   ((= %A "14.5") (setq #PANG (* pi (/ 14.5 180.0))))
   ((= %A "20") (setq #PANG (* pi (/ 20.0 180.0))))
   ((= %A "25") (setq #PANG (* pi (/ 25.0 180.0))))))

 (defun @POLYARC (%PT1 %PT2 %PT3 / #1-2 #2-3 #ANG1-2 #ANG2-3 #END
  #MID #PROJ1 #PROJ2 #PT0 #START)
  (setq #ANG1-2 (angle %PT1 %PT2)
        #ANG2-3 (angle %PT2 %PT3)
        #1-2 (polar %PT1 #ANG1-2 (* 0.5 (distance %PT1 %PT2)))
        #2-3 (polar %PT2 #ANG2-3 (* 0.5 (distance %PT2 %PT3)))
        #PROJ1 (polar #1-2 (+ #ANG1-2 (* 0.5 pi)) 1.0)
        #PROJ2 (polar #2-3 (+ #ANG2-3 (* 0.5 pi)) 1.0)
        #PT0 (inters #1-2 #PROJ1 #2-3 #PROJ2 nil)
        #START (angle #PT0 %PT1)
        #MID (angle #PT0 %PT2)
        #END (angle #PT0 %PT3))
  (if (or (and (< #START #END) (or (> #MID #END) (< #MID #START)))
          (and (< #MID #START) (> #MID #END)))
   (setq #START #END #END (angle #PT0 %PT1)))
  (@ARC #PT0 (distance #PT0 %PT1) #START #END))

 (defun @POLYLINE (%PTLIST / #1 #2 #3 #FIRST #LAST 
  #PT1 #PT2 #PT3 #PTLIST)
  (setq #PTLIST %PTLIST 
        #FIRST (car #PTLIST)
        #LAST (last #PTLIST))
  (while (> (length #PTLIST) 1)
   (setq #1 (car #PTLIST)
         #2 (cadr #PTLIST)
         #3 (caddr #PTLIST)
         #PTLIST (cdr #PTLIST)
         #PT1 (list (car #1) (cadr #1))
         #PT2 (list (car #2) (cadr #2)))
   (if #3
    (setq #PT3 (list (car #3) (cadr #3))))
   (cond
    ((= (caddr #3) 1) 
     (@POLYARC #PT1 #PT2 #PT3)
     (setq #PTLIST (cdr #PTLIST)))
    (T (@LINE #PT1 #PT2)))))

 (defun @TEETH (%A / #TMP)
  (if (> (setq #TMP (abs (atoi %A))) 8) (setq #TEETH #TMP))
  (set_tile "teeth" (itoa #TEETH)))

 (setvar "cmdecho" 0)
 (setq #DCL-FILE (vl-filename-mktemp "2Dgear.dcl")
       #FILE (open #DCL-FILE "w"))
 (foreach #X #DCL-LIST (write-line #X #FILE))
 (close #FILE)
 (if (< (setq #DCL-ID (load_dialog #DCL-FILE)) 0)
  (progn
   (alert "\nCan't load DCL file.")
   (quit))
  (vl-file-delete #DCL-FILE))
 (if (not (new_dialog "gear2d" #DCL-ID)) (quit))
 (set_tile "pang" "20")
 (start_list "pitch_pop")
 (foreach #X #PITCHLIST
  (add_list (vl-string-right-trim "." (vl-string-right-trim "0" (rtos #X)))))
 (end_list)
 (set_tile "pitch_pop" (itoa (vl-position #PITCH #PITCHLIST)))
 (@TEETH "12")
 (action_tile "accept" "(done_dialog 1)")
 (action_tile "cadalog" "(done_dialog 2)")
 (action_tile "help" "(alert #HELP)")
 (action_tile "pang" "(@PANG $value)")
 (action_tile "pitch_pop" "(setq #PITCH (nth (atoi $value) #PITCHLIST))")
 (action_tile "prec" "(setq #PREC (atoi $value))")
 (action_tile "teeth" "(@TEETH $value)")
 (action_tile "teeth_minus" "(@TEETH (itoa (1- #TEETH)))")
 (action_tile "teeth_plus" "(@TEETH (itoa (1+ #TEETH)))")
 (setq #GO (start_dialog))
 (cond
  ((= #GO 1) (@GEAR-DRAW))
  ((= #GO 2) (command "_.browser" "www.cadalog.com")))
 (princ))


;;; Uncomment for the language needed.
;(princ "\n\n2DGEAR     ͂  ĊJ n")  ; For Japanese.
(princ "\n\nType 2DGEAR to start.") ; For English.

(princ)

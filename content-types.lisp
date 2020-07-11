(in-package #:hunchenhelpers)

;; We use `hunchentoot:defconstant' because it works on SBCL
#.`(progn
     ,@(loop for (name . code) in
             '((@plain       . "text/plain")
               (@json        . "application/json"))
             collect `(tbnl::defconstant ,name ,code)
             collect `(export (quote ,name))))

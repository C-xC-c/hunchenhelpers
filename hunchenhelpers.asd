(asdf:defsystem #:hunchenhelpers
  :description "A helper library for  hunchentoot"
  :author "Manx (boku@plum.moe)"
  :license "X11/MIT"
  :version "1.0.0"
  :serial t
  :depends-on (:hunchentoot)
  :Components ((:file "package")
               (:file "main")))

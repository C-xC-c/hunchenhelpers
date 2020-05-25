(asdf:defsystem #:hunchenhelpers
  :description "A helper library to simplify hunchentoot"
  :author "Manx (boku@plum.moe)"
  :license "X11/MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:hunchentoot)
  :Components ((:file "package")
               (:file "main")))

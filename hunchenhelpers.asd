(asdf:defsystem #:hunchenhelpers
  :description "A helper library for  hunchentoot"
  :author "Manx <boku@plum.moe>"
  :license "GPLv3"
  :version "1.1.0"
  :serial t
  :depends-on (:hunchentoot)
  :Components ((:file "package")
               (:file "main")))

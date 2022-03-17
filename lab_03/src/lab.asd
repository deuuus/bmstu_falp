;;;; quasirpg.asd

(asdf:defsystem #:lab
  :description "Part of the FiveAM tutorial"
  :author "Tomek 'uint' Kurcz"
  :license "GPLv3"
  :serial t
  :components ((:file "package")
               (:file "lab")))

(asdf:defsystem #:lab/tests
  :depends-on (:lab :fiveam)
  :components ((:module "tests"
            :serial t
            :components ((:file "package")
                         (:file "main")
                         (:file "task")))))

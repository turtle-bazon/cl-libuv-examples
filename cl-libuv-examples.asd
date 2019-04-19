;;;; -*- mode: lisp -*-

(defsystem :cl-libuv-examples
  :name "cl-libuv-examples"
  :author "Azamat S. Kalimoulline <turtle@bazon.ru>"
  :licence "GNU General Public License v3.0"
  :version "0.0.1.0"
  :description "Library that uses getent to retreive user system information"
  :depends-on (cl-libuv)
  :components ((:module "src"
		:components
			((:file "package")
			 (:file "tcp-echo-server" :depends-on ("package"))))))

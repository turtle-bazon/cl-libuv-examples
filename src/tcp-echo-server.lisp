;;;; -*- mode: lisp -*-

(in-package #:cl-libuv-examples)

(defparameter *loop* (uv:uv-default-loop))

(cffi:defcallback socket-accept-cb :void ((server :pointer) (status :int))
  (format t "New connection~&")
  (let ((client (uv:alloc-handle :tcp)))
    (uv:uv-tcp-init *loop* client)
    (uv:uv-accept server client)
    (uv:uv-close client (cffi:null-pointer))))

(defun start-tcp-echo-server ()
  (let ((server (uv:alloc-handle :tcp))
        (sockaddr (cffi:foreign-alloc '(:struct uv:sockaddr-in))))
    (uv:uv-tcp-init *loop* server)
    (uv:uv-ip-4-addr "0.0.0.0" 4334 sockaddr)
    (uv:uv-tcp-bind server sockaddr 0)
    (cffi:foreign-free sockaddr)
    (let ((r (uv:uv-listen server 128 (cffi:callback socket-accept-cb))))
      (format t "R: ~a~&" r)
      (uv:uv-run *loop* (cffi:foreign-enum-value 'uv:uv-run-mode :run-default)))))

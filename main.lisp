(in-package :hunchenhelpers)

(defun hunchenhost (func uri path &optional content-type)
  (let ((thing (if (null content-type)
                   (funcall func uri path)
                   (funcall func uri path content-type))))
    (push thing tbnl:*dispatch-table*)))

(defun host-file (uri path &optional content-type)
  (hunchenhost 'tbnl:create-static-file-dispatcher-and-handler uri path content-type))

(defun host-dir (uri path &optional content-type)
  (hunchenhost 'tbnl:create-folder-dispatcher-and-handler uri path content-type))

(defmacro handle (method uri content-type params &body body)
  "Creates an easy handles for a specific HTTP request method. If the
method provided sent from the client isn't correct, return 404 and
stop processing the request.

(handle :get (uri-fun :uri \"/path/to/page\"/) @content-type (args) (body))"
  `(tbnl:define-easy-handler ,uri ,params
     (unless (eq ,method (tbnl:request-method*))
       (setf (tbnl:return-code*) tbnl:+http-method-not-allowed+)
       (tbnl:abort-request-handler))
     (setf (tbnl:content-type* tbnl:*reply*) ,content-type)
     ,@body))

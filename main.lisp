(in-package #:hunchenhelpers)

(defclass acceptor (hunchentoot:easy-acceptor)
  ()
  (:default-initargs
   :address "127.0.0.1"
   :error-template-directory "/var/www/err/"
   :message-log-destination nil
   :access-log-destination nil
   :document-root nil)
  (:documentation "Because I hate writing code"))

;; Stolen from stackoverflow
(defmacro method-path (methods path)
  "Expands to a predicate the returns true of the Hunchtoot request
has a SCRIPT-NAME matching the PATH and METHOD in the list of METHODS.
You may pass a single method as a designator for the list containing
only that method."
  (declare (type (or keyword list) methods)
           (type string path))
  `(lambda (request)
     (and (member (hunchentoot:request-method* request)
                  ,(if (keywordp methods)
                       `'(,methods)
                       `',methods))
          (string= (hunchentoot:script-name* request)
                   ,path))))

(defmacro handle (request params &body body)
  "Creates an easy handles for a specific HTTP request method. If the
method provided sent from the client isn't correct, return 404 and
stop processing the request.

`request' should have a symbol `name', keyword or list of keywords
`method' and a string `uri'. One may also pass keyword arguments
`content-type', a string of the content type returned and list of
`acceptor', hunchentoot acceptor class that should listen for this
handler.

`params' are the request parameters of the client

`body' is what is evaluated and returned to the client"
  (destructuring-bind (name method uri &key content-type (acceptor t)
                       &aux (uri (eval uri)))
      request
    `(tbnl:define-easy-handler (,name :uri (method-path ,method ,uri)
                                      :acceptor-names (if (eq ,acceptor t) t (list ,acceptor)))
         ,params
       (when ,content-type
         (setf (tbnl:content-type* tbnl:*reply*) ,content-type))
       ,@body)))

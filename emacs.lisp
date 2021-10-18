(in-package #:nyxt-user)


;;
;; Source: https://ag91.github.io/blog/2021/07/09/org-capture-in-nyxt-taking-notes-while-browsing
;;

;;
;; Utilities
;;

(defun replace-all (string part replacement &key (test #'char=))
  "Return a new string in which all the occurences of the part is replaced with replacement."
  (with-output-to-string (out)
    (loop with part-length = (length part)
          for old-pos = 0 then (+ pos part-length)
          for pos = (search part string
                            :start2 old-pos
                            :test test)
          do (write-string string out
                           :start old-pos
                           :end (or pos (length string)))
          when pos do (write-string replacement out)
            while pos)))

;;
;; Evaluate in Emacs
;;

(defun eval-in-emacs (&rest s-exps)
  "Evaluate S-EXPS with emacsclient."
  (let ((s-exps-string (replace-all
                        (write-to-string
                         `(progn ,@s-exps) :case :downcase)
                        ;; Discard the package prefix.
                        "nyxt::" "")))
    (format *error-output* "Sending to Emacs:~%~a~%" s-exps-string)
    (uiop:run-program
     (list "emacsclient" "--eval" s-exps-string))))

;;
;; Caputre in Emacs
;;

(define-command-global org-capture ()
  "Org-capture current page."
  (eval-in-emacs
   `(org-link-set-parameters
     "nyxt"
     :store (lambda ()
              (org-store-link-props
               :type "nyxt"
               :link ,(quri:render-uri (url (current-buffer)))
               :description ,(title (current-buffer)))))
   `(org-capture nil "wN"))
  (echo "Note stored!"))


;;
;; Caputre in Emacs using Org Roam
;;
(define-command-global org-roam-capture ()
  "Org-roam-capture current page."
  (let ((quote (%copy))
        (title (prompt
                :input (title (current-buffer))
                :prompt "Title of note:"
                :sources (list (make-instance 'prompter:raw-source)))))
    (eval-in-emacs
     `(let ((file (ic/org-roam-make-filepath ,(car title) (current-time))))
        (ic/org-roam-insert-file
         file
         ,(car title)
         ,(render-url (url (current-buffer))))
        (find-file file)
        (org-id-get-create)))
    (echo "Org Roam Note stored!")))

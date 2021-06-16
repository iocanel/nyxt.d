(in-package #:nyxt-user)

(defvar *zulip-keymap* (make-keymap "zulip-keymap")
  "Keymap for `zulip-mode'.")

(define-mode zulip-mode ()
  "Mode for use when visiting a zulip buffer."
  ((keymap-schemes :initform
                   (list :emacs *zulip-keymap*
                         :vi-normal *zulip-keymap*))))

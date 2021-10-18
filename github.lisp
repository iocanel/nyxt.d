(in-package #:nyxt-user)

(defvar github-username "iocanel" "The github username to use in commands specified below.")
(define-command github-issues-new ()
  "Show all issues assigned to me."
  (let ((current-url (render-url (url (current-buffer)))))
    (ppcre:register-groups-bind (org repo) ("https://github.com/([a-zA-Z0-9_-]+)/([a-zA-Z0-9_-]+).*" current-url)
                                (buffer-load (concatenate 'string "https://github.com/" org "/" repo "/issues/new/")))))

(define-command github-issues-assigned ()
  "Show all issues assigned to me."
  (let ((current-url (render-url (url (current-buffer)))))
    (ppcre:register-groups-bind (org repo) ("https://github.com/([a-zA-Z0-9_-]+)/([a-zA-Z0-9_-]+).*" current-url)
                                (buffer-load (concatenate 'string "https://github.com/" org "/" repo "/issues/assigned/" github-username)))))
                                
(define-command github-pulls-authored ()
  "Show all issues assigned to me."
  (let ((current-url (render-url (url (current-buffer)))))
    (ppcre:register-groups-bind (org repo) ("https://github.com/([a-zA-Z0-9_-]+)/([a-zA-Z0-9_-]+).*" current-url)
                                (buffer-load (concatenate 'string "https://github.com/" org "/" repo "/pulls/" github-username)))))

(defvar github-keymap (make-keymap "github-keymap") "Keymap for `github-mode`.")

(define-key github-keymap "C-x i n" 'github-issues-new)
(define-key github-keymap "C-x i a" 'github-issues-assigned)
(define-key github-keymap "C-x p a" 'github-pulls-authored)

(define-key github-keymap "g i n" 'github-issues-new)
(define-key github-keymap "g i a" 'github-issues-assigned)
(define-key github-keymap "g p a" 'github-pulls-authored)

(define-mode github-mode ()
  "Mode for use when visiting a github buffer."
  ((keymap-scheme (keymap:make-scheme
                   scheme:cua github-keymap
                   scheme:emacs github-keymap
                   scheme:vi-normal github-keymap))))

(in-package #:nyxt-user)

(define-bookmarklet-command youtube-play-toggle
    "Play/Pause youtube videos."
  "document.getElementsByClassName('ytp-play-button')[0].click();")

(defvar youtube-keymap (make-keymap "youtube-keymap") "Keymap for `youtube-mode'.")
(define-key youtube-keymap "C-p" 'youtube-play-toggle)


(define-mode youtube-mode ()
  "Mode for use when visiting a youtube buffer."
  ((keymap-scheme (keymap:make-scheme
                   scheme:cua youtube-keymap
                   scheme:emacs youtube-keymap
                   scheme:vi-normal youtube-keymap))))

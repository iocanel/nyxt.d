(in-package #:nyxt-user)

;; Disable restory history prompt
(define-configuration browser
    ((session-restore-prompt :never-restore)))
    
; Execute command
(define-configuration buffer
    ((override-map (let ((map (make-keymap "override-map")))
                     (define-key map "C-s" 'nyxt/web-mode:search-buffer) ; Align with swiper
                     (define-key map "M-x" 'execute-command)
                     ))))

;; Enable vim bindings
(define-configuration (buffer web-buffer)
    ((default-modes (append '(blocker-mode auto-mode nyxt::vi-insert-mode) %slot-default%))))

(define-configuration (buffer prompt-buffer)
     ((default-modes (append '(nyxt::vi-insert-mode) %slot-default%))))


;; Search engines
(define-configuration buffer
    ((search-engines
      (list
      (make-instance 'search-engine
                      :shortcut "ghb"
                      :search-url "https://github.com/search?q=~a"
                      :fallback-url "https://github.com/trending")
       (make-instance 'search-engine
                      :shortcut "dd"
                      :search-url "https://duckduckgo.com/?kae=d&q=~a"
                      :fallback-url "https://duckduckgo.com/")
       (make-instance 'search-engine
                      :shortcut "yt"
                      :search-url "https://youtube.com/results?search_query=~a"
                      :fallback-url "https://youtube.com/")
       (make-instance 'search-engine
                      :shortcut "tw"
                      :search-url "https://twitter.com/search?src=typd&q=~a"
                      :fallback-url "https://twitter.com/")
       (make-instance 'search-engine
                      :shortcut "so"
                      :search-url "https://stackoverflow.com/search?q=~a"
                      :fallback-url "https://stackoverflow.com/")
       (make-instance 'search-engine
                      :shortcut "tv"
                      :search-url "https://www.thingiverse.com/search?q=~a"
                      :fallback-url "https://www.thingiverse.com/")
       (make-instance 'search-engine
                      :shortcut "sk"
                      :search-url "https://www.skroutz.gr/search?keyphrase=~a"
                      :fallback-url "https://www.skroutz.gr/")
       (make-instance 'search-engine
                      :shortcut "wp"
                      :search-url "https://www.wikipedia.org/w/index.php?title=Special:Search&search=~a"
                      :fallback-url "https://www.wikipedia.org/")
       (make-instance 'search-engine
                      :shortcut "ggl"
                      :search-url "https://www.google.com/search?q=~a"
                      :fallback-url "https://www.google.com")))))


(load (nyxt-init-file "emacs.lisp"))
(load (nyxt-init-file "github.lisp"))
(load (nyxt-init-file "youtube.lisp"))
(load (nyxt-init-file "zulip.lisp"))

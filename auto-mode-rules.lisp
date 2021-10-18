;; List of auto-mode rules.
;; It is made to be easily readable and editable, but you still need to remember some things:
;;
;; Every rule starts on a new line and consists of one or more of the following elements:
;; - Condition for rule activation. It is either (match-domain ...),
;;   (match-host ...), (match-regex ...) or a string.
;; - :included (optional) -- List of the modes to enable on condition.
;; - :excluded (optional) -- List of the modes to disable on condition.
;; - :exact-p  (optional) -- Whether to enable only :included modes and disable
;;    everything else (if :exact-p is t), or just add :included and exclude :excluded
;;    modes from the current modes list (if :exact-p is nil or not present).
;;
;; Included modes is a list of mode symbols, or a list of lists in the form
;; of (MODE-SYMBOL INIT-ARGS), where init-args are passed to the mode when instantiated.
;;
;; Conditions work this way:
;; - match-domain matches the URL domains only.
;;   Example: (match-domain "reddit.com") will work for all of Reddit.
;; - match-host is more specific -- it activates only on certain subdomains of the website.
;;   Example: (match-host "old.reddit.com") will work on old Reddit only.
;; - match-regex works for any address that matches a given regex. You can add these manually,
;;   but remember: with great regex comes great responsibility!
;;   Example: (match-regex "https://github\.com/.*/.*") will activate only in repos on GitHub.
;; - String format matches the exact URL and nothing else
;;   Example: "https://lispcookbook.github.io/cl-cookbook/pattern_matching.html"
;;            will work on the Pattern Matching article of CL Cookbook, and nowhere else.
;;
;; You can write additional URLs in the bracketed conditions, to reuse the rule for other URL
;; Example: (match-host "reddit.com" "old.reddit.com" "www6.reddit.com")
;;
;; This file needs to be placed under $HOME/.local/share/nyxt
;;
(
((match-domain "github.com")  :included (github-mode))
((match-domain "zulipchat.com")  :included (zulip-mode))
((match-domain "youtube.com")  :included (youtube-mode))
)

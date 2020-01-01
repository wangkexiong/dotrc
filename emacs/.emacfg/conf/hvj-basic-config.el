;;basic settings
(set-cursor-color "white")
(set-mouse-color "white")
(set-face-foreground 'highlight "white")
(set-face-background 'highlight "blue")
(set-face-foreground 'region "cyan")
(set-face-background 'region "blue")
(set-face-foreground 'secondary-selection "skyblue")
(set-face-background 'secondary-selection "darkblue")

;;show line NO.
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;;disable scroll-bar
(setq scroll-bar-mode nil)

;;backup settings
;;enable version control
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/.emacs.tmp")))
(setq backup-by-copying t)

;;auto-complete
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-line
         try-expand-line-all-buffers
         try-expand-list
         try-expand-list-all-buffers
         try-expand-dabbrev
         try-expand-dabbrev-visible
         try-expand-dabbrev-all-buffers
         try-expand-dabbrev-from-kill
         try-complete-file-name
         try-complete-file-name-partially
         try-complete-lisp-symbol
         try-complete-lisp-symbol-partially
         try-expand-whole-kill))

;;timestamp
(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(setq time-stamp-format "%:u %02m/%02d/%04y %02H:02M:02S")
(add-hook 'write-file-hooks 'time-stamp)

;;time display
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 10)

;;minibuffer
(minibuffer-electric-default-mode 1)
(icomplete-mode 1)                      ;enable autocomplete functions and variables in minibuffer
(fset 'yes-or-no-p 'y-or-n-p)
(setq resize-mini-windows t)
(setq uniquify-buffer-name-style 'forward)
(column-number-mode t)
(setq Man-notify-method 'pushy)         ;using current buffer for man page
(mouse-avoidance-mode 'animate)
(auto-image-file-mode)
(auto-compression-mode 1)               ;can operate compress zip files
(setq default-fill-column 60)
(blink-cursor-mode -1)
(transient-mark-mode 1)
(show-paren-mode 1)
(setq mouse-wheel-mode t)
(setq visible-bell nil)
(setq scroll-step 1 scroll-margin 3 scroll-conservatively 10000)

;;set end of sentence for chinese
(setq sentence-end "\\([&#161;&#163;&#163;&#161;&#163;&#191;]\\|&#161;&#173;&#161;&#173;\\|[.?!][]\"'}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)
(setq next-line-add-newlines nil)
(setq require-final-newline t)
(setq track-eol t)
(setq-default kill-whole-line t)        ;C-k to delete line from current position, like D in vim
(setq kill-ring-max 200)                ;delete history setting with 200
(setq apropos-do-all t)                 ;enlarge the search scope
(setq-default ispell-program-name "aspell")
(put 'narrow-to-region 'disabled nil)
(setq frame-title-format "%b")
(setq x-select-enable-clipboard t)

;;Window Maximized
(if (eq system-type 'windows-nt)
  (run-with-idle-timer 0.5 nil 'w32-send-sys-command 61488))

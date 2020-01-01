;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Life is a box of chocalates,
;;; you never know what you're gonna get.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;common settings
(setq user-full-name        "wangkexiong")
(setq user-mail-address     "wangkexiong@gmail.com")
(setq abbrev-file-name      "~/.emacs.d/.abbrev_defs")
(setq bookmark-default-file "~/.emacs.d/.emacs.bmk")

;;Patch for https not working for emacs...
(require 'package)
(unless (memq system-type '(windows-nt ms-dos))
   (if (string= "cons" (type-of (gnutls-available-p)))
       (unless (memq 'ClientHello\ Padding (gnutls-available-p))
               (add-to-list 'package-archives
                            '("melpa-http" . "http://melpa.org/packages/") t))
       (add-to-list 'package-archives
                    '("melpa-http" . "http://melpa.org/packages/") t)))
(package-initialize)

;;load-path
(setq load-path (cons "~/.emacfg/assit" load-path))
(setq load-path (cons "~/.emacfg/conf"  load-path))

;;**prelude**
(setq load-path (cons "~/.emacfg/prelude" load-path))
(load "init")
(load "prelude-modules")
(load "prelude-personal")

;;system tuning
(load "hvj-basic-config")
(load "hvj-calendar")
(load "hvj-dictionary")
(load "hvj-dired")
(load "hvj-erc.el")
(load "hvj-folding")
(load "hvj-function")
(load "hvj-ido")
(load "hvj-key-bindings")
(load "hvj-language")
(load "hvj-mew")
(load "hvj-mode")
(load "hvj-w3m")
(load "hvj-wiki")

;;restore last working space
(load "desktop")
(desktop-load-default)
(desktop-read)

;;only enable this when new installed or configuration changed
;;byte-compilation will do fast the startup
;(byte-recompile-directory (expand-file-name "~/.emacfg") 0)


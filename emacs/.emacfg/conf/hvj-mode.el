;;change default mode from fundemental-mode to text-mode
(setq default-major-mode 'text-mode)

;;syntax highlight
global-font-lock-mode t

;;for programming
(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not text-mode))
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))

;;setting syntax highlight according filename extensions
;;using C-h v auto-mode-alist to check
(mapcar
  (function (lambda (setting)
              (setq auto-mode-alist
                    (cons setting auto-mode-alist))))
  '(("\\.\\(xml\\|rdf\\)\\'" . sgml-mode)
    ("\\.\\([ps]?html?\\|cfm\\|asp\\)\\'" . html-helper-mode)
    ("\\.css\\'" . css-mode)
    ("\\.\\(emacs\\|session\\|gnus\\)\\'" . emacs-lisp-mode)
    ("\\.wiki\\'" . emacs-wiki-mode)
    ("\\.\\(jl\\|sawfishrc\\)\\'" . sawfish-mode)
    ("\\.scm\\'" . scheme-mode)
    ("\\.py\\'" . python-mode)
    ("\\.\\(ba\\)?sh\\'" . sh-mode)
    ("\\.l\\'" . c-mode)
    ("\\.max\\'" . maxima-mode)))


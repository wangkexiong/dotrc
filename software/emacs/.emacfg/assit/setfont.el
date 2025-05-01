(defun font-existsp (font)
  (if (null (x-list-fonts font))
    nil t))

(defun make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
    (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))

(defun set-font (english-fonts english-font-size
                               chinese-fonts
                               &optional chinese-font-size)
  (require 'cl)                         ; for find if
  (let ((en-font (make-font-string
                   (find-if #'font-existsp english-fonts)
                   english-font-size))
        (zh-font (font-spec :family (find-if #'font-existsp chinese-fonts)
                            :size chinese-font-size)))

    ;; Set the default English font
    ;;
    ;; The following methods failed to make font settings in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute 'default nil :font en-font)

    ;; Set Chinese font
    ;; Use 'unicode charset which will cause english font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        zh-font))))

(provide 'setfont)


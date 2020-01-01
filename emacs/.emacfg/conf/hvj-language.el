;;(set-language-environment 'Chinese-GB)

;;Using the following font list
(require 'setfont)

(if window-system
  (set-font
    '("Bitstream Vera Sans Mono" "Raize" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New")
    ":pixelsize=16"
    '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
  )

;;Zoom font size using Crtl-Mouse Wheel
;;Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
;;Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

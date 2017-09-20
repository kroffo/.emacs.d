;;; Kenny's emacs configuration file
; Kenneth R Roffo Jr
; June 23, 2015

;(add-to-list 'custom-theme-load-path "~/.emacs.d/base16-emacs/")
;(load-theme 'base16 t)
;(load-theme 'base16-solarized-dark t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load-theme 'misterioso t)

;turn tabs into spaces
(setq-default indent-tabs-mode nil)

;turn on line numbering
(global-linum-mode t)

;display column number
(column-number-mode t)

;highlight the current line
(global-hl-line-mode t)

;set the line character limit
(setq-default fill-column 80)

;turn on auto-wrapping at the character limit
(setq auto-fill-mode 1)

(global-unset-key (kbd "M-<down-mouse-1>")) (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

;;; Kenny's emacs configuration file
; Kenneth R Roffo Jr
; June 23, 2015

(setq-default indent-tabs-mode nil)
(add-to-list 'custom-theme-load-path "~/.emacs.d/base16-emacs")
(load-theme 'base16-solarized-dark t)
(global-linum-mode t)

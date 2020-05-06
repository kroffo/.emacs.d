;;; Kenny's emacs configuration file
; Kenneth R Roffo Jr

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

; load my custom python mode
(load "~/.emacs.d/python-mode/python-base-mode.el")
(load "~/.emacs.d/python-mode/python-mode.el")
(add-to-list 'auto-mode-alist (cons (purecopy "\\.py\\'")  'python-mode))
(add-to-list 'interpreter-mode-alist (cons (purecopy "python") 'python-mode))

(add-to-list 'custom-theme-load-path "~/.emacs.d/APGEmacs")
(load-theme 'apgen t)
(load "~/.emacs.d/APGEmacs/apgen-mode.el")
(setq auto-mode-alist (append '(("\\.aaf$" . apgen-mode))
                              auto-mode-alist))
(setq auto-mode-alist (append '(("\\.apf$" . apgen-mode))
                              auto-mode-alist))

; Load a fun little mode a made :)
(load "~/.emacs.d/fun-mode.el")

; Set keybindings for multiple cursors
; For more potential commands visit https://github.com/magnars/multiple-cursors.el
(unless (package-installed-p 'multiple-cursors)
  (package-install 'multiple-cursors))
(require 'multiple-cursors)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(define-key mc/keymap (kbd "<return>") nil) ; make <return> insert a newline multiple-cursors-mode can still be disabled with C-g

(unless (package-installed-p 'yafolding)
  (package-install 'yafolding))
(require 'yafolding)
(global-set-key (kbd "C-c f") 'yafolding-toggle-all)
(global-set-key (kbd "C-c e") 'yafolding-toggle-element)

; Highlight escape sequences using a modified version of highlight-escape-sequences
; acquired from https:ithub.com/dgutov/highlight-escape-sequences
;
; I had to add python and apgen mode to the hes-mode-alist in the .el file
(load "~/.emacs.d/highlight-escape-sequences.el")
(put 'hes-escape-backslash-face 'face-alias 'font-lock-constant-face)
(put 'hes-escape-sequence-face 'face-alias 'font-lock-constant-face)
(hes-mode)

;turn tabs into spaces
(setq-default indent-tabs-mode nil)

;turn on line numbering
(global-linum-mode t)

;display column number
(column-number-mode t)

;highlight the current line
(global-hl-line-mode t)

;disable electric indent mode
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; scroll 3 lines at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1))) ;; three lines at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

; remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-unset-key (kbd "M-<down-mouse-1>")) (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

(set-face-foreground 'font-lock-variable-name-face "white"   )
(set-face-foreground 'font-lock-keyword-face       "#F92672" )
(set-face-foreground 'font-lock-constant-face      "#955dea" )
(set-face-foreground 'font-lock-function-name-face "#A1F12E" )
(set-face-foreground 'font-lock-builtin-face       "orange"  )

; disable background color if in terminal emacs since it has trouble
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rust-mode neotree php+-mode php-mode gs-mode markdown-mode+ markdown-mode yafolding undo-tree)))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Make undo and redo work like most programs, with control-z and control-Z
;; Requires Melpa for installation below
;;turn on everywhere
(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))
(global-undo-tree-mode 1)
;; make ctrl-z undo
(global-set-key (kbd "C-z") 'undo)
;; make ctrl-Z redo
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-S-z") 'redo)

(defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(75 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

; Set transparency of emacs
 (defun set-transparency (value)
   "Sets the transparency of the frame window. 0=transparent/100=opaque"
   (interactive "nTransparency Value 0 - 100 opaque:")
   (set-frame-parameter (selected-frame) 'alpha value))

; Set an easy shortcut for cycling through active windows
(global-set-key (kbd "M-RET") 'other-window)

(global-set-key (kbd "C-x ,") 'previous-buffer)
(global-set-key (kbd "C-x .") 'next-buffer)

; start auto-complete with emacs
(require `auto-complete)
; do default config for auto-complete
(require `auto-complete-config)
(ac-config-default)

; turn on semantic mode
(semantic-mode 1)
; define function to run
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
(add-hook 'c++-mode-common-hook 'my:add-semantic-to-autocomplete)

; turn on ede mode
(global-ede-mode 1)
; create a project for each application you need
; file - specify any file at the root of the your project
; include-path - specify directories to lookup when include <foo.h> is specified

; It would seem there can only be one ede-cpp-root-project, so we comment one for now
;(ede-cpp-root-project "eurcfsw" :file
;"/Users/roffo/Documents/fsw_core/eurcfsw/Readme"
;                      :include-path '("/src"))
(ede-cpp-root-project "mslfsw" :file
"/Users/roffo/Documents/fsw_core/mslseq/Readme"
                      :include-path '("/src"))

; map kbd command to fast jump for definition lookup
(define-key global-map (kbd "C-c j") 'semantic-ia-fast-jump)
(define-key global-map (kbd "C-c g") 'semantic-symref)
(define-key global-map (kbd "C-c s") 'semantic-ia-show-summary)

(global-semantic-idle-summary-mode)
(global-semanticdb-minor-mode)

(setq tramp-copy-size-limit nil)

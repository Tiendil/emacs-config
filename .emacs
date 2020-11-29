
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(let ((default-directory "~/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'package)

(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use-package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-eldoc-mode -1)

(setq inhibit-startup-message t)
(setq visible-bell 1)
(setq indent-tabs-mode nil)
(setq vc-follow-symlinks t)

(load-theme 'deeper-blue t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(column-number-mode 1)
(global-subword-mode 1)
(delete-selection-mode 1)
(global-visual-line-mode 1)

(use-package hl-line
  :ensure nil
  :config
  (global-hl-line-mode)
  (set-face-background hl-line-face "black")
  (setq global-hl-line-sticky-flag t))

(use-package which-key
  :config
  (which-key-mode))

(use-package julia-mode)

(use-package highlight-parentheses
  :config
  (global-highlight-parentheses-mode t))

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward))

(use-package python-mode
  :defines python-shell-interpreter
  :config
  (setq python-shell-interpreter "python3")
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode)))

(use-package flycheck
  :init
  (global-flycheck-mode)
  :config
  (setq flycheck-highlighting-mode 'sexps)
  (setq flycheck-python-pylint-executable python-shell-interpreter))

(use-package smartparens
  :config
  (require 'smartparens-config))

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
        '(("django" . "\\.html\\'")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 1)
  (setq web-mode-script-padding 1)
  (setq web-mode-block-padding 0)

  ;; integration with smartparens-mode
  (setq web-mode-enable-auto-pairing nil)
  (defun sp-web-mode-is-code-context (id action context)
    (and (eq action 'insert)
	 (not (or (get-text-property (point) 'part-side)
		  (get-text-property (point) 'block-side)))))

  (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context)))

(use-package ivy)

(use-package swiper
  :requires ivy
  :bind (("\C-s" . 'swiper)
	 ("C-c C-r" . 'ivy-resume)
	 ("M-x" . 'counsel-M-x)
	 ("C-x C-f" . 'counsel-find-file)
	 ("C-x C-j" . 'counsel-file-jump))
  :config
  (ivy-mode 1)
  (setq ivy-height 30)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")

  (add-to-list 'completion-ignored-extensions "#")
  (setq counsel-find-file-ignore-regexp (regexp-opt completion-ignored-extensions))

  (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
  (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done))

(use-package prescient
  :config
  (setq prescient-history-length 5))

(use-package ivy-prescient)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
  (setq dumb-jump-selector 'ivy))

(use-package workgroups2
  :config
  (workgroups-mode 1))

(use-package avy
  :bind (("C-g" . 'avy-goto-line)
	 ("C-'" . 'avy-goto-char-2)))


(use-package undo-tree
  :config
  (setq undo-tree-visualizer-diff 1)
  (setq undo-tree-visualizer-timestamps 1)
  (global-undo-tree-mode))

(use-package dimmer
  :config
  (setq dimmer-adjustment-mode :foreground)
  (setq dimmer-fraction 0.1)
  (dimmer-configure-which-key)
  (dimmer-mode t))

(use-package color-identifiers-mode
  :defines color-identifiers-coloring-method
  :config
  (global-color-identifiers-mode)
  (setq color-identifiers-coloring-method :hash)
  (setq color-identifiers:min-color-saturation 0.0)
  (setq color-identifiers:max-color-saturation 1.0))

(use-package yascroll
  :config
  (setq yascroll:delay-to-hide nil)
  (global-yascroll-bar-mode))

(use-package highlight-parentheses
  :config
  (highlight-parentheses-mode))

;; (use-package cheatsheet
;;   :config
;;   (cheatsheet-add-group 'Common
;; 			'(:key "C-x C-c" :description "leave Emacs")
;; 			'(:key "C-x C-f" :description "find file")))

;; (use-package minions
;;   :config
;;   (minions-mode 1))

;; (use-package doom-modeline
;;   :config
;;   (setq doom-modeline-buffer-file-name-style 'buffer-name)
;;   (setq doom-modeline-icon nil)
;;   (setq doom-modeline-unicode-fallback nil)
;;   (setq doom-modeline-minor-modes t)
;;   (setq doom-modeline-enable-word-count 1)
;;   (setq doom-modeline-continuous-word-count-modes '(markdown-mode))
;;   (setq doom-modeline-buffer-encoding t)
;;   (setq doom-modeline-checker-simple-format t)
;;   (setq doom-modeline-number-limit 99)
;;   (setq doom-modeline-vcs-max-length 12)

;;   (setq doom-modeline-env-version t)
;;   (setq doom-modeline-env-python-executable python-shell-interpreter)

;;   :init (doom-modeline-mode 1))

(use-package telephone-line
  :config
  (setq telephone-line-lhs
	'((evil   . (telephone-line-buffer-segment))
          (accent . (telephone-line-airline-position-segment
                     telephone-line-erc-modified-channels-segment
                     telephone-line-process-segment))))
  (setq telephone-line-rhs
	'((accent   . (telephone-line-major-mode-segment
		       telephone-line-vc-segment
		       telephone-line-erc-modified-channels-segment
                       telephone-line-process-segment))))
  (telephone-line-mode t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; generated code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))
 '(package-selected-packages
   '(doom-modeline mode-icons minions rich-minority-mode ririch-minority ririch-minority-mode smart-mode-line powerline cheatsheet company yascroll color-identifiers-mode dimmer beacon solaire-mode focus pretty-mode rainbow-mode rainbow-delimiters highlight-symbol undo-tree workgroups2 smex amx avy helm counsel dumb-jump smartparens web-mode use-package which-key flycheck-julia julia-mode lsp-julia vue-mode php-mode bbcode-mode yaml-mode python-mode protobuf-mode markdown-mode jinja2-mode highline highlight-parentheses flycheck-color-mode-line etags-select auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

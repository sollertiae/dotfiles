;; Undo increase
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

;; Scroll
(setq scroll-step 3)

;; Remove backups
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Highlight current line
(global-hl-line-mode 1)

;; Package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Clean UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)

;; Start maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Theme
(use-package catppuccin-theme
  :ensure t
  :config
  (setq catppuccin-flavor 'mocha)
  (load-theme 'catppuccin t))

;; Font
(set-face-attribute 'default nil 
                    :family "Iosevka"
                    :height 160)

;; Sane defaults
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(electric-pair-mode 1)
(show-paren-mode 1)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

;; Company
(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

;; Magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; Eglot
(use-package eglot
  :hook ((c-mode . eglot-ensure)
         (c++-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode) . ("clangd"))))

;; Keybinds
;; Split vertical (side by side)
(global-set-key (kbd "C-x 3") 'split-window-right)
;; Split horizontal (one above other)  
(global-set-key (kbd "C-x 2") 'split-window-below)
;; Move between windows
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
;; Find/switch buffer
(global-set-key (kbd "C-x b") 'switch-to-buffer)
;; Open file
(global-set-key (kbd "C-x C-f") 'find-file)
;; Close window (not kill buffer)
(global-set-key (kbd "C-x 0") 'delete-window)
;; Kill buffer
(global-set-key (kbd "C-x k") 'kill-buffer)
;; Jump to line
(global-set-key (kbd "M-g") 'goto-line)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; TODO/NOTE Highlight
(setq fixme-modes '(c++-mode c-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-note-face)
(mapc (lambda (mode)
        (font-lock-add-keywords
         mode
         '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
           ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
      fixme-modes)
(modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "Dark Green" nil nil t nil t nil nil)

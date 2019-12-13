;; Custom Settings
;; ===============
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-width 4)
 '(fill-column 79)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(display-time-mode t)
 '(global-linum-mode t)
 '(scroll-bar-mode nil)
 '(column-number-mode t)
 '(indent-tabs-mode nil)
 '(cua-mode t nil (cua-base))
 '(delete-selection-mode nil)
 '(show-trailing-whitespace t)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 113 :width normal))))
 '(trailing-whitespace ((t (:background "dark gray")))))


;; LOOK AND FEEL - FURZEN UND SCHEISSEN
;; ====================================
(desktop-save-mode 1)
(setq display-time-24hr-format t)
(setq desktop-restore-in-current-display 1)
;; set transparency
(add-to-list 'default-frame-alist '(alpha 90 90))
(set-frame-parameter (selected-frame) 'alpha '(90 90))


;; PACKAGE
;; =======
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ecb)
(use-package elpy)
(use-package jedi)
(use-package move-line)
(use-package ox-reveal)
(use-package org-bullets)
(use-package company-jedi)
(use-package tabbar-ruler)
(use-package zenburn-theme)
(use-package helm-descbinds)
(use-package material-theme)
(use-package multiple-cursors)
(use-package tangotango-theme)
(use-package zen-and-art-theme)
(use-package color-theme-sanityinc-solarized)
(use-package ace-jump-mode
  :bind ("M-SPC" . ace-jump-mode))
;; tabbar ein

;; COLOR THEMES
;; ============
;; (load-theme 'aurora t)
;; (load-theme 'zenburn t)
(load-theme 'material t)
;; (load-theme 'tangotango t)
;; (load-theme 'idea-darkula t)
;; (load-theme 'solarized-dark t)
(defun switch-theme (theme)
  ;; This interactive call is taken from `load-theme'
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar 'symbol-name
                                     (custom-available-themes))))))
  (mapcar #'disable-theme custom-enabled-themes)
  (load-theme theme t))


;; PERSONALISED GENERAL KEY BINDINGS
;; =================================
(windmove-default-keybindings)
(global-set-key (kbd "C-c C-b") 'ibuffer)
;; (global-set-key (kbd "C-M-<right>") 'next-buffer)
;; (global-set-key (kbd "C-M-<left>") 'previous-buffer)
;; (global-set-key (kbd "C-S-<up>") 'enlarge-window)
;; (global-set-key (kbd "C-S-<down>") 'shrink-window)
;; (global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "C-S-<return>") 'python-shell-send-cell)

(defun toggle-comment-on-line ()
  "Comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)


;; MOVE LINES
;; ==========
(require 'move-line)
(global-set-key (kbd "S-M-<up>") 'move-line-up)
(global-set-key (kbd "S-M-<down>") 'move-line-down)
;; (add-hook 'after-init-hook #'global-flycheck-mode)


;; PYTHON MODE
;; ===========
(elpy-version)
(elpy-enable)
;; (elpy-use-ipython) # Buggy on lxplus - makes tabs in ipython!
(setq elpy-rpc-backend "jedi")
;; (yas-global-mode 1)
;; (setq jedi:setup-keys t)
;; (setq jedi:complete-on-dot t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (add-hook 'python-mode-hook '(lambda ()
;; 			       (message "Found Python mode!")
;; 			       ;; (guess-style-guess-tab-width)
;; 			       (setq-default py-indent-tabs-mode nil)
;; 			       (setq-default python-indent 4)))
;; (global-set-key (kbd "M-<") 'python-indent-shift-left)
;; (global-set-key (kbd "M->") 'python-indent-shift-right)


;; AUCTeX
;; ======
;; Standard emacs/latex config; http://emacswiki.org/emacs/AUCTeX
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq reftex-plug-into-AUCTeX t)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (latex-preview-pane-enable)
;; (setq preview-scale-function 1.2)


;; DOCVIEW
;; =======
(setq doc-view-resolution 150)
(fset 'doc-prev "\C-xo\C-x[\C-xo")
(fset 'doc-next "\C-xo\C-x]\C-xo")
;; (global-set-key (kbd "M-S-<up>") 'doc-prev)
;; (global-set-key (kbd "M-S-<down>") 'doc-next)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)


;; EVIL
;; ====
;; (require 'evil)
;; (evil-mode 1)


;; HELM
;; ====
;; http://tuhdo.github.io/helm-intro.html
(require 'helm)
(require 'helm-config)
(require 'helm-descbinds)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-g") 'helm-google-suggest)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)


;; MULTIPLE CURSORS
;; ================
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)


;; ORG MODE
;; ========
(defun my/org-mode-hook ()
  (set-face-attribute 'org-level-1 nil :height 1.20 :weight 'extra-bold)
  (set-face-attribute 'org-level-2 nil :height 1.15 :weight 'extra-bold)
  (set-face-attribute 'org-level-3 nil :height 1.10 :weight 'extra-bold)
  (set-face-attribute 'org-level-4 nil :height 1.05 :weight 'extra-bold)
  (set-face-attribute 'org-level-5 nil :height 1.00 :weight 'extra-bold))
(add-hook 'org-load-hook #'my/org-mode-hook)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; (require 'ox-reveal)
;; (setq system-time-locale "C")
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((python . t)))
;; ;; (define-key org-mode-map (kbd "<C-S-left>") nil)
;; ;; (define-key org-mode-map (kbd "<C-S-right>") nil)


;; TABBAR
;; ======
(require 'tabbar-ruler)
(setq tabbar-ruler-popup-menu t)       ; get popup menu.
(setq tabbar-ruler-global-tabbar t)    ; get tabbar
;; (setq tabbar-ruler-global-ruler t)     ; get global ruler
(global-set-key (kbd "C-M-<left>") 'tabbar-backward-tab)
(global-set-key (kbd "C-M-<right>") 'tabbar-forward-tab)


;; TEST SHELL MODE
;; ===============
                                        ; interpret and use ansi color codes in shell output windows
(ansi-color-for-comint-mode-on)
                                        ; make completion buffers disappear after 3 seconds.
(add-hook 'completion-setup-hook
          (lambda () (run-at-time 3 nil
                                  (lambda () (delete-windows-on "*Completions*")))))

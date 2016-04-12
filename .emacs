;; Custom Settings
;; ===============
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(delete-selection-mode nil)
 '(display-time-mode t)
 '(fill-column 80)
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier" :foundry "ibm" :slant normal :weight normal :height 113 :width normal))))
 '(trailing-whitespace ((t (:background "dark magenta")))))


;; LOOK AND FEEL - FURZEN UND SCHEISSEN
;; ====================================
(desktop-save-mode 1)
(setq desktop-restore-in-current-display 1)
(setq display-time-24hr-format t)


;; PACKAGE
;; =======
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)


;; COLOR THEMES
;; ============
(load-theme 'zenburn t)
;; (load-theme 'base16-default-dark t)
;; (color-theme-sanityinc-tomorrow-day)
(defun toggle-themes ()
  "Switch from/to night color scheme."
  (interactive)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'light)
      (color-theme-sanityinc-tomorrow-night)
    (color-theme-sanityinc-tomorrow-day)))
(global-set-key (kbd "C-t") 'toggle-themes)


;; PERSONALISED GENERAL KEY BINDINGS
;; =================================
(windmove-default-keybindings)
(global-set-key (kbd "<f11>") 'fullscreen-mode-fullscreen-toggle)
(global-set-key (kbd "C-c C-b") 'ibuffer)
(global-set-key (kbd "C-M-<left>") 'previous-buffer)
(global-set-key (kbd "C-M-<right>") 'next-buffer)
(global-set-key (kbd "C-S-<return>") 'python-shell-send-cell)

(defun toggle-comment-on-line ()
  "Comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)


;; SOME HANDY PACKAGES
;; ===================
;; (add-hook 'after-init-hook #'global-flycheck-mode)


;; PYTHON MODE
;; ===========
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook '(lambda ()
			       (message "Found Python mode!")
			       ;; (guess-style-guess-tab-width)
			       (setq-default py-indent-tabs-mode nil)
			       (setq-default python-indent 4)))
(global-set-key (kbd "M-<") 'python-indent-shift-left)
(global-set-key (kbd "M->") 'python-indent-shift-right)

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))


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
(global-set-key (kbd "M-S-<up>") 'doc-prev)
(global-set-key (kbd "M-S-<down>") 'doc-next)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)


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
;; (require 'ox-reveal)
(setq system-time-locale "C")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

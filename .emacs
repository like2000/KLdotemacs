;; Custom Settings
;; ===============
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes (quote ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(delete-selection-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier" :foundry "ibm" :slant normal :weight normal :height 113 :width normal)))))


;; PACKAGE
;; =======
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)


;; LOOK AND FEEL
;; =============
(scroll-bar-mode -1)
(tool-bar-mode -1)

(column-number-mode 1)
(global-linum-mode 1)
(show-paren-mode 1)

(cua-mode 1)
(desktop-save-mode 1)
(setq desktop-restore-in-current-display 1)

(setq-default indent-tabs-mode -1)
(setq-default show-trailing-whitespace 1)


;; COLOR THEMES
;; ============
;; (load-theme 'base16-default-dark t)
(color-theme-sanityinc-tomorrow-night)
(defun toggle-themes ()
  "Switch from/to night color scheme."
  (interactive)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'light)
      (color-theme-sanityinc-tomorrow-night)
    (color-theme-sanityinc-solarized-light)))
(global-set-key (kbd "C-t") 'toggle-themes)


;; PERSONALISED GENERAL KEY BINDINGS
;; =================================
(windmove-default-keybindings)
(global-set-key (kbd "C-c C-b") 'ibuffer)
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)


;; COMMENT SINGLE LINE
;; ===================
(defun toggle-comment-on-line ()
  "Comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)


;; AUCTeX
;; ======
;; Standard emacs/latex config; http://emacswiki.org/emacs/AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq TeX-PDF-mode t)
(latex-preview-pane-enable)
(setq preview-scale-function 1.2)

;; (setq TeX-view-program-list '("Okular" "okular --unique %o#src:%n%b"))
;; (setq TeX-view-program-selection '((output-pdf "Okular") (output-html "xdg-open")))
;; '(LaTeX-command "latex -synctex=1")


;; DOCVIEW
;; =======
(setq doc-view-resolution 150)
(fset 'doc-prev "\C-xo\C-x[\C-xo")
(fset 'doc-next "\C-xo\C-x]\C-xo")
(global-set-key (kbd "M-S-<up>") 'doc-prev)
(global-set-key (kbd "M-S-<down>") 'doc-next)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)


;; FULLSCREEN
;; ==========
(global-set-key (kbd "<f11>") 'fullscreen-mode-fullscreen-toggle)


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
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "C-c h g") 'helm-google-suggest)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)
(helm-descbinds-mode)


;; IPYTHON MODE
;; ============
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))


;; JEDI AUTO COMPLETE
;; ==================
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)


;; MULTIPLE CURSORS
;; ================
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)


;; ORG MODE
;; ========
(require 'ox-reveal)
(setq system-time-locale "C")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))


;; PYTHON MODE
;; ===========
(add-hook 'python-mode-hook 'guess-style-guess-tabs-mode)
(add-hook 'python-mode-hook (lambda ()
			      (guess-style-guess-tab-width)))
(add-hook 'python-mode-hook '(lambda ()
			       (setq-default py-indent-tabs-mode nil)
			       (setq-default python-indent 4)))
(global-set-key (kbd "M-<") 'python-indent-shift-left)
(global-set-key (kbd "M->") 'python-indent-shift-right)


;; TIME
;; ====
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

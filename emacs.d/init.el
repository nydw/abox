(defconst data-path "~/.data/emacs/" "save all data")
(setq auto-save-list-file-prefix data-path)
(setq backup-directory-alist `((".*" . , data-path)))
(setq auto-save-file-name-transforms `((".*" , data-path t)))

(setq auto-save-list-file-prefix data-path)
(setq backup-directory-alist `((".*" . , data-path)))
(setq auto-save-file-name-transforms `((".*" , data-path t)))

;(setq default-directory "~/" )
;(setq command-line-default-directory "~/")

(menu-bar-mode -1)
(setq default-tab-width 4)
(setq-default c-basic-offset 4)
(setq whitespace-global-mode t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq-default indent-tabs-mode nil)

(setq-default tab-width 4)
(setq tab-width 4)

(setq recentf-save-file (expand-file-name "recentf" data-path)
      recentf-max-saved-items 100
      recentf-max-menu-items  20
      ;recentf-exclude '("/VM/" "/Gnus/" "/bbdb" "\\`/[a-zA-Z0-9@]+:")
      )

(add-to-list 'load-path "~/.emacs.d/impl")
(require 'impl)

(require 'powerline)
(line-number-mode 1)
(column-number-mode 1)
(which-function-mode 1)
(powerline-youth-theme)



(setq make-backup-files nil)

(fset 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode t)

(setq tab-always-indent 'complete)

(blink-cursor-mode 0)
(show-paren-mode +1)

(if (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode)   (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system        'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

(setq-default debug-on-error t)

;; the package manager
(require 'package)
;(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;                         ("melpa" . "http://melpa.org/packages/")))

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")
                         ("org"   . "http://elpa.emacs-china.org/org/")))

(package-initialize)

;; use-package
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(add-to-list 'exec-path "/usr/local/bin")

(use-package auto-compile
  :ensure t
  :defer t
  :config (auto-compile-on-load-mode))

;;use shell env
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))


(defvar mage-init-time 'nil)

(add-hook 'emacs-startup-hook #'mage-display-benchmark)

(use-package avy
 :ensure t)

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package company
  :ensure t
  :bind (("C-c /". company-complete))
  :diminish company-mode
  :commands company-mode
  :init
  (setq
   company-dabbrev-ignore-case nil
   company-dabbrev-code-ignore-case nil
   company-dabbrev-downcase nil
   company-idle-delay 0
   company-show-numbers t
   company-minimum-prefix-length 4)
  :config
  ;; disables TAB in company-mode, freeing it for yasnippet
  (global-company-mode)
  (define-key company-active-map [tab] nil)
  (define-key company-active-map (kbd "TAB") nil))

(use-package evil-leader
  :ensure t
  :config
  (progn
    (global-evil-leader-mode)
    (setq evil-leader/in-all-states t)
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "jc" 'avy-goto-char
      "jw" 'avy-goto-word-1
      "jl" 'avy-goto-line)))

(use-package youdao-dictionary
  :ensure t
  :init
  (setq url-automatic-caching t)
  :config
  (global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+))

;\C-c p ? keybind
(use-package projectile
  :ensure t
  :init
  (setq projectile-known-projects-file (concat data-path "projectile-bookmarks.eld"))
  :bind-keymap ("\C-c p" . projectile-command-map)
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'ivy)
  (use-package counsel-projectile
    :ensure t))

(use-package super-save
  :ensure t
  :config
  ;; (setq super-save-idle-duration 0.3)
  (setq super-save-auto-save-when-idle t)
  (super-save-mode +1))

(use-package markdown-mode
  :ensure t)


(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    (advice-add 'swiper :after #'recenter)))

(use-package iedit
   :ensure t)

(use-package company-dict
   :ensure t
   :init
   (setq company-dict-dir (concat user-emacs-directory "dict/"))
   :config
    (add-to-list 'company-backends 'company-dict))

(use-package which-key
  :defer 1
  :ensure t
  :init (setq which-key-sort-order #'which-key-prefix-then-key-order
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10)
  :config (which-key-mode +1) )


(use-package switch-window
  :ensure t
  :bind (("C-x o" . switch-window)))

(use-package monokai-theme
  :ensure t
  :config (load-theme 'monokai t))
(use-package go-mode
  :ensure t)
(use-package company-go
  :ensure t
  :config
  (add-to-list 'company-backends '(company-go company-dict)))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (which-key youdao-dictionary use-package super-save posframe markdown-mode iedit exec-path-from-shell evil-leader counsel-projectile company-dict avy auto-compile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

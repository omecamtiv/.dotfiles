(setq-default

 ;; Don't use compiled code if it's older package.
 load-prefer-new t

 ;; Don't show startup message.
 inhibit-startup-screen t

 ;; Put 'customize' cofig in separate file.
 custom-file "~/.emacs.d/custom.el"

 ;; Don't create lockfiles.
 create-lockfiles nil

 ;; Don't use hard tabs.
 indent-tabs-mode nil

 ;; Create separate backup folder.
 backup-directory-alist '(("." . "~/.emacs.d/backups"))

 ;; Don't autosave.
 auto-save-default nil

 ;; Allow commands to be run on minibuffers.
 enable-recursive-minibuffers t)

;; Load custom.el file.
(load-file custom-file)

;; Change all yes/no to y/n type.
(fset 'yes-or-no-p 'y-or-n-p)

;; Delete whitespace on saving file.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Display column number in modeline.
(column-number-mode t)

;; Disable Menu Bar.
(menu-bar-mode -1)

;; Auto revert buffer.
(global-auto-revert-mode t)

;; Setting for increasing LSP performance.
(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024))

;; Change default server socket directory.
(require 'server)
(setq server-socket-dir "~/.emacs.d")

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Always use straight.el to install packages
(setq straight-use-package-by-default t)

;; Load helper package for commands like `straight-x-clean-unused-repos'
(require 'straight-x)

;; Use straight.el for use-package expressions
(straight-use-package 'use-package)

;; Define `open-emacs-config'
(defun open-emacs-config ()
  "Open Emacs.org file under ~/.emacs.d folder."
  (interactive)
  (find-file "~/.emacs.d/Emacs.org"))

;; Bind `open-emacs-config' to 'C-c i'
(global-set-key (kbd "C-c i") 'open-emacs-config)

;; Enable `doom-material' from `doom-themes'
(use-package doom-themes
  :config
  (load-theme 'doom-material t))

;; Enable `doom-modeline' and configure it
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  (setq
   doom-modeline-buffer-file-name-style 'buffer-name
   doom-modeline-minor-modes nil))

;; Enable `display-line-numbers-mode' in `prog-mode'
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Enable `global-hl-line-mode' and change the color
(global-hl-line-mode t)
(set-face-background 'hl-line "#37474f")
(set-face-foreground 'highlight nil)
(set-face-attribute 'region nil :background "#1c262b")

;; Disable `hl-line' in `term-mode'
(add-hook 'term-mode-hook
          (lambda () (setq-local global-hl-line-mode nil)))

;; Enable `rainbow-delimiters'
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Enable `page-break-lines'
(use-package page-break-lines
  :config
  (global-page-break-lines-mode))

;; Load and configure `dashboard'
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq
   dashboard-startup-banner 3
   dashboard-show-shortcuts nil
   dashboard-items '((recents . 5)
                     (bookmarks . 5)
                     (projects . 5))
   dashboard-page-separator "\n\f\n"
   dashboard-footer-messages '("Welcome To EMACS!")))

;; Set `initial-buffer-choice' to load dashboard buffer
(setq initial-buffer-choice
      (lambda () (get-buffer "*dashboard*")))

;; Set `evil-set-initial-state' to `emacs' in `dashboard-mode'
(use-package evil
  :requires dashboard
  :config
  (evil-set-initial-state 'dashboard-mode 'emacs))

;; Setup `company' for code-completeion
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq
   company-idle-delay 0.500
   company-minimum-prefix-length 1))

;; Setup `smartparens' for auto pairing braces
(use-package smartparens
  :hook (prog-mode . smartparens-strict-mode))

;; Disable auto-pairing of single and double quotes
(require 'smartparens)
(sp-with-modes 'emacs-lisp-mode
               (sp-local-pair "'" nil :actions nil)
               (sp-local-pair "`" "'" :when '(sp-in-string-p sp-in-comment-p)))

;; Enable curly brace indentation
(defun create-nl-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent."
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(sp-local-pair 'prog-mode "{" nil :post-handlers '((create-nl-enter-sexp "RET")))

;; Setup `evil'
(use-package evil
  :config
  (evil-mode 1))

;; Setup `helm'
(use-package helm
  :bind
  (("M-x" . helm-M-x)
   ("C-x b" . helm-buffers-list)
   ("C-x C-f" . helm-find-files)
   ("C-x r b" . helm-bookmarks)
   ("M-y" . helm-show-kill-ring))
  :config
  (helm-mode 1))

;; Setup `which-key'
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-lighter nil))

;; Setup `projectile'
(use-package projectile
  :init
  (projectile-mode +1)
  :bind
  (:map projectile-mode-map
        ("C-c p" . projectile-command-map)))

;; Enable npm project detection
(use-package projectile
  :config
  (projectile-register-project-type
   'npm '("package.json")
   :project-file "package.json"
   :compile "npm install"
   :run "npm start"
   :test "npm test"
   :test-suffix ".spec"))

;; Enable `helm' with `projectile'
(use-package helm-projectile
  :requires (helm projectile)
  :init
  (helm-projectile-on))

;; Setup `treemacs'
(use-package treemacs
  :bind
  (:map global-map
        ("<f9> . treemacs")
        ("C-c <f9> . treemacs-select-window"))
  :config
  (setq treemacs-is-never-other-window t))

;; Integrate `treemacs' with `evil'
(use-package treemacs-evil
  :requires (treemacs evil))

;; Integrate `treemacs' with `projectile'
(use-package treemacs-projectile
  :requires (treemacs projectile))

;; Customize `org-ellipsis'
(use-package org
  :config
  (setq
   org-ellipsis " "
   org-hide-emphasis-markers t))

;; Setup `org-bullets'
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("")))

;; Add visual padding on both sides
(defun org-mode-visual-fill ()
  "Add padding on bith sides."
  (defvar visual-fill-column-width nil)
  (defvar visual-fill-column-center-text nil)
  (setq
   visual-fill-column-width 145
   visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . org-mode-visual-fill))

;; Indentation fix
(setq org-src-preserve-indentation nil
      org-edit-src-content-indentation 0
      org-adapt-indentation t)

;; Add languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp .t)))

;; Defining the function for auto tangle
(defun sn/org-babel-tangle-config ()
  "Tangle only Emacs.org under ~/.emacs.d folder."
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.emacs.d/.emacs"))
    ;; Dynamic scoping
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

;; Tangle when the file is saved
(add-hook 'org-mode-hook
          (lambda () (add-hook 'after-save-hook
                               #'sn/org-babel-tangle-config)))

;; Add templates for custom babel source block
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

;; Enable TAB in normal state of `evil-mode'
(use-package evil
  :config
  (evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle))

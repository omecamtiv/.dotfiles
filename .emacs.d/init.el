;;; init.el --- Initialization File for Emacs.

;;; Commentary:
;; Emacs init.el

;;; Code:

;; Load load-directory.el
(load "~/.emacs.d/load-directory")

;; Load all '.el' files under '~/.emacs.d/config' directory.
(declare-function load-directory "load-directory")
(load-directory "~/.emacs.d/config")


(provide 'init)

;;; init.el ends here

(tool-bar-mode -1)

(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

;; packages to use

(use-package magit
  :ensure t)

(use-package ivy
  :ensure t)

(use-package expand-region
  :ensure t)

(use-package scala-mode
  :ensure t)

(use-package ensime
  :ensure t
  :pin melpa-stable)

(use-package org
  :ensure t)

(use-package exec-path-from-shell
  :ensure t)

(use-package sql-impala
  :ensure t
  :pin melpa-stable)


(use-package smooth-scroll
  :config
  (smooth-scroll-mode 1)
  (setq smooth-scroll/vscroll-step-size 5)
  )

(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/Users/stig.henriksen/bin")

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(defun my-kill-line (&optional arg)
  "Kill the rest of the current line; if no nonblanks there, kill thru newline.
If starting from beginning of line, kill whole line.
With prefix argument, kill that many lines from point.
Negative arguments kill lines backward.

When calling from a program, nil means \"no arg\",
a number counts as a prefix arg."
  (interactive "*P")
  (kill-region (point)
               (progn
                 (if arg
                     (forward-line (prefix-numeric-value arg))
                   (if (eobp)
                       (signal 'end-of-buffer nil))
                   (if (looking-at "[ \t]*$")
                       (forward-line 1)
                     (if (bolp)
                         (forward-line 1)
                       (end-of-line))))
                 (point))))

(define-key global-map "\C-k" 'my-kill-line)

(global-unset-key (kbd "C-z"))

(load-file "~/.emacs.d/boxquote.el")

(require 'expand-region)
(global-set-key (kbd "M-<up>") 'er/expand-region)
(global-set-key (kbd "M-<down>") 'er/contract-region)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

(global-set-key (kbd "M-s-<left>") #'previous-buffer)
(global-set-key (kbd "M-s-<right>") #'next-buffer)

(setq helm-mini-default-sources 
      '(helm-source-buffers-list 
        helm-source-bookmarks 
        helm-source-recentf 
        helm-source-buffer-not-found)) 

(setq org-todo-keywords
      '(
        (sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")
        (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)")
        ))

(setq org-todo-keyword-faces
      '(("IDEA" . (:foreground "GoldenRod" :weight bold))
        ("NEXT" . (:foreground "IndianRed1" :weight bold))   
        ("STARTED" . (:foreground "OrangeRed" :weight bold))
        ("WAITING" . (:foreground "IndianRed1" :weight bold)) 
        ("CANCELED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
        ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
        ))

(defun move-line-up ()
  "Move up the current line."
  (interactive)
 (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))
(global-set-key [(s shift up)]  'move-line-up)
(global-set-key [(s shift down)]  'move-line-down)

;; Global key-bindings
(global-set-key (kbd "s-<backspace>") '(lambda () (interactive) (kill-line 0)))

(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("s-o" . helm-find-files)
         ([f10] . helm-buffers-list)
         ([S-f10] . helm-recentf)))

(require 'package)


(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed 't)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)
(setq mac-mouse-wheel-mode t)
(setq mac-mouse-wheel-smooth-scroll t)

(setq org-src-fontify-natively t)

(eval-after-load "org"
  '(require 'ox-md nil t))

(setq server-window 'pop-to-buffer)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m org-drill)))
 '(org-support-shift-select t)
 '(package-selected-packages
   (quote
    (sql-impala exec-path-from-shell ensime org org-mode org-contrib org-plus-contrib smooth-scrolling box-quote scala-mode expand-region helm-core helm ivy org-drill use-package magit))))
(custom-set-faces
(scroll-bar-mode -1)
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq mouse-autoselect-window t)

(global-set-key (kbd "s-e") 'helm-mini)

(server-start)

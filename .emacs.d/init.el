;; main entry for emacs configuration

;; enable backtrace on error
;; (setq debug-on-error t)

;; load colorscheme and set colors
(load-theme 'wombat)
(set-cursor-color "orange")

;; shorten yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; prevent startup screen
(setq inhibit-startup-message t)

;; Highlight Line
(global-hl-line-mode 1)
;(set-face-background 'hl-line "black")

;; show line numbers
(global-linum-mode 1)
;; show cursor coords
(setq line-number-mode t)
(setq column-number-mode t)

;; hide tool bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode 0))
(when (fboundp 'toggle-scroll-bar)
  (toggle-scroll-bar -1))

;; show the end of the buffer
(set-default 'indicate-empty-lines t)

;; backup directory
(setq make-backup-files nil)
(setq auto-save-default nil)

;; outsource custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; line wrapping
(set-default 'fill-column 128)

;; TAB behaviour config
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; show parens
(show-paren-mode 1)

;; org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq debug-on-error t)

;; proxy settings
(setq url-proxy-services '(("http" . "localhost:3128" )
			   ))

;; package manager
(add-to-list 'load-path "~/.emacs.d")
(load "packages")

;; powerline
(require 'powerline)
(powerline-default-theme)

;; timestamp 1 week increment
(defun sw-one-week-bump ()
"increase timestamp by one week"
       (interactive) 
       (org-timestamp-up-day 7))

(global-set-key (kbd "<f7>") 'sw-one-week-bump)

;; easy call of org agenda
(global-set-key (kbd "<f9>") 'org-agenda)

;; add org link types
(require 'org)

;; link type mks change package
(org-add-link-type "cp" 'org-view-mks-cp)

(defun org-view-mks-cp (cp-id)
  "Open mks change package in graphical view."
  (shell-command (concat "si viewcp -g " cp-id)))

;; link type mks issue
(org-add-link-type "issue" 'org-view-mks-issue)

(defun org-view-mks-issue (issue-id)
  "Open mks issue in graphical view."
  (shell-command (concat "im viewissue -g " issue-id)))

;; displays mks file history in buffer
(defun mks-file-history (arg)
  (interactive "sEnter Filename: ")
  (setq sicommand "si viewhistory --hostname=ffm-mks1 --port=7001 --project=#p=d:/mks/archives/src/ct_zt8.pj#s=BFU/2013CW35_BFU.pj --fields=revision,description,cpid,author,date ")
  (message (concat sicommand arg))
  (shell-command (concat sicommand arg)))

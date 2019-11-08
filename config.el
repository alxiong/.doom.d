;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq user-full-name "Alex Luoyuan Xiong"
      user-mail-address "alex.xiong.tech@gmail.com")

;;; Fonts
;;; note: do download/install these fonts to the machine first
(setq doom-font (font-spec :family "Fira Code" :size 13)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15))

;; better code completion with tabnine(use-package company-tabnine :ensure t)
(defun add-company-tabnine ()
  (add-to-list (make-local-variable 'company-backends) 'company-tabnine))

(def-package! company-tabnine
  :config
  (setq company-idle-delay 0
        company-show-numbers t)
  (add-hook! (c-mode-local-vars
              c++-mode-local-vars
              emacs-lisp-mode-local-vars
              python-mode-local-vars)
    #'add-company-tabnine))

;; make minial ranger (i.e. deer) the default dir handler
(ranger-override-dired-mode t)

;; Use the tab-and-go frontend.
;; Allows TAB to select and complete at the same time.
(company-tng-configure-default)
(setq company-frontends
      '(company-tng-frontend
        company-pseudo-tooltip-frontend
        company-echo-metadata-frontend))

;; Mac specific setting
(cond ((string-equal system-type "darwin")
       ;; mac keybinding
       ;; note that in System Preference, CapsLock binded to Ctrl
       (setq mac-command-modifier 'meta) ; make cmd key do Meta

       (setq mac-option-modifier 'super) ; make opt key do Super
       (setq mac-control-modifier 'control) ; make Control key do Control
       (setq ns-function-modifier 'hyper) ; make Fn key do Hyper
       ))

;;; CC0 compiler
(setq c0-root "~/dev/cmu15-122/cc0/")
(load (concat c0-root "c0-mode/c0.el"))

;;; Protobuffer
(defconst my-protobuf-style
  '((c-basic-offset . 4)
    (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
  (lambda () (c-add-style "protobuf-style" my-protobuf-style t)))
(add-hook 'protobuf-mode-hook 'display-line-numbers-mode)

;;; Java
;; JAVA_HOME decides the java sdk version
(cond ((string-equal system-type "darwin")
       (setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home")))

;;; Treemacs
(setq doom-themes-treemacs-theme "doom-colors")

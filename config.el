;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq user-full-name "Alex Luoyuan Xiong"
      user-mail-address "alex.xiong.tech@gmail.com")

;;; Fonts
;;; note: do download/install these fonts to the machine first
(setq doom-font (font-spec :family "Fira Code" :size 13)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15))

;; better code completion with tabnine(use-package company-tabnine :ensure t)
(add-to-list 'company-backends #'company-tabnine)
;; Trigger completion immediately.
(setq company-idle-delay 0.1
      company-minimum-prefix-length 2)
;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)

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

;; Set up Emacs's `exec-path` to math PATH of the user's shell
(let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator)))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;;; Golang
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;;; Rust
(setq rustic-format-on-save t)

;;; CC0 compiler
(setq c0-root "/Users/alex/dev/cmu15-122/cc0/")
(load (concat c0-root "c0-mode/c0.el"))

;;; Protobuffer
(defconst my-protobuf-style
  '((c-basic-offset . 4)
    (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
  (lambda () (c-add-style "protobuf-style" my-protobuf-style t)))

;;; Java
;; JAVA_HOME decides the java sdk version
(cond ((string-equal system-type "darwin")
       (setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home")))

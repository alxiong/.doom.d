;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq user-full-name "Alex Luoyuan Xiong"
      user-mail-address "alex.xiong.tech@gmail.com")

;;; Fonts
;;; note: do download/install these fonts to the machine first
(setq doom-font (font-spec :family "Fira Code" :size 13)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15))

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
(add-hook 'before-save-hook #'gofmt-before-save)

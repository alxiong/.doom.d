;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq user-full-name "Alex Luoyuan Xiong"
      user-mail-address "alex.xiong.tech@gmail.com"
      epa-file-encrypt-to user-mail-address
      ;; line number disable by default, otherwise slows down loading
      display-line-numbers-type nil)

;;; Fonts
;;; note: do download/install these fonts to the machine first
(setq doom-font (font-spec :family "Fira Code" :size 13)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15))

;; make minial ranger (i.e. deer) the default dir handler
(ranger-override-dired-mode t)

;; Mac specific setting
(cond ((string-equal system-type "darwin")
       ;; mac keybinding
       ;; note that in System Preference, CapsLock binded to Ctrl
       (setq mac-command-modifier 'meta) ; make cmd key do Meta

       (setq mac-option-modifier 'super) ; make opt key do Super
       (setq mac-control-modifier 'control) ; make Control key do Control
       (setq ns-function-modifier 'hyper) ; make Fn key do Hyper
       ))

;;; Company autocomplete settings
(after! company
  (setq company-minimum-prefix-length 1
        company-idle-delay 0
        company-tooltip-limit 10
        company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        ))

;;; lsp
(after! lsp
  (setq lsp-enable-file-watchers nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil)
  (map!
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file))

;;; C/C++ setting
(after! format
  (set-formatter!
    'clang-format
    '("clang-format"
      ("-assume-filename=%S" (or (buffer-file-name) ""))
      "-style=Google"))
  :modes
  '((c-mode ".c")
    (c++-mode ".cpp")
    (java-mode ".java")
    (objc-mode ".m")
    ))
(after! ccls
  (cond ((string-equal system-type "darwin")
         (setq ccls-initialization-options
               '(:clang (:extraArgs
                         ["-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include"
                          "-isystem/usr/local/include"
                          "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/11.0.0/include"
                          "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include"
                          "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include"
                          "-isystem/Library/Developer/CommandLineTools/usr/include/c++/v1"
                          "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks"]
                         :resourceDir "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/11.0.0")))
         ))
  (cond ((string-equal system-type "gnu/linux")
         (setq ccls-initialization-options
               '(:clang (:extraArgs
                         ["/usr/include/c++/9"
                          "/usr/include/x86_64-linux-gnu/c++/9"
                          "/usr/include/c++/9/backward"
                          "/usr/local/include"
                          "/usr/lib/llvm-9/lib/clang/9.0.0/include"
                          "/usr/include/x86_64-linux-gnu"
                          "/usr/include"]
                         :resourceDir "/usr/lib/llvm-9/lib/clang/9.0.0")))
         )))


;;; CC0 compiler
(setq c0-root "~/dev/cmu15-122/cc0/")
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
       (setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home")))

;;; Treemacs
(setq doom-themes-treemacs-theme "doom-colors")

;;; Rust
(setq rustic-lsp-server 'rust-analyzer)

;;; Sh mode
;; disable company completion as it slows down emacs significantly
(add-hook! 'sh-mode-hook
  (company-mode -1))

;;; Doom breaking changes
(fset 'battery-update #'ignore)

;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! base16-theme)
(package! sml-mode)
;; due to issue: https://github.com/rust-analyzer/rust-analyzer/issues/5647
(package! lsp-mode :pin "bdbd2d0ccfe02f6721ea942e82e5178f4b216228")

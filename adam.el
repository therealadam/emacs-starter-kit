(defun fullscreen (&optional f)
  (interactive)
  (set-frame-parameter f 'fullscreen
                       (if (frame-parameter f 'fullscreen) nil 'fullboth)))

(global-set-key [f5] 'fullscreen)
(add-hook 'after-make-frame-functions 'fullscreen)

(server-start)

(add-to-list 'load-path (concat dotfiles-dir "/vendor"))

(add-to-list 'load-path (concat dotfiles-dir "/vendor/cucumber.el"))
(require 'feature-mode)

(setenv "PATH"
        (concat (getenv "PATH")
                ":/Users/adam/dev/homebrew/bin"
                ":/Users/adam/.gem/ruby/1.8/bin"
                ":/usr/local/mysql/bin"))
(setq exec-path
      (append exec-path '("/Users/adam/dev/homebrew/bin"
                          "/Users/adam/.gem/ruby/1.8/bin"
                          "/usr/local/mysql/bin")))

;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-github)
(color-theme-twilight)
;; (load (concat dotfiles-dir "vendor/topfunky-theme.el"))
;; (color-theme-topfunky)

(add-to-list 'load-path (concat dotfiles-dir "/vendor/textmate.el"))
(require 'textmate)
(textmate-mode)

(setq default-frame-alist
      '((top . 0)
        (height . 61)
        (width . 85)))

;; (add-to-list 'load-path (concat dotfiles-dir "/vendor/jump.el"))
(require 'rinari)

;; Erlang!
(add-to-list 'load-path (concat dotfiles-dir "/vendor/erlware-mode"))
(require 'erlang-start)

;; Open current file in TextMate.
(defun textmate-open-buffer ()
  (interactive)
  (shell-command-to-string (concat "mate " buffer-file-name)))

(add-to-list 'load-path (concat dotfiles-dir "/vendor/ack"))
(require 'ack)
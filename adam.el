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

;; ack!
(add-to-list 'load-path (concat dotfiles-dir "/vendor/ack"))
(require 'ack)

;; mode-compile
(autoload 'mode-compile "mode-compile" "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
      "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

;; dired-sort
(add-to-list 'load-path (concat dotfiles-dir "/vendor/dired-sort-map"))
(require 'dired-sort-map)

;; yasnippet
(setq yas/root-directory (concat dotfiles-dir "snippets"))
(yas/load-directory yas/root-directory)

;; run handy daemons
(defun run-daemon (command name)
  "Run COMMAND asynchronously in a buffer named NAME"
  (interactive)
  (let ((buffer-name (format "*%s*" name))
        (cmd (format "%s &" command)))
    (shell-command cmd buffer-name)))

(defun run-memcached ()
  (interactive)
  (run-daemon "memcached -vv" "memcached"))

(defun run-redis ()
  (interactive)
  (run-daemon "redis-server ~/dev/homebrew/etc/redis.conf" "redis"))


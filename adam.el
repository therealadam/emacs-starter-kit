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

(load (concat dotfiles-dir "vendor/color-theme-github.el"))
(color-theme-github)
;; (color-theme-twilight)
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

;; tiling windows
(require 'emacsd-tile)

;; line numbering
(require 'linum)
(global-linum-mode 1)
(setq linum-format "%3d  ")

;; make ruby-mode better, courtsey of Chad Humphries
(require 'ruby-hacks)
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-hook 'write-file-functions
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max)))))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (define-key ruby-mode-map "\C-m" 'ruby-reindent-then-newline-and-indent)
            (require 'ruby-electric)
            (ruby-electric-mode t)
            (ruby-hs-minor-mode t)))

; where'd this go?
(defun ruby-reindent-then-newline-and-indent ()
  "Reindents the current line then creates an indented newline."
  (interactive "*")
  (newline)
  (save-excursion
    (end-of-line 0)
    (indent-according-to-mode)
    (delete-region (point) (progn (skip-chars-backward " \t") (point))))
  (when (ruby-previous-line-is-comment)
      (insert "# "))
  (indent-according-to-mode))

(defun ruby-previous-line-is-comment ()
  "Returns `t' if the previous line is a Ruby comment."
  (save-excursion
    (forward-line -1)
    (ruby-line-is-comment)))

(defun ruby-line-is-comment ()
  "Returns `t' if the current line is a Ruby comment."
  (save-excursion
    (beginning-of-line)
    (search-forward "#" (point-at-eol) t)))

;; better hide-show
(require 'hideshowvis)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
(add-hook 'text-mode-hook 'hideshowvis-enable)

;; because I have taste
(setq-default tab-width 2)

;; TODO: update ruby-mode and remove this
(defun ruby-insert-end ()
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

;; smex
(setq smex-save-file "~/.emacs.d/smex.save")
(require 'smex)
(add-hook 'after-init-hook 'smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'unit-test)
(require 'autotest)

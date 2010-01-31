;;; starter-kit-registers.el --- Set up registers
;;
;; Part of the Emacs Starter Kit

;; Registers allow you to jump to a file or other location
;; quickly. Use C-x r j followed by the letter of the register (i for
;; init.el, r for this file) to jump to it.

;; You should add registers here for the files you edit most often.

(dolist (r `((?i (file . ,(concat dotfiles-dir "init.el")))
             (?b (file . ,(concat dotfiles-dir "starter-kit-bindings.el")))
             (?r (file . ,(concat dotfiles-dir "starter-kit-registers.el")))
             (?e (file . ,(concat dotfiles-dir "adam.el")))
             (?s (file . ,(concat "~/Desktop/Do/sifter")))
             (?w (file . ,(concat "/Volumes/Work")))
             (?I (file . ,(concat "~/Desktop/In")))
             (?D (file . ,(concat "~/Desktop/Do")))
             (?c (file . ,(concat "~/Create")))
             (?h (file . ,(concat "~/dev/homebrew")))
             (?g (file . ,(concat "~/.gem/ruby/1.8/gems")))
             (?c (file . ,(concat "~/Create/ctdr_dotorg")))
             (?S (file . ,(concat "~/dev/sources")))))
  (set-register (car r) (cadr r)))

(provide 'starter-kit-registers)
;;; starter-kit-registers.el ends here

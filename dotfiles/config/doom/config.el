;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
(setq sp-autoinsert-pair nil)

(after! dirvish
  (setq dirvish-hide-details t)
  (setq dired-hide-details-mode t)

  ;; Reuse one buffer instead of piling up a buffer per directory (Emacs 28+)
  (setq dired-kill-when-opening-new-dired-buffer t)

  ;; Sane listing, directories first
  (setq dirvish-listing-switches "-lahv --group-directories-first"
        dired-free-space nil)          ; Emacs 29+: drops the "free space" line


  ;; Restrict isearch to filenames, ignore the rest of the line
  (setq dirvish-isearch-filenames t)

  ;; netrw muscle memory
  (map! :map dirvish-mode-map
        :n "-" #'dired-up-directory
        :n "h" #'dired-up-directory
        :n "l" #'dired-find-file)

  (map! :map dirvish-mode-map
        :n "%" #'dired-create-empty-file
        :n "d" #'dired-create-directory
        :n "D" #'dired-do-delete
        :n "r" #'dired-rename-file
    )
  (evil-ex-define-cmd "Explore" #'dirvish-jump)
  (evil-ex-define-cmd "Ex" #'dirvish-jump)
)

(map! :nvi :desc "Open file explorer" "C-n" #'dired-jump)

(map! :leader
      :desc "Switch to last buffer"
      "SPC" #'evil-switch-to-windows-last-buffer
)

; Muscle memory.
(map! :leader
      :desc "Save file"
      "ww" #'save-buffer)


; Buffer movement
(map! :leader
      :desc "Switch to last buffer"
      "SPC" #'evil-switch-to-windows-last-buffer)

(defun +my/reload-doom-config-on-save ()
  (when (and buffer-file-name
             (string-prefix-p (file-truename doom-user-dir)
                              (file-truename buffer-file-name))
             (string-suffix-p ".el" buffer-file-name))
    (doom/reload)))

(add-hook 'after-save-hook #'+my/reload-doom-config-on-save)

(map! :leader
      :desc "Full reload"
      "rv" #'+my/reload-doom-config-on-save)

(after! evil
  (evil-define-key '(normal visual) 'global (kbd "C-n") #'dired-jump)
  (evil-define-key '(normal visual) 'global (kbd "\\") #'+default/search-project)
)

(map! :leader :desc "Find file in project" "ff" #'consult-fd)


; Autocompletion
(after! lsp-mode
  (setq lsp-idle-delay 0.05)
)  ; let corfu/cape handle it

(yas-global-mode 1)

(after! yasnippet
  (yas-global-mode 1)
  (map! :map yas-keymap
        "C-e" #'yas-expand-snippet
        "C-j" #'yas-next-field
        "C-k" #'yas-prev-field)
  (setq yas-key-syntaxes '("w_." "w_" "w" yas-try-key-from-whitespace))
)


(after! corfu
  (setq corfu-auto-delay 0.02        ; default 0.2
        corfu-auto-prefix 1)
  (setq corfu-preselect 'prompt      ; noselect — nothing highlighted by default
        corfu-preview-current nil    ; no ghost text
        corfu-cycle t
        corfu-count 8)

  (map! :map corfu-map
        "C-j" #'corfu-next
        "C-k" #'corfu-previous
        "C-SPC" #'completion-at-point
        "C-y" #'corfu-insert
        "C-e" #'corfu-quit
        "C-b" #'corfu-popupinfo-scroll-down
        "C-f" #'corfu-popupinfo-scroll-up)
)       ; default 2 — popup after 1 char

;; (defun +my/add-yasnippet-capf ()
;;   (add-hook 'completion-at-point-functions #'yasnippet-capf 100 t))

;; (add-hook 'eglot-managed-mode-hook #'+my/add-yasnippet-capf)
;; (add-hook 'prog-mode-hook #'+my/add-yasnippet-capf)


(defun +my/undo-fu-session-recover-quietly ()
  (condition-case err
      (undo-fu-session-recover)
    (error (message "undo-fu-session recover failed: %S" err))))

; Some dumb reason, need this 0.1 timeout to recover undos. Some timing issue??
(defun +my/undo-fu-session-recover-deferred ()
  (run-with-idle-timer 0.1 nil #'+my/undo-fu-session-recover-quietly))

(add-hook 'find-file-hook #'+my/undo-fu-session-recover-deferred)

(after! electric-pair
    (electric-pair-mode -1)
)

; dirvish / doom does this really annoying thing where it doesn't include the file name when renaming.
; So this is how we fix that.
(defun +my/rename-this-file ()
  "Rename current file, prefilling the prompt with its name."
  (interactive)
  (let ((old (buffer-file-name)))
    (unless old (user-error "Buffer is not visiting a file"))
    (let* ((name (file-name-nondirectory old))
           (minibuffer-setup-hook
            (cons (lambda () (goto-char (point-max))) minibuffer-setup-hook))
           (new (read-file-name "Rename to: " (file-name-directory old) nil nil name)))
      (rename-file old new 1)
      (set-visited-file-name new t t)
      (message "Renamed to %s" (file-name-nondirectory new)))))

(map! :leader :desc "Rename file" "rf" #'+my/rename-this-file)

(setq +ivy-buffer-preview t)  ; unrelated, ignore

;; pass rg flags — prefix with C-u to get a flag prompt, or set globally:
(after! consult
    (consult-customize consult-fd :preview-key 'any)
  (setq consult-ripgrep-args
        "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number --search-zip --hidden --glob=!.git/")
  (setq consult-preview-key 'any)   ; preview on any key, immediate
  ;; (consult-fd :preview-key 'any)
)

(after! vertico
  (require 'vertico-multiform nil t)
  (vertico-multiform-mode 1)
;;   (add-to-list 'vertico-multiform-commands
;;                '(consult-fd
;;                  buffer
;;                  (vertico-buffer-display-action
;;                   . (display-buffer-in-side-window
;;                      (side . left)
;;                      (window-width . 0.35)))))

;; (add-to-list 'display-buffer-alist
;;                '("\\`\\*consult-preview\\*\\'"
;;                  (display-buffer-in-side-window)
;;                  (side . right)
;;                  (window-width . 0.5)))
)

(map! :leader :desc "Find file in project" "ff" #'consult-fd)


(use-package! docstr
  :hook (prog-mode . docstr-mode))

(setq delete-trailing-lines nil)     ; but don't strip blank lines at EOF
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; (treesit-auto-install-grammar 'always) ; EMACS-31
;; (treesit-enabled-modes t)              ; EMACS-31

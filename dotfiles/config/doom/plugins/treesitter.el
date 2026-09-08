(defun sanityinc/auto-configure-treesitter ()
  "Find and configure installed grammars, remap to matching -ts-modes if present.
Return a list of languages seen along the way."
  (let ((grammar-name-to-emacs-lang '(("c-sharp" . "csharp")
                                      ("cpp" . "c++")
                                      ("gomod" . "go-mod")
                                      ("javascript" . "js")))
        seen-grammars)
    (dolist (dir (cons (expand-file-name "tree-sitter" user-emacs-directory)
                       treesit-extra-load-path))
      (when (file-directory-p dir)
        (dolist (file (directory-files dir))
          (let ((fname (file-name-sans-extension (file-name-nondirectory file))))
            (when (string-match "libtree-sitter-\\(.*\\)" fname)
              (let* ((file-lang (match-string 1 fname))
                     (emacs-lang (or (cdr (assoc-string file-lang grammar-name-to-emacs-lang)) file-lang)))
                ;; Override library if its filename doesn't match the Emacs name
                (unless (or (memq (intern emacs-lang) seen-grammars)
                            (string-equal file-lang emacs-lang))
                  (let ((libname (concat "tree_sitter_" (replace-regexp-in-string "-" "_" file-lang))))
                    (add-to-list 'treesit-load-name-override-list
                                 (list (intern emacs-lang) fname libname))))
                ;; If there's a corresponding -ts mode, remap the standard mode to it
                (let ((ts-mode-name (intern (concat emacs-lang "-ts-mode")))
                      (regular-mode-name (intern (concat emacs-lang "-mode"))))
                  (when (fboundp ts-mode-name)
                    (message "init-treesitter: using %s in place of %s" ts-mode-name regular-mode-name)
                    (add-to-list 'major-mode-remap-alist
                                 (cons regular-mode-name ts-mode-name))))
                ;; Remember we saw this language so we don't squash its config when we
                ;; find another lib later in the treesit load path
                (push (intern emacs-lang) seen-grammars)))))))
    seen-grammars))

;;; Support remapping of additional libraries

(defun sanityinc/remap-ts-mode (non-ts-mode ts-mode grammar)
  "Explicitly remap NON-TS-MODE to TS-MODE if GRAMMAR is available."
  (when (and (fboundp 'treesit-ready-p)
             (treesit-ready-p grammar t)
             (fboundp ts-mode))
    (add-to-list 'major-mode-remap-alist (cons non-ts-mode ts-mode))))

;; When there's js-ts-mode, we also prefer it to js2-mode
(sanityinc/remap-ts-mode 'js2-mode 'js-ts-mode 'javascript)


;; Default
(setq treesit-font-lock-level 4)

(provide 'init-treesitter)

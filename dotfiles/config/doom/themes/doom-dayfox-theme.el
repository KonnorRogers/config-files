;;; doom-dayfox-theme.el --- dayfox from nightfox.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Port of EdenEast/nightfox.nvim (dayfox) to doom-themes. Palette values were
;; resolved from lua/nightfox/palette/dayfox.lua and its generate_spec().
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-dayfox-theme nil
  "Options for the `doom-dayfox' theme."
  :group 'doom-themes)

(defcustom doom-dayfox-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-dayfox-theme
  :type 'boolean)

(defcustom doom-dayfox-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-dayfox-theme
  :type 'boolean)

(defcustom doom-dayfox-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-dayfox-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-dayfox
  "A light theme ported from nightfox.nvim's dayfox variant."
  :family 'doom-nightfox
  :background-mode 'light

  ;; name        gui / 256 / 16
  ((bg         '("#f6f2ee" "#f6f2ee" "white"))
   (fg         '("#3d2b5a" "#3d2b5a" "black"))
   (bg-alt     '("#e4dcd4" "#e4dcd4" "white"))
   (fg-alt     '("#643f61" "#643f61" "brightblack"))

   ;; nightfox bg0..bg4 / fg3 / comment / fg2 / fg0, in doom's base0..base8 order
   (base0      '("#e4dcd4" "#e4dcd4" "black"))
   (base1      '("#f6f2ee" "#f6f2ee" "brightblack"))
   (base2      '("#dbd1dd" "#dbd1dd" "brightblack"))
   (base3      '("#d3c7bb" "#d3c7bb" "brightblack"))
   (base4      '("#aab0ad" "#aab0ad" "brightblack"))
   (base5      '("#824d5b" "#824d5b" "brightblack"))
   (base6      '("#837a72" "#837a72" "brightblack"))
   (base7      '("#643f61" "#643f61" "brightblack"))
   (base8      '("#302b5d" "#302b5d" "white"))

   (grey       base4)
   (red        '("#a5222f" "#a5222f" "red"))
   (orange     '("#955f61" "#955f61" "brightred"))
   (green      '("#396847" "#396847" "green"))
   (teal       '("#577f63" "#577f63" "brightgreen"))
   (yellow     '("#ac5402" "#ac5402" "yellow"))
   (blue       '("#2848a9" "#2848a9" "brightblue"))
   (dark-blue  '("#223d90" "#223d90" "blue"))
   (magenta    '("#6e33ce" "#6e33ce" "brightmagenta"))
   (violet     '("#5e2baf" "#5e2baf" "magenta"))
   (cyan       '("#287980" "#287980" "brightcyan"))
   (dark-cyan  '("#22676d" "#22676d" "cyan"))

   ;; extra nightfox colors, exposed for user overrides
   (pink       '("#a440b5" "#a440b5" "magenta"))
   (black      '("#352c24" "#352c24" "black"))
   (white      '("#f2e9e1" "#f2e9e1" "white"))
   (sel0       '("#e7d2be" "#e7d2be" "brightblack"))
   (preproc    '("#8b369a" "#8b369a" "magenta"))
   (regex      '("#924702" "#924702" "yellow"))
   (sel1       '("#a4c1c2" "#a4c1c2" "brightblack"))

   ;; face categories -- mapped from nightfox's generate_spec()
   (highlight      blue)
   (vertical-bar   base0)
   (selection      sel1)
   (builtin        '("#a5222f" "#a5222f" "red"))
   (comments       (if doom-dayfox-brighter-comments dark-cyan base6))
   (doc-comments   (doom-darken (if doom-dayfox-brighter-comments dark-cyan base6) 0.2))
   (constants      '("#7f5152" "#7f5152" "brightred"))
   (functions      '("#223d90" "#223d90" "blue"))
   (keywords       '("#6e33ce" "#6e33ce" "magenta"))
   (methods        '("#223d90" "#223d90" "blue"))
   (operators      '("#643f61" "#643f61" "white"))
   (type           '("#ac5402" "#ac5402" "yellow"))
   (strings        '("#396847" "#396847" "green"))
   (variables      '("#352c24" "#352c24" "white"))
   (numbers        '("#955f61" "#955f61" "brightred"))
   (region         sel0)
   (error          '("#a5222f" "#a5222f" "red"))
   (warning        '("#ac5402" "#ac5402" "yellow"))
   (success        '("#396847" "#396847" "green"))
   (vc-modified    '("#ac5402" "#ac5402" "yellow"))
   (vc-added       '("#396847" "#396847" "green"))
   (vc-deleted     '("#a5222f" "#a5222f" "red"))

   ;; custom categories
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-dayfox-brighter-modeline base3 base0))
   (modeline-bg-alt          (if doom-dayfox-brighter-modeline base3 base0))
   (modeline-bg-inactive     base0)
   (modeline-bg-inactive-alt base0)
   (-modeline-pad
    (when doom-dayfox-padded-modeline
      (if (integerp doom-dayfox-padded-modeline) doom-dayfox-padded-modeline 4))))

  ;;;; Base theme face overrides
  (((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground fg :background base3)
   (hl-line :background base3)
   (cursor :background fg)
   (fringe :background bg)
   (vertical-border :foreground base0 :background base0)
   (window-divider :foreground base0)
   (isearch :foreground bg :background yellow :weight 'bold)
   (lazy-highlight :background sel1)
   (match :background sel1)
   (show-paren-match :background base4 :foreground fg :weight 'bold)
   (font-lock-preprocessor-face :foreground preproc)
   (font-lock-regexp-grouping-backslash :foreground regex)
   (font-lock-regexp-grouping-construct :foreground regex)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-dayfox-brighter-modeline base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-dayfox-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt)))
   ;;;; ivy / vertico / selection lists
   (ivy-current-match :background sel0 :distant-foreground nil)
   (vertico-current :background sel0)
   ;;;; magit
   (magit-diff-hunk-heading-highlight :foreground bg :background blue :weight 'bold)
   (magit-diff-hunk-heading :foreground bg :background dark-blue)
   ;;;; org
   (org-block :background base0)
   (org-block-begin-line :background base0 :foreground comments)
   (org-block-end-line :background base0 :foreground comments)
   (org-level-1 :foreground blue :weight 'bold :height 1.2)
   (org-level-2 :foreground magenta :weight 'bold)
   (org-level-3 :foreground green :weight 'bold)
   (org-level-4 :foreground yellow)
   (org-level-5 :foreground cyan)
   (org-level-6 :foreground orange)
   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground red)
   (rainbow-delimiters-depth-2-face :foreground yellow)
   (rainbow-delimiters-depth-3-face :foreground blue)
   (rainbow-delimiters-depth-4-face :foreground orange)
   (rainbow-delimiters-depth-5-face :foreground green)
   (rainbow-delimiters-depth-6-face :foreground magenta)
   (rainbow-delimiters-depth-7-face :foreground cyan))

  ;;;; Base theme variable overrides
  ())

;;; doom-dayfox-theme.el ends here

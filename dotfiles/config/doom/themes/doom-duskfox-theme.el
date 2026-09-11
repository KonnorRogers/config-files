;;; doom-duskfox-theme.el --- duskfox from nightfox.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Port of EdenEast/nightfox.nvim (duskfox) to doom-themes. Palette values were
;; resolved from lua/nightfox/palette/duskfox.lua and its generate_spec().
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-duskfox-theme nil
  "Options for the `doom-duskfox' theme."
  :group 'doom-themes)

(defcustom doom-duskfox-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-duskfox-theme
  :type 'boolean)

(defcustom doom-duskfox-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-duskfox-theme
  :type 'boolean)

(defcustom doom-duskfox-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-duskfox-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-duskfox
  "A dark theme ported from nightfox.nvim's duskfox variant."
  :family 'doom-nightfox
  :background-mode 'dark

  ;; name        gui / 256 / 16
  ((bg         '("#232136" "#232136" "black"))
   (fg         '("#e0def4" "#e0def4" "brightwhite"))
   (bg-alt     '("#191726" "#191726" "black"))
   (fg-alt     '("#cdcbe0" "#cdcbe0" "white"))

   ;; nightfox bg0..bg4 / fg3 / comment / fg2 / fg0, in doom's base0..base8 order
   (base0      '("#191726" "#191726" "black"))
   (base1      '("#232136" "#232136" "brightblack"))
   (base2      '("#2d2a45" "#2d2a45" "brightblack"))
   (base3      '("#373354" "#373354" "brightblack"))
   (base4      '("#4b4673" "#4b4673" "brightblack"))
   (base5      '("#6e6a86" "#6e6a86" "brightblack"))
   (base6      '("#817c9c" "#817c9c" "brightblack"))
   (base7      '("#cdcbe0" "#cdcbe0" "brightblack"))
   (base8      '("#eae8ff" "#eae8ff" "white"))

   (grey       base4)
   (red        '("#eb6f92" "#eb6f92" "red"))
   (orange     '("#ea9a97" "#ea9a97" "brightred"))
   (green      '("#a3be8c" "#a3be8c" "green"))
   (teal       '("#b1d196" "#b1d196" "brightgreen"))
   (yellow     '("#f6c177" "#f6c177" "yellow"))
   (blue       '("#569fba" "#569fba" "brightblue"))
   (dark-blue  '("#4a869c" "#4a869c" "blue"))
   (magenta    '("#c4a7e7" "#c4a7e7" "brightmagenta"))
   (violet     '("#a580d2" "#a580d2" "magenta"))
   (cyan       '("#9ccfd8" "#9ccfd8" "brightcyan"))
   (dark-cyan  '("#7bb8c1" "#7bb8c1" "cyan"))

   ;; extra nightfox colors, exposed for user overrides
   (pink       '("#eb98c3" "#eb98c3" "magenta"))
   (black      '("#393552" "#393552" "black"))
   (white      '("#e0def4" "#e0def4" "white"))
   (sel0       '("#433c59" "#433c59" "brightblack"))
   (preproc    '("#f0a6cc" "#f0a6cc" "magenta"))
   (regex      '("#f9cb8c" "#f9cb8c" "yellow"))
   (sel1       '("#63577d" "#63577d" "brightblack"))

   ;; face categories -- mapped from nightfox's generate_spec()
   (highlight      blue)
   (vertical-bar   base0)
   (selection      sel1)
   (builtin        '("#eb6f92" "#eb6f92" "red"))
   (comments       (if doom-duskfox-brighter-comments dark-cyan base6))
   (doc-comments   (doom-lighten (if doom-duskfox-brighter-comments dark-cyan base6) 0.2))
   (constants      '("#f0a4a2" "#f0a4a2" "brightred"))
   (functions      '("#65b1cd" "#65b1cd" "blue"))
   (keywords       '("#c4a7e7" "#c4a7e7" "magenta"))
   (methods        '("#65b1cd" "#65b1cd" "blue"))
   (operators      '("#cdcbe0" "#cdcbe0" "white"))
   (type           '("#f6c177" "#f6c177" "yellow"))
   (strings        '("#a3be8c" "#a3be8c" "green"))
   (variables      '("#e0def4" "#e0def4" "white"))
   (numbers        '("#ea9a97" "#ea9a97" "brightred"))
   (region         sel0)
   (error          '("#eb6f92" "#eb6f92" "red"))
   (warning        '("#f6c177" "#f6c177" "yellow"))
   (success        '("#a3be8c" "#a3be8c" "green"))
   (vc-modified    '("#f6c177" "#f6c177" "yellow"))
   (vc-added       '("#a3be8c" "#a3be8c" "green"))
   (vc-deleted     '("#eb6f92" "#eb6f92" "red"))

   ;; custom categories
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-duskfox-brighter-modeline base3 base0))
   (modeline-bg-alt          (if doom-duskfox-brighter-modeline base3 base0))
   (modeline-bg-inactive     base0)
   (modeline-bg-inactive-alt base0)
   (-modeline-pad
    (when doom-duskfox-padded-modeline
      (if (integerp doom-duskfox-padded-modeline) doom-duskfox-padded-modeline 4))))

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
   (mode-line-emphasis :foreground (if doom-duskfox-brighter-modeline base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-duskfox-brighter-modeline modeline-bg highlight))
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

;;; doom-duskfox-theme.el ends here

;;; doom-nordfox-theme.el --- nordfox from nightfox.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Port of EdenEast/nightfox.nvim (nordfox) to doom-themes. Palette values were
;; resolved from lua/nightfox/palette/nordfox.lua and its generate_spec().
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-nordfox-theme nil
  "Options for the `doom-nordfox' theme."
  :group 'doom-themes)

(defcustom doom-nordfox-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-nordfox-theme
  :type 'boolean)

(defcustom doom-nordfox-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-nordfox-theme
  :type 'boolean)

(defcustom doom-nordfox-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-nordfox-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-nordfox
  "A dark theme ported from nightfox.nvim's nordfox variant."
  :family 'doom-nightfox
  :background-mode 'dark

  ;; name        gui / 256 / 16
  ((bg         '("#2e3440" "#2e3440" "black"))
   (fg         '("#cdcecf" "#cdcecf" "brightwhite"))
   (bg-alt     '("#232831" "#232831" "black"))
   (fg-alt     '("#abb1bb" "#abb1bb" "white"))

   ;; nightfox bg0..bg4 / fg3 / comment / fg2 / fg0, in doom's base0..base8 order
   (base0      '("#232831" "#232831" "black"))
   (base1      '("#2e3440" "#2e3440" "brightblack"))
   (base2      '("#39404f" "#39404f" "brightblack"))
   (base3      '("#444c5e" "#444c5e" "brightblack"))
   (base4      '("#5a657d" "#5a657d" "brightblack"))
   (base5      '("#7e8188" "#7e8188" "brightblack"))
   (base6      '("#60728a" "#60728a" "brightblack"))
   (base7      '("#abb1bb" "#abb1bb" "brightblack"))
   (base8      '("#c7cdd9" "#c7cdd9" "white"))

   (grey       base4)
   (red        '("#bf616a" "#bf616a" "red"))
   (orange     '("#c9826b" "#c9826b" "brightred"))
   (green      '("#a3be8c" "#a3be8c" "green"))
   (teal       '("#b1d196" "#b1d196" "brightgreen"))
   (yellow     '("#ebcb8b" "#ebcb8b" "yellow"))
   (blue       '("#81a1c1" "#81a1c1" "brightblue"))
   (dark-blue  '("#668aab" "#668aab" "blue"))
   (magenta    '("#b48ead" "#b48ead" "brightmagenta"))
   (violet     '("#9d7495" "#9d7495" "magenta"))
   (cyan       '("#88c0d0" "#88c0d0" "brightcyan"))
   (dark-cyan  '("#69a7ba" "#69a7ba" "cyan"))

   ;; extra nightfox colors, exposed for user overrides
   (pink       '("#bf88bc" "#bf88bc" "magenta"))
   (black      '("#3b4252" "#3b4252" "black"))
   (white      '("#e5e9f0" "#e5e9f0" "white"))
   (sel0       '("#3e4a5b" "#3e4a5b" "brightblack"))
   (preproc    '("#d092ce" "#d092ce" "magenta"))
   (regex      '("#f0d399" "#f0d399" "yellow"))
   (sel1       '("#4f6074" "#4f6074" "brightblack"))

   ;; face categories -- mapped from nightfox's generate_spec()
   (highlight      blue)
   (vertical-bar   base0)
   (selection      sel1)
   (builtin        '("#bf616a" "#bf616a" "red"))
   (comments       (if doom-nordfox-brighter-comments dark-cyan base6))
   (doc-comments   (doom-lighten (if doom-nordfox-brighter-comments dark-cyan base6) 0.2))
   (constants      '("#d89079" "#d89079" "brightred"))
   (functions      '("#8cafd2" "#8cafd2" "blue"))
   (keywords       '("#b48ead" "#b48ead" "magenta"))
   (methods        '("#8cafd2" "#8cafd2" "blue"))
   (operators      '("#abb1bb" "#abb1bb" "white"))
   (type           '("#ebcb8b" "#ebcb8b" "yellow"))
   (strings        '("#a3be8c" "#a3be8c" "green"))
   (variables      '("#e5e9f0" "#e5e9f0" "white"))
   (numbers        '("#c9826b" "#c9826b" "brightred"))
   (region         sel0)
   (error          '("#bf616a" "#bf616a" "red"))
   (warning        '("#ebcb8b" "#ebcb8b" "yellow"))
   (success        '("#a3be8c" "#a3be8c" "green"))
   (vc-modified    '("#ebcb8b" "#ebcb8b" "yellow"))
   (vc-added       '("#a3be8c" "#a3be8c" "green"))
   (vc-deleted     '("#bf616a" "#bf616a" "red"))

   ;; custom categories
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-nordfox-brighter-modeline base3 base0))
   (modeline-bg-alt          (if doom-nordfox-brighter-modeline base3 base0))
   (modeline-bg-inactive     base0)
   (modeline-bg-inactive-alt base0)
   (-modeline-pad
    (when doom-nordfox-padded-modeline
      (if (integerp doom-nordfox-padded-modeline) doom-nordfox-padded-modeline 4))))

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
   (mode-line-emphasis :foreground (if doom-nordfox-brighter-modeline base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-nordfox-brighter-modeline modeline-bg highlight))
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

;;; doom-nordfox-theme.el ends here

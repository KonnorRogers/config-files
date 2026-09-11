;;; doom-terafox-theme.el --- terafox from nightfox.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Port of EdenEast/nightfox.nvim (terafox) to doom-themes. Palette values were
;; resolved from lua/nightfox/palette/terafox.lua and its generate_spec().
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-terafox-theme nil
  "Options for the `doom-terafox' theme."
  :group 'doom-themes)

(defcustom doom-terafox-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-terafox-theme
  :type 'boolean)

(defcustom doom-terafox-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-terafox-theme
  :type 'boolean)

(defcustom doom-terafox-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-terafox-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-terafox
  "A dark theme ported from nightfox.nvim's terafox variant."
  :family 'doom-nightfox
  :background-mode 'dark

  ;; name        gui / 256 / 16
  ((bg         '("#152528" "#152528" "black"))
   (fg         '("#e6eaea" "#e6eaea" "brightwhite"))
   (bg-alt     '("#0f1c1e" "#0f1c1e" "black"))
   (fg-alt     '("#cbd9d8" "#cbd9d8" "white"))

   ;; nightfox bg0..bg4 / fg3 / comment / fg2 / fg0, in doom's base0..base8 order
   (base0      '("#0f1c1e" "#0f1c1e" "black"))
   (base1      '("#152528" "#152528" "brightblack"))
   (base2      '("#1d3337" "#1d3337" "brightblack"))
   (base3      '("#254147" "#254147" "brightblack"))
   (base4      '("#2d4f56" "#2d4f56" "brightblack"))
   (base5      '("#587b7b" "#587b7b" "brightblack"))
   (base6      '("#6d7f8b" "#6d7f8b" "brightblack"))
   (base7      '("#cbd9d8" "#cbd9d8" "brightblack"))
   (base8      '("#eaeeee" "#eaeeee" "white"))

   (grey       base4)
   (red        '("#e85c51" "#e85c51" "red"))
   (orange     '("#ff8349" "#ff8349" "brightred"))
   (green      '("#7aa4a1" "#7aa4a1" "green"))
   (teal       '("#8eb2af" "#8eb2af" "brightgreen"))
   (yellow     '("#fda47f" "#fda47f" "yellow"))
   (blue       '("#5a93aa" "#5a93aa" "brightblue"))
   (dark-blue  '("#4d7d90" "#4d7d90" "blue"))
   (magenta    '("#ad5c7c" "#ad5c7c" "brightmagenta"))
   (violet     '("#934e69" "#934e69" "magenta"))
   (cyan       '("#a1cdd8" "#a1cdd8" "brightcyan"))
   (dark-cyan  '("#89aeb8" "#89aeb8" "cyan"))

   ;; extra nightfox colors, exposed for user overrides
   (pink       '("#cb7985" "#cb7985" "magenta"))
   (black      '("#2f3239" "#2f3239" "black"))
   (white      '("#ebebeb" "#ebebeb" "white"))
   (sel0       '("#293e40" "#293e40" "brightblack"))
   (preproc    '("#d38d97" "#d38d97" "magenta"))
   (regex      '("#fdb292" "#fdb292" "yellow"))
   (sel1       '("#425e5e" "#425e5e" "brightblack"))

   ;; face categories -- mapped from nightfox's generate_spec()
   (highlight      blue)
   (vertical-bar   base0)
   (selection      sel1)
   (builtin        '("#e85c51" "#e85c51" "red"))
   (comments       (if doom-terafox-brighter-comments dark-cyan base6))
   (doc-comments   (doom-lighten (if doom-terafox-brighter-comments dark-cyan base6) 0.2))
   (constants      '("#ff9664" "#ff9664" "brightred"))
   (functions      '("#73a3b7" "#73a3b7" "blue"))
   (keywords       '("#ad5c7c" "#ad5c7c" "magenta"))
   (methods        '("#73a3b7" "#73a3b7" "blue"))
   (operators      '("#cbd9d8" "#cbd9d8" "white"))
   (type           '("#fda47f" "#fda47f" "yellow"))
   (strings        '("#7aa4a1" "#7aa4a1" "green"))
   (variables      '("#ebebeb" "#ebebeb" "white"))
   (numbers        '("#ff8349" "#ff8349" "brightred"))
   (region         sel0)
   (error          '("#e85c51" "#e85c51" "red"))
   (warning        '("#fda47f" "#fda47f" "yellow"))
   (success        '("#7aa4a1" "#7aa4a1" "green"))
   (vc-modified    '("#fda47f" "#fda47f" "yellow"))
   (vc-added       '("#7aa4a1" "#7aa4a1" "green"))
   (vc-deleted     '("#e85c51" "#e85c51" "red"))

   ;; custom categories
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-terafox-brighter-modeline base3 base0))
   (modeline-bg-alt          (if doom-terafox-brighter-modeline base3 base0))
   (modeline-bg-inactive     base0)
   (modeline-bg-inactive-alt base0)
   (-modeline-pad
    (when doom-terafox-padded-modeline
      (if (integerp doom-terafox-padded-modeline) doom-terafox-padded-modeline 4))))

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
   (mode-line-emphasis :foreground (if doom-terafox-brighter-modeline base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-terafox-brighter-modeline modeline-bg highlight))
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

;;; doom-terafox-theme.el ends here

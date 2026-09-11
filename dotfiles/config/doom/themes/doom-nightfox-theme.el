;;; doom-nightfox-theme.el --- nightfox from nightfox.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Port of EdenEast/nightfox.nvim (nightfox) to doom-themes. Palette values were
;; resolved from lua/nightfox/palette/nightfox.lua and its generate_spec().
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-nightfox-theme nil
  "Options for the `doom-nightfox' theme."
  :group 'doom-themes)

(defcustom doom-nightfox-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-nightfox-theme
  :type 'boolean)

(defcustom doom-nightfox-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-nightfox-theme
  :type 'boolean)

(defcustom doom-nightfox-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-nightfox-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-nightfox
  "A dark theme ported from nightfox.nvim's nightfox variant."
  :family 'doom-nightfox
  :background-mode 'dark

  ;; name        gui / 256 / 16
  ((bg         '("#192330" "#192330" "black"))
   (fg         '("#cdcecf" "#cdcecf" "brightwhite"))
   (bg-alt     '("#131a24" "#131a24" "black"))
   (fg-alt     '("#aeafb0" "#aeafb0" "white"))

   ;; nightfox bg0..bg4 / fg3 / comment / fg2 / fg0, in doom's base0..base8 order
   (base0      '("#131a24" "#131a24" "black"))
   (base1      '("#192330" "#192330" "brightblack"))
   (base2      '("#212e3f" "#212e3f" "brightblack"))
   (base3      '("#29394f" "#29394f" "brightblack"))
   (base4      '("#39506d" "#39506d" "brightblack"))
   (base5      '("#71839b" "#71839b" "brightblack"))
   (base6      '("#738091" "#738091" "brightblack"))
   (base7      '("#aeafb0" "#aeafb0" "brightblack"))
   (base8      '("#d6d6d7" "#d6d6d7" "white"))

   (grey       base4)
   (red        '("#c94f6d" "#c94f6d" "red"))
   (orange     '("#f4a261" "#f4a261" "brightred"))
   (green      '("#81b29a" "#81b29a" "green"))
   (teal       '("#8ebaa4" "#8ebaa4" "brightgreen"))
   (yellow     '("#dbc074" "#dbc074" "yellow"))
   (blue       '("#719cd6" "#719cd6" "brightblue"))
   (dark-blue  '("#6085b6" "#6085b6" "blue"))
   (magenta    '("#9d79d6" "#9d79d6" "brightmagenta"))
   (violet     '("#8567b6" "#8567b6" "magenta"))
   (cyan       '("#63cdcf" "#63cdcf" "brightcyan"))
   (dark-cyan  '("#54aeb0" "#54aeb0" "cyan"))

   ;; extra nightfox colors, exposed for user overrides
   (pink       '("#d67ad2" "#d67ad2" "magenta"))
   (black      '("#393b44" "#393b44" "black"))
   (white      '("#dfdfe0" "#dfdfe0" "white"))
   (sel0       '("#2b3b51" "#2b3b51" "brightblack"))
   (preproc    '("#dc8ed9" "#dc8ed9" "magenta"))
   (regex      '("#e0c989" "#e0c989" "yellow"))
   (sel1       '("#3c5372" "#3c5372" "brightblack"))

   ;; face categories -- mapped from nightfox's generate_spec()
   (highlight      blue)
   (vertical-bar   base0)
   (selection      sel1)
   (builtin        '("#c94f6d" "#c94f6d" "red"))
   (comments       (if doom-nightfox-brighter-comments dark-cyan base6))
   (doc-comments   (doom-lighten (if doom-nightfox-brighter-comments dark-cyan base6) 0.2))
   (constants      '("#f6b079" "#f6b079" "brightred"))
   (functions      '("#86abdc" "#86abdc" "blue"))
   (keywords       '("#9d79d6" "#9d79d6" "magenta"))
   (methods        '("#86abdc" "#86abdc" "blue"))
   (operators      '("#aeafb0" "#aeafb0" "white"))
   (type           '("#dbc074" "#dbc074" "yellow"))
   (strings        '("#81b29a" "#81b29a" "green"))
   (variables      '("#dfdfe0" "#dfdfe0" "white"))
   (numbers        '("#f4a261" "#f4a261" "brightred"))
   (region         sel0)
   (error          '("#c94f6d" "#c94f6d" "red"))
   (warning        '("#dbc074" "#dbc074" "yellow"))
   (success        '("#81b29a" "#81b29a" "green"))
   (vc-modified    '("#dbc074" "#dbc074" "yellow"))
   (vc-added       '("#81b29a" "#81b29a" "green"))
   (vc-deleted     '("#c94f6d" "#c94f6d" "red"))

   ;; custom categories
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-nightfox-brighter-modeline base3 base0))
   (modeline-bg-alt          (if doom-nightfox-brighter-modeline base3 base0))
   (modeline-bg-inactive     base0)
   (modeline-bg-inactive-alt base0)
   (-modeline-pad
    (when doom-nightfox-padded-modeline
      (if (integerp doom-nightfox-padded-modeline) doom-nightfox-padded-modeline 4))))

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
   (mode-line-emphasis :foreground (if doom-nightfox-brighter-modeline base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-nightfox-brighter-modeline modeline-bg highlight))
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

;;; doom-nightfox-theme.el ends here

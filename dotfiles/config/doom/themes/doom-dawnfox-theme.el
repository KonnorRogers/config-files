;;; doom-dawnfox-theme.el --- dawnfox from nightfox.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Port of EdenEast/nightfox.nvim (dawnfox) to doom-themes. Palette values were
;; resolved from lua/nightfox/palette/dawnfox.lua and its generate_spec().
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-dawnfox-theme nil
  "Options for the `doom-dawnfox' theme."
  :group 'doom-themes)

(defcustom doom-dawnfox-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-dawnfox-theme
  :type 'boolean)

(defcustom doom-dawnfox-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-dawnfox-theme
  :type 'boolean)

(defcustom doom-dawnfox-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-dawnfox-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-dawnfox
  "A light theme ported from nightfox.nvim's dawnfox variant."
  :family 'doom-nightfox
  :background-mode 'light

  ;; name        gui / 256 / 16
  ((bg         '("#faf4ed" "#faf4ed" "white"))
   (fg         '("#575279" "#575279" "black"))
   (bg-alt     '("#ebe5df" "#ebe5df" "white"))
   (fg-alt     '("#625c87" "#625c87" "brightblack"))

   ;; nightfox bg0..bg4 / fg3 / comment / fg2 / fg0, in doom's base0..base8 order
   (base0      '("#ebe5df" "#ebe5df" "black"))
   (base1      '("#faf4ed" "#faf4ed" "brightblack"))
   (base2      '("#ebe0df" "#ebe0df" "brightblack"))
   (base3      '("#ebdfe4" "#ebdfe4" "brightblack"))
   (base4      '("#bdbfc9" "#bdbfc9" "brightblack"))
   (base5      '("#a8a3b3" "#a8a3b3" "brightblack"))
   (base6      '("#9893a5" "#9893a5" "brightblack"))
   (base7      '("#625c87" "#625c87" "brightblack"))
   (base8      '("#4c4769" "#4c4769" "white"))

   (grey       base4)
   (red        '("#b4637a" "#b4637a" "red"))
   (orange     '("#d7827e" "#d7827e" "brightred"))
   (green      '("#618774" "#618774" "green"))
   (teal       '("#629f81" "#629f81" "brightgreen"))
   (yellow     '("#ea9d34" "#ea9d34" "yellow"))
   (blue       '("#286983" "#286983" "brightblue"))
   (dark-blue  '("#295e73" "#295e73" "blue"))
   (magenta    '("#907aa9" "#907aa9" "brightmagenta"))
   (violet     '("#816b9a" "#816b9a" "magenta"))
   (cyan       '("#56949f" "#56949f" "brightcyan"))
   (dark-cyan  '("#50848c" "#50848c" "cyan"))

   ;; extra nightfox colors, exposed for user overrides
   (pink       '("#d685af" "#d685af" "magenta"))
   (black      '("#575279" "#575279" "black"))
   (white      '("#e5e9f0" "#e5e9f0" "white"))
   (sel0       '("#d0d8d8" "#d0d8d8" "brightblack"))
   (preproc    '("#c9709e" "#c9709e" "magenta"))
   (regex      '("#dd9024" "#dd9024" "yellow"))
   (sel1       '("#b8cece" "#b8cece" "brightblack"))

   ;; face categories -- mapped from nightfox's generate_spec()
   (highlight      blue)
   (vertical-bar   base0)
   (selection      sel1)
   (builtin        '("#b4637a" "#b4637a" "red"))
   (comments       (if doom-dawnfox-brighter-comments dark-cyan base6))
   (doc-comments   (doom-darken (if doom-dawnfox-brighter-comments dark-cyan base6) 0.2))
   (constants      '("#ca6e69" "#ca6e69" "brightred"))
   (functions      '("#295e73" "#295e73" "blue"))
   (keywords       '("#907aa9" "#907aa9" "magenta"))
   (methods        '("#295e73" "#295e73" "blue"))
   (operators      '("#625c87" "#625c87" "white"))
   (type           '("#ea9d34" "#ea9d34" "yellow"))
   (strings        '("#618774" "#618774" "green"))
   (variables      '("#575279" "#575279" "white"))
   (numbers        '("#d7827e" "#d7827e" "brightred"))
   (region         sel0)
   (error          '("#b4637a" "#b4637a" "red"))
   (warning        '("#ea9d34" "#ea9d34" "yellow"))
   (success        '("#618774" "#618774" "green"))
   (vc-modified    '("#ea9d34" "#ea9d34" "yellow"))
   (vc-added       '("#618774" "#618774" "green"))
   (vc-deleted     '("#b4637a" "#b4637a" "red"))

   ;; custom categories
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-dawnfox-brighter-modeline base3 base0))
   (modeline-bg-alt          (if doom-dawnfox-brighter-modeline base3 base0))
   (modeline-bg-inactive     base0)
   (modeline-bg-inactive-alt base0)
   (-modeline-pad
    (when doom-dawnfox-padded-modeline
      (if (integerp doom-dawnfox-padded-modeline) doom-dawnfox-padded-modeline 4))))

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
   (mode-line-emphasis :foreground (if doom-dawnfox-brighter-modeline base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-dawnfox-brighter-modeline modeline-bg highlight))
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

;;; doom-dawnfox-theme.el ends here

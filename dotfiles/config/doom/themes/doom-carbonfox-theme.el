;;; doom-carbonfox-theme.el --- carbonfox from nightfox.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Port of EdenEast/nightfox.nvim (carbonfox) to doom-themes. Palette values were
;; resolved from lua/nightfox/palette/carbonfox.lua and its generate_spec().
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-carbonfox-theme nil
  "Options for the `doom-carbonfox' theme."
  :group 'doom-themes)

(defcustom doom-carbonfox-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-carbonfox-theme
  :type 'boolean)

(defcustom doom-carbonfox-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-carbonfox-theme
  :type 'boolean)

(defcustom doom-carbonfox-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-carbonfox-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-carbonfox
  "A dark theme ported from nightfox.nvim's carbonfox variant."
  :family 'doom-nightfox
  :background-mode 'dark

  ;; name        gui / 256 / 16
  ((bg         '("#161616" "#161616" "black"))
   (fg         '("#f2f4f8" "#f2f4f8" "brightwhite"))
   (bg-alt     '("#0c0c0c" "#0c0c0c" "black"))
   (fg-alt     '("#b6b8bb" "#b6b8bb" "white"))

   ;; nightfox bg0..bg4 / fg3 / comment / fg2 / fg0, in doom's base0..base8 order
   (base0      '("#0c0c0c" "#0c0c0c" "black"))
   (base1      '("#161616" "#161616" "brightblack"))
   (base2      '("#252525" "#252525" "brightblack"))
   (base3      '("#353535" "#353535" "brightblack"))
   (base4      '("#535353" "#535353" "brightblack"))
   (base5      '("#7b7c7e" "#7b7c7e" "brightblack"))
   (base6      '("#6e6f70" "#6e6f70" "brightblack"))
   (base7      '("#b6b8bb" "#b6b8bb" "brightblack"))
   (base8      '("#f9fbff" "#f9fbff" "white"))

   (grey       base4)
   (red        '("#ee5396" "#ee5396" "red"))
   (orange     '("#3ddbd9" "#3ddbd9" "brightred"))
   (green      '("#25be6a" "#25be6a" "green"))
   (teal       '("#46c880" "#46c880" "brightgreen"))
   (yellow     '("#08bdba" "#08bdba" "yellow"))
   (blue       '("#78a9ff" "#78a9ff" "brightblue"))
   (dark-blue  '("#6690d9" "#6690d9" "blue"))
   (magenta    '("#be95ff" "#be95ff" "brightmagenta"))
   (violet     '("#a27fd9" "#a27fd9" "magenta"))
   (cyan       '("#33b1ff" "#33b1ff" "brightcyan"))
   (dark-cyan  '("#2b96d9" "#2b96d9" "cyan"))

   ;; extra nightfox colors, exposed for user overrides
   (pink       '("#ff7eb6" "#ff7eb6" "magenta"))
   (black      '("#282828" "#282828" "black"))
   (white      '("#dfdfe0" "#dfdfe0" "white"))
   (sel0       '("#2a2a2a" "#2a2a2a" "brightblack"))
   (preproc    '("#ff91c1" "#ff91c1" "magenta"))
   (regex      '("#2dc7c4" "#2dc7c4" "yellow"))
   (sel1       '("#525253" "#525253" "brightblack"))

   ;; face categories -- mapped from nightfox's generate_spec()
   (highlight      blue)
   (vertical-bar   base0)
   (selection      sel1)
   (builtin        '("#ee5396" "#ee5396" "red"))
   (comments       (if doom-carbonfox-brighter-comments dark-cyan base6))
   (doc-comments   (doom-lighten (if doom-carbonfox-brighter-comments dark-cyan base6) 0.2))
   (constants      '("#5ae0df" "#5ae0df" "brightred"))
   (functions      '("#8cb6ff" "#8cb6ff" "blue"))
   (keywords       '("#be95ff" "#be95ff" "magenta"))
   (methods        '("#8cb6ff" "#8cb6ff" "blue"))
   (operators      '("#b6b8bb" "#b6b8bb" "white"))
   (type           '("#08bdba" "#08bdba" "yellow"))
   (strings        '("#25be6a" "#25be6a" "green"))
   (variables      '("#dfdfe0" "#dfdfe0" "white"))
   (numbers        '("#3ddbd9" "#3ddbd9" "brightred"))
   (region         sel0)
   (error          '("#ee5396" "#ee5396" "red"))
   (warning        '("#be95ff" "#be95ff" "yellow"))
   (success        '("#25be6a" "#25be6a" "green"))
   (vc-modified    '("#08bdba" "#08bdba" "yellow"))
   (vc-added       '("#25be6a" "#25be6a" "green"))
   (vc-deleted     '("#ee5396" "#ee5396" "red"))

   ;; custom categories
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-carbonfox-brighter-modeline base3 base0))
   (modeline-bg-alt          (if doom-carbonfox-brighter-modeline base3 base0))
   (modeline-bg-inactive     base0)
   (modeline-bg-inactive-alt base0)
   (-modeline-pad
    (when doom-carbonfox-padded-modeline
      (if (integerp doom-carbonfox-padded-modeline) doom-carbonfox-padded-modeline 4))))

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
   (mode-line-emphasis :foreground (if doom-carbonfox-brighter-modeline base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-carbonfox-brighter-modeline modeline-bg highlight))
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

;;; doom-carbonfox-theme.el ends here

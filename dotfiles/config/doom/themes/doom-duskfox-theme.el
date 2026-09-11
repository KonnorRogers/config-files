;;; doom-duskfox-theme.el --- Duskfox using: https://github.com/EdenEast/nightfox.nvim/blob/main/lua/nightfox/palette/nightfox.lua as the basis  -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Source: https://github.com/EdenEast/nightfox.nvim/blob/main/lua/nightfox/palette/nightfox.lua
;;
;;; Commentary:
;;
;; Duskfox ported for doom, using https://github.com/doomemacs/themes/blob/master/themes/doom-one-theme.el as the basis.
;;
;;; Code:

(require 'doom-themes)

;; https://github.com/EdenEast/nightfox.nvim/blob/main/extra/duskfox/kitty.conf - Used as the basis.
;;
;;; Variables

(defgroup doom-duskfox-theme nil
  "Options for the `doom-duskfox-theme' theme."
  :group 'doom-themes)

(defcustom doom-duskfox-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-duskfox-theme
  :type 'boolean)

(defcustom doom-duskfox-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-duskfox-theme
  :type 'boolean)

(defcustom doom-duskfox-comment-bg doom-duskfox-brighter-comments
  "If non-nil, comments will have a subtle highlight to enhance their
legibility."
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
  "A dark theme inspired by Atom One Dark."
  :family 'doom-duskfox
  :background-mode 'dark

  ;; name        default   256           16
  ((bg         '("#232136" "black"   "black"  ))
   (fg         '("#e0def4" "#bfbfbf" "brightwhite"))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#191726" "black"   "black"  ))
   (fg-alt     '("#cdcbe0" "#2d2d2d" "white"  ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#191726" "black"   "black"        ))   ; bg0
   (base1      '("#232136" "#1e1e1e" "brightblack"  ))   ; bg1
   (base2      '("#2d2a45" "#2e2e2e" "brightblack"  ))   ; bg2
   (base3      '("#373354" "#262626" "brightblack"  ))   ; bg3
   (base4      '("#4b4673" "#3f3f3f" "brightblack"  ))   ; bg4
   (base5      '("#6e6a86" "#525252" "brightblack"  ))   ; fg3
   (base6      '("#817c9c" "#6b6b6b" "brightblack"  ))   ; comment
   (base7      '("#b1acde" "#979797" "brightblack"  ))   ; white.dim
   (base8      '("#eae8ff" "#dfdfdf" "white"        ))   ; fg0

   (grey       base4)
   (red        '("#eb6f92" "#ff6655" "red"          ))
   (orange     '("#ea9a97" "#dd8844" "brightred"    ))
   (green      '("#a3be8c" "#99bb66" "green"        ))
   (teal       '("#7bb8c1" "#44b9b1" "brightgreen"  ))   ; cyan.dim
   (yellow     '("#f6c177" "#ECBE7B" "yellow"       ))
   (blue       '("#569fba" "#51afef" "brightblue"   ))
   (dark-blue  '("#4a869c" "#2257A0" "blue"         ))   ; blue.dim
   (magenta    '("#c4a7e7" "#c678dd" "brightmagenta"))
   (violet     '("#eb98c3" "#a9a1e1" "magenta"      ))   ; pink
   (cyan       '("#9ccfd8" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("#65b1cd" "#5699AF" "cyan"         ))   ; blue.bright

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      '("#433c59"))
   (builtin        magenta)
   (comments       (if doom-duskfox-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-duskfox-brighter-comments dark-cyan base5) 0.25))
   (constants      violet)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (region         '("#63577d"))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-duskfox-brighter-modeline
                                 (doom-darken blue 0.45)
                               (doom-darken bg-alt 0.1)))
   (modeline-bg-alt          (if doom-duskfox-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-duskfox-padded-modeline
      (if (integerp doom-duskfox-padded-modeline) doom-duskfox-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-duskfox-comment-bg (doom-lighten bg 0.05) 'unspecified))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-duskfox-brighter-modeline base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-duskfox-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt))))

  ;;;; Base theme variable overrides-
  ())

;;; doom-duskfox-theme.el ends here

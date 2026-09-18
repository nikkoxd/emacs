;;; island-theme.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Vladislav
;;
;; Author: Vladislav <nikko@cachyos-x8664>
;; Maintainer: Vladislav <nikko@cachyos-x8664>
;; Created: июля 31, 2026
;; Modified: июля 31, 2026
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/nikko/island-theme
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(require 'doom-themes)

(defgroup island-theme nil
  "Options for the iris theme."
  :group 'doom-themes)

(def-doom-theme island
  "A theme generated from the current wallpaper by iris."

  ;;;; Color palette
  ;; name        gui          256   16
  ((bg          '("#d7bc98"      nil   nil))
   (bg-alt      '("#cdac7f" nil   nil))
   (fg          '("#221d16"      nil   nil))
   (fg-alt      '("#a08259"     nil   nil))

   ;; base0 is the "darkest" end, base8 the "lightest" (inverted in light mode,
   ;; which is fine — iris already flips color0/color15 for you)
   (base0       '("#d7bc98"       nil nil))
   (base1       '("#d7bc98"   nil nil))
   (base2       '("#cdac7f"  nil nil))
   (base3       '("#cdac7f"   nil nil))
   (base4       '("#a08259"      nil nil))
   (base5       '("#a08259"   nil nil))
   (base6       '("#a08259"   nil nil))
   (base7       '("#221d16"  nil nil))
   (base8       '("#221d16"  nil nil))

   (grey        base4)
   (red         '("#622c0e"      nil nil))
   (orange      '("#622c0e"   nil nil))
   (green       '("#3e620e"    nil nil))
   (teal        '("#1c4a78"   nil nil))
   (yellow      '("#695607"   nil nil))
   (blue        '("#665407"  nil nil))
   (dark-blue   '("#665407"   nil nil))
   (magenta     '("#472395"  nil nil))
   (violet      '("#472395"   nil nil))
   (cyan        '("#1c4a78"  nil nil))
   (dark-cyan   '("#1c4a78"   nil nil))

   ;;;; Face categories
   (highlight      '("#665407"  nil nil))
   (vertical-bar   base2)
   (selection      base2)
   (builtin        '("#1c4a78"     nil nil))
   (comments       '("#7c7265"  nil nil))
   (doc-comments   '("#7c7265"  nil nil))
   (constants      '("#4f741b"    nil nil))
   (functions      '("#1c4a78"     nil nil))
   (keywords       '("#472395"  nil nil))
   (methods        '("#1c4a78"     nil nil))
   (operators      '("#841f49" nil nil))
   (type           '("#1b744f"     nil nil))
   (strings        '("#866e09"   nil nil))
   (variables      '("#781e80"    nil nil))
   (numbers        '("#4f741b"    nil nil))
   (region         base2)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    yellow)
   (vc-added       green)
   (vc-deleted     red)

   ;;;; Custom
   (modeline-bg     bg-alt)
   (modeline-bg-alt bg)
   (modeline-fg     fg)
   (modeline-fg-alt fg-alt))

  ;;;; Face overrides
  (((line-number             &override) :foreground base4)
   ((line-number-current-line &override) :foreground highlight :weight 'bold)
   (cursor  :background highlight)
   (mode-line          :background modeline-bg :foreground modeline-fg)
   (mode-line-inactive :background modeline-bg-alt :foreground modeline-fg-alt)
   ((font-lock-comment-face &override) :slant 'italic)
   (doom-modeline-bar :background highlight)
   (tooltip :background bg-alt :foreground fg)

   ;;;; Selection — surface sits too close to bg to read as a highlight,
   ;;;; so these are blended off the accent instead.
   (region  :background (doom-blend highlight bg 0.15) :extend t)
   (hl-line :background (doom-blend fg bg 0.07))
   (vertico-current :background (doom-blend highlight bg 0.22)
                    :foreground fg :extend t)
   (vertico-group-title :foreground highlight :weight 'bold)

   ;;;; Match highlighting
   ((completions-common-part &override) :foreground highlight :weight 'bold)
   (orderless-match-face-0 :foreground highlight :weight 'bold)
   (orderless-match-face-1 :foreground magenta   :weight 'bold)
   (orderless-match-face-2 :foreground green     :weight 'bold)
   (orderless-match-face-3 :foreground yellow    :weight 'bold))

  ;;;; Variable overrides
  ())

(provide-theme 'island)
;;; island-theme.el ends here

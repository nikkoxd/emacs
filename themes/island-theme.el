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
  ((bg          '("#403f39"      nil   nil))
   (bg-alt      '("#53514a" nil   nil))
   (fg          '("#dfdff2"      nil   nil))
   (fg-alt      '("#838179"     nil   nil))

   ;; base0 is the "darkest" end, base8 the "lightest" (inverted in light mode,
   ;; which is fine — iris already flips color0/color15 for you)
   (base0       '("#403f39"       nil nil))
   (base1       '("#403f39"   nil nil))
   (base2       '("#53514a"  nil nil))
   (base3       '("#53514a"   nil nil))
   (base4       '("#838179"      nil nil))
   (base5       '("#838179"   nil nil))
   (base6       '("#838179"   nil nil))
   (base7       '("#dfdff2"  nil nil))
   (base8       '("#dfdff2"  nil nil))

   (grey        base4)
   (red         '("#cc7055"      nil nil))
   (orange      '("#cc7055"   nil nil))
   (green       '("#b0ddc6"    nil nil))
   (teal        '("#9c9ad5"   nil nil))
   (yellow      '("#b6a454"   nil nil))
   (blue        '("#cc7055"  nil nil))
   (dark-blue   '("#cc7055"   nil nil))
   (magenta     '("#db9c8a"  nil nil))
   (violet      '("#db9c8a"   nil nil))
   (cyan        '("#9c9ad5"  nil nil))
   (dark-cyan   '("#9c9ad5"   nil nil))

   ;;;; Face categories
   (highlight      '("#cc7055"  nil nil))
   (vertical-bar   base2)
   (selection      base2)
   (builtin        '("#9c9ad5"     nil nil))
   (comments       '("#918c78"  nil nil))
   (doc-comments   '("#918c78"  nil nil))
   (constants      '("#95d099"    nil nil))
   (functions      '("#9c9ad5"     nil nil))
   (keywords       '("#db9c8a"  nil nil))
   (methods        '("#9c9ad5"     nil nil))
   (operators      '("#d095af" nil nil))
   (type           '("#95d0c0"     nil nil))
   (strings        '("#bfd095"   nil nil))
   (variables      '("#c395d0"    nil nil))
   (numbers        '("#95d099"    nil nil))
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

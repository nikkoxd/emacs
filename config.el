(setq doom-theme 'island)

(setq doom-font (font-spec :family "IBM Plex Mono" :size 16))
(setq doom-variable-pitch-font (font-spec :family "IBM Plex Serif" :size 16))

;; (set-frame-parameter nil 'alpha-background 90)
;; (add-to-list 'default-frame-alist '(alpha-background . 90))

(setq display-line-numbers-type 'visual)

(set-face-attribute 'mode-line nil :height 120)
(set-face-attribute 'mode-line-inactive nil :height 120)

(setq-default mode-line-format
  '(" %[" (:propertize "%b" face mode-line-buffer-id) "%]"
    mode-line-modified
    " %l:%c"
    mode-line-format-right-align
    (:eval (when (mode-line-window-selected-p)
             (concat (format-mode-line mode-name) " ")))
    (vc-mode vc-mode) " "
    mode-line-misc-info))

(setq mode-line-right-align-edge 'right-margin)

(setq +fold-ellipsis "...")

(setq elfeed-feeds
      '(("https://blancvpnstatus.com/feed.rss" vpn status)
        ("https://www.reddit.com/r/unixporn.rss" linux reddit)))

(after! agent-shell
  agent-shell-screenshot-command "flameshot gui")

(use-package! agent-shell-tramp
  :after agent-shell
  :config
  (agent-shell-tramp-mode 1))

(after! dashboard
  (setq dashboard-center-content t
        dashboard-vertically-center-content t
        dashboard-image-banner-max-height 300))
(setq initial-buffer-choice 'dashboard-open)

(defvar +dashboard-banner-directory (expand-file-name "banners" doom-user-dir))

(defun +dashboard-refresh-banners-h ()
  "Set `dashboard-startup-banner' to the images in `+dashboard-banner-directory'."
  (setq dashboard-startup-banner
        (or (and (file-directory-p +dashboard-banner-directory)
                 (directory-files +dashboard-banner-directory t
                                  "\\.\\(png\\|gif\\|jpe?g\\|svg\\|xbm\\|txt\\)\\'"))
            'official)))

(add-hook 'dashboard-before-initialize-hook #'+dashboard-refresh-banners-h)

(after! shr
  (setq shr-use-colors nil))

(after! mu4e
  (add-to-list 'mu4e-view-actions '("xwidget" . mu4e-action-view-in-xwidget) t)
  (add-hook 'mu4e-view-mode-hook #'visual-line-mode))

(org-remark-global-tracking-mode +1)
(map! :leader
      :desc "Mark region" "r r" #'org-remark-mark
      :desc "Open marginal notes" "r n" #'org-remark-open
      :desc "Delete mark at cursor" "r d" #'org-remark-delete)

(use-package! reverse-im
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

(use-package! claude-code-ide
  :config
  (claude-code-ide-emacs-tools-setup)
  (map! :leader
        :desc "Claude Code"
        "c l" #'claude-code-ide-menu)
  (setq claude-code-ide-terminal-backend 'vterm))

(setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn)
(after! dash-docs
  (setq dash-docs-browser-func #'+lookup-xwidget-webkit-open-url-fn))
(add-to-list '+lookup-provider-url-alist
             '("Quickshell docs" "https://html.duckduckgo.com/html/?q=%s+site%%3Aquickshell.org"))

(use-package! colorful-mode
  :hook (prog-mode . colorful-mode))

(add-hook 'telega-load-hook 'telega-notifications-mode)
(setq telega-use-docker t
      telega-emoji-use-images nil
      telega-unread-chat-temex '(and main unread unmuted))
(map! :leader
      :desc "Telega" "t t" telega-prefix-map)

(custom-set-faces!
  '(org-document-title :height 1.5 :weight normal :slant italic)
  '(org-meta-line :slant italic)
  '(org-link :weight normal :slant italic :underline nil)
  '(link :weight normal :slant italic :underline nil)
  '(org-quote :inherit doom-variable-pitch-font :extend t :italic t)
  '(org-drawer :slant italic)
  '(org-block :height 0.9)
  '(org-block-begin-line :height 0.9 :extend t)
  '(org-block :extend t)
  '(org-block-end-line :height 0.9 :extend t)
  '(org-code :height 0.9)
  '(org-list-dt :inherit org-checkbox)
  '(org-level-1 :height 1.4 :weight bold :slant italic)
  '(org-level-2 :height 1.3 :weight normal :slant italic)
  '(org-level-3 :height 1.2 :weight normal :slant italic)
  '(org-level-4 :height 1.1 :weight normal :slant italic)
  '(org-level-5 :height 1.1 :weight normal :slant italic)
  '(org-level-6 :height 1.1 :weight normal :slant italic)
  '(org-level-7 :height 1.1 :weight normal :slant italic)
  '(org-level-8 :height 1.1 :weight normal :slant italic))

(after! org-modern
  (setq
   org-modern-list '((?- . "•")
                     (?+ . "✧")
                     (?* . "❋"))
   org-modern-star 'replace
   org-modern-replace-stars "木火土金水"
   org-modern-checkbox '((?X . "")
                         (?- . "")
                         (?\s . ""))))

(setq org-directory "~/Notes/"
      org-roam-directory "~/Notes/")

(setq org-yank-image-save-method (expand-file-name "images/" org-directory)
      org-yank-dnd-method 'file
      org-image-actual-width '(600)
      org-startup-with-inline-images t)

(defun +my/org-paste-media ()
  "Insert an image from the system clipboard, or paste text if there is none."
  (interactive)
  (condition-case nil
      (yank-media)
    (error (clipboard-yank))))

(map! :map org-mode-map
      :gni "C-S-v" #'+my/org-paste-media
      :localleader
      :desc "Paste image" "v" #'+my/org-paste-media)

(add-hook 'org-mode-hook #'mixed-pitch-mode)

(setq org-preview-latex-default-process 'dvisvgm)

(after! ox-latex
  (setq org-latex-compiler "xelatex"
        org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"))

  (add-to-list 'org-latex-classes
               '("ru-article"
                 "\\documentclass{article}
\\usepackage{fontspec}
\\usepackage{polyglossia}
\\setmainlanguage{russian}
\\setotherlanguage{english}
\\setmainfont{IBM Plex Serif}
\\setsansfont{IBM Plex Sans}
\\setmonofont{IBM Plex Mono}
[DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(setq org-export-preserve-breaks t)

(setq org-export-default-language "ru"
      org-export-with-smart-quotes t)

(after! ox
  (setf (alist-get "ru" org-export-smart-quotes-alist nil nil #'equal)
        '((primary-opening   :utf-8 "«" :html "&laquo;" :latex "«" :texinfo "@guillemetleft{}")
          (primary-closing   :utf-8 "»" :html "&raquo;" :latex "»" :texinfo "@guillemetright{}")
          (secondary-opening :utf-8 "„" :html "&bdquo;" :latex "„" :texinfo "@quotedblbase{}")
          (secondary-closing :utf-8 "“" :html "&ldquo;" :latex "“" :texinfo "@quotedblleft{}")
          (apostrophe        :utf-8 "’" :html "&#39;"   :latex "’"))))

(after! org
  (add-to-list 'org-file-apps '("\\.pdf\\'" . "xdg-open %s")))

(defvar my/roam-subject nil)

(defun my/roam-read-subject ()
  (setq my/roam-subject
        (completing-read
         "Subject: "
         (let ((d (expand-file-name "uni" org-roam-directory)))
           (when (file-directory-p d)
             (seq-filter (lambda (f)
                           (file-directory-p (expand-file-name f d)))
                         (directory-files d nil "\\`[^.]")))))))

(after! org-roam
  (add-to-list 'org-roam-capture-templates
               '("l" "uni" plain "%?"
                 :target (file+head
                          "lectures/%(my/roam-read-subject)/%<%Y%m%d%H%M%S>-${slug}.org"
                          "#+title: ${title}\n#+LATEX_CLASS: ru-article\n#+LATEX_CLASS_OPTIONS: [letterpaper]\n#+OPTIONS: toc:t\n#+FILETAGS: :Uni:%(or my/roam-subject \"\"):\n")
                 :unnarrowed t)
               :append)
  (setq org-roam-node-display-template
        (concat "${title:*} "
                (propertize "${file:32}" 'face 'org-roam-dim)
                " " (propertize "${tags:20}" 'face 'org-roam-tag)))
  (setq org-roam-file-exclude-regexp
        '("\\.st\\(versions\\|folder\\)/" "\\.attach/" "\\.agent-shell/")))

(add-hook 'text-mode-hook #'+zen/toggle)

(setq sql-connection-alist
      '((somnium-local-db (sql-product 'postgres)
         (sql-user "postgres")
         (sql-password "1234")
         (sql-server "localhost")
         (sql-database "somnium")
         (sql-port 5432))
      (somnium-auth-db (sql-product 'postgres)
         (sql-user "postgres")
         (sql-password "1234")
         (sql-server "localhost")
         (sql-database "somnium_auth")
         (sql-port 5432))))

(after! lsp-mode
  (setq lsp-qml-server-command "qmlls6"))

(add-to-list 'auto-mode-alist '("\.cu$" . c++-mode))

(defface gnus-group-news-low '((t :inherit default)) "Fix Emacs 31 cycle")
(defface gnus-group-news-low-empty '((t :inherit default)) "Fix Emacs 31 cycle")

(face-spec-set 'gnus-group-news-low '((t :inherit default)) 'reset)
(face-spec-set 'gnus-group-news-low-empty '((t :inherit default)) 'reset)

(setq select-enable-clipboard nil)
(evil-define-operator +my/yank-to-clipboard (beg end type)
  "Yank to system clipboard"
  :move-point nil
  (interactive "<R>")
  (evil-yank beg end type ?+))
(defun +my/paste-from-clipboard ()
  "Paste from system clipboard"
  (interactive)
  (evil-paste-after 1 ?+))
(map! :leader
      :desc "Yank to clipboard"    :nv "y" #'+my/yank-to-clipboard
      :desc "Paste from clipboard" :nv "v" #'+my/paste-from-clipboard)
(map! :gnvi "C-S-v" #'clipboard-yank)

(defun +my/unshadow-envvar (var)
  "Drop stale duplicate entries of VAR from `process-environment'.
The envvar snapshot is prepended to the environment Emacs inherited, so a
variable can appear more than once; keep only the last (inherited) entry."
  (let* ((re (concat "\\`" (regexp-quote var) "\\(=\\|\\'\\)"))
         (env (default-value 'process-environment))
         (matches (seq-filter (lambda (e) (string-match-p re e)) env))
         (keep (car (last matches))))
    (when (cdr matches)
      (setq-default process-environment
                    (seq-remove (lambda (e)
                                  (and (string-match-p re e)
                                       (not (eq e keep))))
                                env)))))

(mapc #'+my/unshadow-envvar
      '("HYPRLAND_INSTANCE_SIGNATURE" "HYPRLAND_CMD" "HL_INITIAL_WORKSPACE_TOKEN"
        "WAYLAND_DISPLAY" "XDG_ACTIVATION_TOKEN" "TMUX" "TMUX_PANE" "COLUMNS"))

(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/bin/fish")

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

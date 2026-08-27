(setq doom-theme 'island)

(setq doom-font (font-spec :family "JetBrains Mono" :size 16))
(setq doom-variable-pitch-font (font-spec :family "Inter" :size 16))

(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))

(setq display-line-numbers-type 'visual)

;; (setq-default mode-line-format
;;   '(" %[" (:propertize "%b" face mode-line-buffer-id) "%]"
;;     " %l:%c"
;;     mode-line-format-right-align
;;     (:eval (when (mode-line-window-selected-p)
;;              (concat (format-mode-line mode-name) " ")))
;;     (vc-mode vc-mode) " "
;;     mode-line-misc-info))
;; (setq mode-line-right-align-edge 'right-margin)

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

(setq org-directory "~/Notes/"
      org-roam-directory "~/Notes/")

(setq org-modern-star 'replace)

(add-hook 'org-mode-hook #'mixed-pitch-mode)

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

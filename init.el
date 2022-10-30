(setq user-full-name "AndyLu")

(setq inhibit-startup-screen t)

;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ;; ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
;;个别时候会出现签名检验失败
(setq package-check-signature nil) 

;; 初始化软件包管理器
(require 'package)
(unless (bound-and-true-p package--initialized)
    (package-initialize))

;; 刷新软件源索引
(unless package-archive-contents
    (package-refresh-contents))

;; 第一个扩展插件：use-package，用来批量统一管理软件包
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)
(setq evil-insert-state-cursor '("white" (box . 4)))
(evil-set-leader nil (kbd "SPC"))

;; TODO: not finished
;; (define-key evil-normal-state-map (kbd "s") #'save-buffer)

;; move entire line
(define-key evil-visual-state-map (kbd "M-j") (concat ":m '>+1" (kbd "RET") "gv=gv"))
(define-key evil-visual-state-map (kbd "M-k")   (concat ":m '<-2" (kbd "RET") "gv=gv"))
(define-key evil-normal-state-map (kbd "M-j") (concat ":m +1" (kbd "RET") "=="))
(define-key evil-normal-state-map (kbd "M-k")   (concat ":m -2" (kbd "RET") "=="))

;; for mac
(setq mac-option-modifier 'meta
      mac-command-modifier 'super)

;; === basic settings
;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)
(menu-bar-mode -1)

;; relative line number
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; 更改显示字体大小 14pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 140);;

;;让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; Disable backup file
(setq make-backup-files nil)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)
(set-face-underline-p 'highlight t)
;; (set-face-background hl-line-face "gray13")

;; set scroll margin
(setq scroll-margin 4)

(show-paren-mode t)

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

(unless (package-installed-p 'company)
  (package-install 'company))

(use-package company
  :hook (after-init . global-company-mode)
  :config (setq company-minimum-prefix-length 1
                company-show-quick-access t))

;; company mode 默认选择上一条和下一条候选项命令 M-n M-p
;; WARN: failed
;; (define-key company-active-map (kbd "C-n") 'company-select-next)
;; (define-key company-active-map (kbd "C-p") 'company-select-previous)

;; color scheme
(unless (package-installed-p 'gruvbox-theme)
  (package-install 'gruvbox-theme))
(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-soft t))

;; TODO: Working...
;; (use-package eglot
;;   :hook ((c-mode
;;           c++-mode
;;           go-mode
;;           java-mode
;;           js-mode
;;           python-mode
;;           rust-mode
;;           web-mode) . eglot-ensure)
;;   :bind (("C-c e f" . #'eglot-format)
;;          ("C-c e a" . #'eglot-code-actions)
;;          ("C-c e i" . #'eglot-code-action-organize-imports)
;;          ("C-c e q" . #'eglot-code-action-quickfix))
;;   :config
;;   ;; (setq eglot-ignored-server-capabilities '(:documentHighlightProvider))
;;   (add-to-list 'eglot-server-programs '(web-mode "vls"))
;;   (defun eglot-actions-before-save()
;;     (add-hook 'before-save-hook
;;               (lambda ()
;;                 (call-interactively #'eglot-format)
;;                 (call-interactively #'eglot-code-action-organize-imports))))
;;   (add-hook 'eglot--managed-mode-hook #'eglot-actions-before-save))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(eglot ace-window magit smart-mode-line gruvbox-theme ack evil-exchange evil-nerd-commenter evil company)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

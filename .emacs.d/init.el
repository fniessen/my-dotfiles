;;; init.el --- Emacs configuration file

;; Copyright (C) 2012-2024 Fabrice Niessen

;;; Commentary:

;;; Code:

;; Start recording the load time.
(defconst init--load-start-time (current-time)
  "Value of `current-time' before loading the init.el file.")

(message "[Loading `%s'...]" load-file-name)


(setq debug-on-error t)


;; Initialize the package manager.
(ignore-errors
  (package-initialize))

;;* Load path ----------------------------------------------------------------

;; Directory containing additional Emacs Lisp packages (from the Internet).
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;;* Must have ----------------------------------------------------------------

;; Disable any input method to use pure English input.
(setq default-input-method nil)         ; STOP ENCOUNTERING LAGGY ISSUES ON WSL2.

;; (require 'emacs-load-time)
;; (setq elt-verbose nil) ;; <<<<<<<<<<

;;* 48 Customization ---------------------------------------------------------

;; The default font should be able to display the following UTF-8 characters:
;; - white right-pointing triangle (indicating a collapsed Org headline)
;; - `boxquote' (side and corners)
;; - `calfw'

;; Set a font for (all) the frame(s) if the display is graphic.
(when (display-graphic-p)
  (cond
   ((font-info "Consolas")
    (set-frame-font "Consolas-10" nil t))
   ((font-info "Hack")
    (set-frame-font "Hack-8" nil t))
   ((font-info "DejaVu Sans Mono")
    (set-frame-font "DejaVu Sans Mono-14" nil t))
   ((font-info "Ubuntu Mono")
    (set-frame-font "Ubuntu Mono-14" nil t))))

;; Other monospaced fonts to look at (with many UTF-8 chars):
;; - Source Code Pro (!)
;; - Free Monospaced
;; - Inconsolata
;; - Droid Sans Mono
;; - Menlo (!)
;; - Monaco
;; - Ubuntu Mono

;;* 00 Emacs Leuven ----------------------------------------------------------

;; (setq leuven-load-chapter-0-debugging nil)

;; (setq leuven-load-chapter-48-packages nil)
;; (setq leuven-load-chapter-1-screen nil)
;; (setq leuven-load-chapter-6-exiting nil)
;; (setq leuven-load-chapter-7-basic nil)
;; (setq leuven-load-chapter-8-minibuffer nil)
;; (setq leuven-load-chapter-10-help nil)
;; (setq leuven-load-chapter-11-mark nil)
;; (setq leuven-load-chapter-12-killing nil)
;; (setq leuven-load-chapter-13-registers nil)
;; (setq leuven-load-chapter-14-display nil)
;; (setq leuven-load-chapter-15-search nil)
;; (setq leuven-load-chapter-16-fixit nil)
;; (setq leuven-load-chapter-17-keyboard-macros nil)
;; (setq leuven-load-chapter-18-files nil)
;; (setq leuven-load-chapter-19-buffers nil)
;; (setq leuven-load-chapter-20-windows nil)
;; (setq leuven-load-chapter-21-frames nil)
;; (setq leuven-load-chapter-22-international nil)
;; (setq leuven-load-chapter-23-major-and-minor-modes nil)
;; (setq leuven-load-chapter-24-indentation nil)
;; (setq leuven-load-chapter-25-text nil)       ; XXX Loads Org at startup, if 25 commented and 27 uncommented!
;; (setq leuven-load-chapter-25.11-tex-mode nil)
;; (setq leuven-load-chapter-26-programs nil)
;; (setq leuven-load-chapter-27-building nil)
;; (setq leuven-load-chapter-28-maintaining nil)
;; (setq leuven-load-chapter-29-abbrevs nil)
;; (setq leuven-load-chapter-30-dired nil)
;; (setq leuven-load-chapter-31-calendar-diary nil)
;; (setq leuven-load-chapter-32-sending-mail nil)
;; (setq leuven-load-chapter-34-gnus nil)
;; (setq leuven-load-chapter-36-document-view nil)
;; (setq leuven-load-chapter-38-shell nil)
;; (setq leuven-load-chapter-39-emacs-server nil)
;; (setq leuven-load-chapter-40-printing nil)
;; (setq leuven-load-chapter-41-sorting nil)
;; (setq leuven-load-chapter-44-saving-emacs-sessions nil)
;; (setq leuven-load-chapter-46-hyperlinking nil)
;; (setq leuven-load-chapter-47-amusements nil)
;; (setq leuven-load-chapter-49-customization nil)
;; (setq leuven-load-chapter-AppG-ms-dos nil)
;; (setq leuven-load-chapter-XX-emacs-display nil)
;; (setq leuven-load-chapter-99-debugging nil)

;; (setq leuven-verbose-loading t)

;; (setq leuven-excluded-packages
;;       '(useless-package
;;         other-annoying-package))

;; Add the '~/lisp/' directory to the load path if it exists.
(let ((emacs-leuven-path "~/lisp/"))
  (when (file-exists-p emacs-leuven-path)
    (add-to-list 'load-path (expand-file-name emacs-leuven-path))))

;; (let ((file-name-handler-alist nil))    ; Easy little known step to speed up
;;                                         ; Emacs start up time.
;; FIXME: When activated, breaks windows-path interpretation of 'es' results...

;; Load several init files.
(dolist (init-file
     '(
       "~/.emacs.d/init_emacsboost.el"
       "~/.emacs.d/init_local.el"
       "~/.emacs.d/init_local_org.el"
       "~/.emacs.d/init_archibus.el"
       ))
  (let ((file-exists (file-exists-p init-file)))
    (if file-exists
        (load-file init-file)
      (progn
        (message (concat "[" init-file " NOT found]"))
        (sit-for 2)))))

;; Load several libraries.
(dolist (library
         '(
           "emacs-leuven"
           "emacs-leuven-org"
           "emacs-leuven-bbdb"
           "emacs-leuven-ess"
           "emacs-leuven-ledger"
           ))
  (when (locate-library library)
    (message "[Loading library: %s]" library)
    (require (intern library))))


;; (defun lvn-helm-projectile-or-find-files ()
;;   "Switch project with Helm Projectile or find files with Helm.
;; If called with a prefix argument (C-u), it will invoke Helm to find files.
;; Otherwise, it will switch between projects using Helm Projectile."
;;   (interactive)
;;   (if current-prefix-arg
;;       (helm-find-files)
;;     (helm-projectile-switch-project)))
;;
;; (defun lvn-helm-projectile-or-find-files ()
;;   "Switch project with Helm Projectile or find files with Helm.
;; If called with a prefix argument (C-u), it will invoke Helm to find files.
;; Otherwise, it will switch between projects using Helm Projectile."
;;   (interactive)
;;   (if current-prefix-arg
;;       (helm :sources (helm-build-in-buffer-source "Find files"
;;                        :data (list (cons "Open" (directory-files-recursively default-directory '("\\.el$" "\\.org$" "\\.txt$" "\\.md$")))))
;;             :prompt "Find files: "
;;             :buffer "*Helm Find Files*")
;;     (helm-projectile-switch-project)))


(global-set-key (kbd "<f3>") 'helm-for-files)



;; Compute and display the load time.
(let ((load-time (float-time (time-subtract (current-time) init--load-start-time))))
  (message "[Loaded `%s' in %.2f s]" load-file-name load-time))

;;; init.el ends here

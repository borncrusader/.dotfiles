;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Srinath Krishna Ananthakrishnan"
      user-mail-address "srinath.krishna@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one
      doom-font "Monaco-16"
      doom-variable-pitch-font "Georgia-16"
      doom-themes-treemacs-enable-variable-pitch nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; global
(map! "<escape>" 'keyboard-escape-quit)

(global-prettify-symbols-mode t)

(global-whitespace-mode 1)
(setq! whitespace-style
       '(face ; viz via faces
         trailing ; trailing blanks visualized
         ;lines-tail ; lines beyond whitespace-line-column
         ;space-before-tab
         ;space-after-tab
         newline ; lines with only blanks
         ;indentation ; spaces used for when config wants tabs
         empty ; empty lines at beginning or end
        ))

;; swiper and ivy
(map! "C-s" 'swiper
      "C-r" 'swiper-backward)

;; org-mode
;;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq! org-books-directory (concat org-directory "/books")
       org-feeds-directory (concat org-directory "/feeds")
       org-journal-directory (concat org-directory "/journal")
       org-work-directory (concat org-directory "/work")
       org-book-notes-file (concat org-books-directory "/book-notes.org")
       org-course-notes-file (concat org-directory "/course-notes.org")
       org-notes-file (concat org-directory "/notes.org")
       org-curiosity-file (concat org-directory "/curiosity.org")
       org-projects-file (concat org-directory "/projects.org")
       org-default-todo-file (concat org-directory "/inbox.org")
       org-work-todo-file (concat org-work-directory "/inbox.org")
       org-elfeed-file (concat org-feeds-directory "/elfeed.org")
       org-export-coding-system 'utf-8
       ;;org-ellipsis " ..."
       org-agenda-files (list org-default-todo-file org-work-todo-file))

(add-hook! 'org-mode-hook
           #'visual-line-mode
           #'turn-on-auto-fill)

(defun org-find-books-file ()
  "Open books notes file"
  (interactive)
  (find-file org-book-notes-file))

(defun org-journal-file-name ()
  "Get journal file name"
  (interactive)
  (let ((d (concat org-journal-directory (format-time-string "/%y/%m")))
        (f (format-time-string "/%d.org")))
    (progn (make-directory d 1)
           (concat d f))))

(defun org-find-journal-file()
  "Open journal file"
  (interactive)
  (find-file (org-journal-file-name)))

(defun org-find-curiosity-file ()
  "Open curiosity/learn file"
  (interactive)
  (find-file org-curiosity-file))

(defun org-find-notes-file ()
  "Open notes file"
  (interactive)
  (find-file org-notes-file))

(defun org-find-todo-file ()
  "Open TODO file"
  (interactive)
  (find-file org-default-todo-file))

(defun org-find-work-todo-file ()
  "Open work TODO file"
  (interactive)
  (find-file org-work-todo-file))

(defun org-find-work-notes-file ()
  "Open work notes file"
  (interactive)
  (find-file (expand-file-name (format-time-string "%Y-%m.org") org-work-directory)))

(defun org-sort-and-archive-done ()
  "Sort and archive all done items"
  (interactive)
  (progn (org-map-entries '(org-sort-entries t ?o) "ROOT=true" 'file)
         (org-map-entries 'org-archive-subtree "/DONE" 'file)
         (org-map-entries 'org-archive-subtree "/NOTDOING" 'file)))

(defun org-sort-all-things()
  (interactive)
  (org-map-entries '(org-sort-entries t ?o) "ROOT=\"true\"" 'file))

(map! :map org-mode-map
      :nv "C-c C-x s" 'org-sort-and-archive-done
      :nv "C-c C-x t" 'org-sort-all-things)

(map! "C-c a" 'org-agenda
      "C-c b" 'org-find-books-file
      "C-c c" 'org-capture
      "C-c j" 'org-find-journal-file
      "C-c l" 'org-find-curiosity-file
      "C-c n" 'org-find-notes-file
      "C-c o" 'org-find-todo-file
      "C-c v" 'org-find-work-todo-file
      "C-c w" 'org-find-work-notes-file)

(after! org
  (setq! org-capture-templates
         '(("b" "Book" entry (file+headline org-book-notes-file "Unfiled")
            (file "~/org/templates/book-notes.orgcaptmpl"))
           ("c" "Course Notes" entry (file+headline org-course-notes-file "Unfiled")
            (file "~/org/templates/course-notes.orgcaptmpl"))
           ("f" "Feeds" entry (file+headline org-elfeed-file "Incoming")
            "** %?\n")
           ("j" "Journal" entry (file (lambda() (org-journal-file-name)))
            (file "~/org/templates//journal.orgcaptmpl"))
           ("n" "Notes" entry (file+headline org-notes-file "Unfiled")
            (file "~/org/templates/notes.orgcaptmpl"))
           ("t" "TODO" entry (file+headline org-default-todo-file "Inbox")
            "** TODO %?\n %i\n")
           ("l" "Curiosity List" entry (file+headline org-curiosity-file "Incoming")
            "** TODO %?\n %i\n")
           ("v" "Work TODO" entry (file+headline org-work-todo-file "Inbox")
            "** TODO %?\n %i\n")
           ("w" "Work" entry (file (lambda() (expand-file-name (format-time-string "%Y-%m.org") org-work-directory)))
            (file "~/org/templates/work-notes.orgcaptmpl")))
         ;; have the tags pretty far out; the fill column is 80
         org-tags-column -98))

;; reading feeds

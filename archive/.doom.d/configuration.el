  (setq! org-books-directory (concat org-directory "/books")
         org-feeds-directory (concat org-directory "/feeds")
         org-journal-directory (concat org-directory "/journal")
         org-work-directory (concat org-directory "/work")
         org-book-notes-file (concat org-books-directory "/book-notes.org")
         org-course-notes-file (concat org-directory "/course-notes.org")
         org-notes-file (concat org-directory "/notes.org")
         org-learn-list-file (concat org-directory "/learn.org")
         org-projects-file (concat org-directory "/projects.org")
         org-default-todo-file (concat org-directory "/inbox.org")
         org-work-todo-file (concat org-work-directory "/inbox.org")
         org-elfeed-file (concat org-feeds-directory "/elfeed.org")
         org-export-coding-system 'utf-8)

  (add-hook! 'org-mode-hook
             #'visual-line-mode
             #'turn-on-auto-fill)

  (defun org-find-todo-file ()
    "Open TODO file"
    (interactive)
    (find-file org-default-todo-file))

  (map! "C-c o" #'org-find-todo-file)

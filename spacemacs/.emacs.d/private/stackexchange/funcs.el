;;; funcs.el --- stackexchange Layer packages File for Spacemacs
;;
;; Copyright (c) 2018 Robert Clarke & Contributors
;;
;; Author: Robert Clarke <kumo@kumo.it>
;; URL: ...
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

  ;; datetree refiling from https://emacs.stackexchange.com/questions/10597/how-to-refile-into-a-datetree
  (defun org-refile-to-datetree (&optional file)
    "Refile a subtree to a datetree corresponding to it's timestamp.

The current time is used if the entry has no timestamp. If File
is nil, refile in the current file."
    (interactive "f")
    (let* ((datetree-date (or (org-entry-get nil "CREATED" t)
                              (org-read-date t nil "now")))
           (date (org-date-to-gregorian datetree-date))
           )
      (save-excursion
        (with-current-buffer (current-buffer)
          (org-cut-subtree)
          (if file (find-file file))
          (org-datetree-find-date-create date)
          (org-narrow-to-subtree)
          (show-subtree)
          (org-end-of-subtree t)
          (newline)
          (goto-char (point-max))
          (org-paste-subtree 4)
          (widen)
          ))
      )
    )

    ;; from http://joelmccracken.github.io/entries/emacs-hack-set-todo-done-yesterday/
  (defun org-todo-toggle-yesterday ()
    ;; this function is interactive, meaning a "command" that we call
    ;; as an emacs user (allows us to do "M-x org-todo-toggle-yesterday")
    (interactive)
    
    (let ((time-in-question (decode-time))) 
      ;; time-in-question is the current time, decoded into convenient fields

      ;; decrease the field by one which represents the day -- make it "yesterday"
      (decf (nth 3 time-in-question))

      ;; now, re-encode that time
      (setq time-in-question (apply 'encode-time time-in-question))
      
      (flet ((current-time () time-in-question))
        ;; flet temporarily binds current-time to this version, which
        ;; returns the time from yesterday 
        
        (org-todo)
        ;; toggles the todo heading
        )))

;; EOF

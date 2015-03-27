;;; -*- mode:emacs-lisp; indent-tabs-mode:nil; tab-width:2 -*-
;;;
;;; Time-stamp: <2015-04-13 16:14:46 mbykov@gmail.com>
;;;
;;; Stuff I use while hacking diglossa
;;;

(defun dg-compare-parallell (&optional no-msgs-p)
  (interactive)
  (let ((eop nil)
        (count 0)
        (line_num 0)
        (count_r 0))
    (save-excursion
      (if (< (point) (point-max))
          (progn
            (mark-paragraph)
            (narrow-to-region (point) (mark))
            (while (and (looking-at "$") (< (point) (point-max)))
              (beginning-of-line)
              (forward-line 1))
            (while (not (looking-at "$"))
              (setq count (1+ count))
              (forward-sentence 1))
            (widen)
            (while (and (looking-at "$") (< (point) (point-max)))
              (beginning-of-line))

            (goto-line (line-number-at-pos) (window-buffer (next-window)))
            (mark-paragraph)
            (narrow-to-region (point) (mark))
            (while (and (looking-at "$") (< (point) (point-max)))
              (beginning-of-line)
              (forward-line 1))
            (while (not (looking-at "$"))
              (setq count_r (1+ count_r))
              (forward-sentence 1))
            (widen)
            (while (and (looking-at "$") (< (point) (point-max)))
              (beginning-of-line))
            (set-mark nil)
            (goto-line (line-number-at-pos) (window-buffer (next-window)))

            (forward-line 1)
            (if (= count count_r)
                (progn
                  (beginning-of-line)
                  (forward-line 1)
                  (setq eop (point))
                  (recenter)
                  (goto-line (line-number-at-pos) (window-buffer (next-window)))
                  (recenter)
                  (goto-line (line-number-at-pos) (window-buffer (next-window)))
                  (message "there are %d %d sentences in this paragraph." count count_r)
                  )
              (message "=FALSE= are %d %d sentences in this paragraph." count count_r)
              )
            )))
    (if eop (goto-char eop))
    count))


(defun dg-both-home ()
  (interactive)
  (beginning-of-buffer)
  (next-multiframe-window)
  (beginning-of-buffer)
  (next-multiframe-window)
  )

(defun dg-other-buffer-same-pos ()
  (interactive)
  (goto-line (line-number-at-pos) (window-buffer (next-window))))

(defun dg-other-buffer-same-pos-recenter ()
  (interactive)
  (recenter)
  (goto-line (line-number-at-pos) (window-buffer (next-window)))
  (next-multiframe-window)
  (recenter)
  )


(defun dg-both-scroll-down ()
  (interactive)
  (scroll-down)
  (next-multiframe-window)
  (scroll-down)
  (next-multiframe-window)
  )

(defun dg-both-scroll-up ()
  (interactive)
  (scroll-up)
  (next-multiframe-window)
  (scroll-up)
  (next-multiframe-window)
  )

(fset 'both-windows-toggle
      [home ?\M-x ?t ?o ?g ?g ?l ?e ?- ?t ?r ?u ?n ?c ?a ?t ?e ?- ?l ?i ?n ?e ?s return ?\C-x ?o home ?\M-x up return home ?\C-x ?o])
(global-set-key (kbd "C-c t") 'both-windows-toggle)

(defun dg-both-toggle ()
  (interactive)
  (toggle-truncate-lines)
  (next-multiframe-window)
  (toggle-truncate-lines)
  (next-multiframe-window)
  )

(defun diglossa-modes-hook ()
  ;; (local-set-key "\M-&" 'count-sentences-in-paragraph)
  (customize-set-variable 'sentence-end "[.?!]")
  (local-set-key (kbd "C-c c") 'dg-compare-parallell)
  (local-set-key (kbd "C-c C-t") 'dg-both-toggle)
  (local-set-key (kbd "C-c C-p") 'dg-both-scroll-down)
  (local-set-key (kbd "C-c C-n") 'dg-both-scroll-up)
  (local-set-key (kbd "C-c C-h") 'dg-both-home)
  (local-set-key (kbd "C-c C-l") 'dg-other-buffer-same-pos)
  (local-set-key [(shift left)] (line-number-next-window))
  (local-set-key [(shift right)] (line-number-next-window))
  )


(add-hook 'text-mode-hook 'diglossa-modes-hook)
(add-hook 'fundamental-mode-hook 'diglossa-modes-hook)


;; ;; http://stackoverflow.com/questions/4754547/redefining-sentence-in-emacs-single-space-between-sentences-but-ignoring-ab
;; (defun forward-sentence()
;;   "Move point forward to the next sentence.
;; Start by moving to the next period, question mark or exclamation.
;; If this punctuation is followed by one or more whitespace
;; characters followed by a capital letter, or a '\', stop there. If
;; not, assume we're at an abbreviation of some sort and move to the
;; next potential sentence end"
;;   (interactive)
;;   (re-search-forward "[.?!]")
;;   (if (looking-at "[    \n]+[A-Z]\\|\\\\")
;;       nil
;;     (forward-sentence)))


 ;; (defun forward-sentence (&optional arg)
 ;;       "Move forward to next `sentence-end'.  With argument, repeat.
 ;;     With negative argument, move backward repeatedly to `sentence-beginning'.

 ;;     The variable `sentence-end' is a regular expression that matches ends of
 ;;     sentences.  Also, every paragraph boundary terminates sentences as well."
 ;;       (interactive "p")
 ;;       (or arg (setq arg 1))
 ;;       (let ((opoint (point))
 ;;             (sentence-end (sentence-end)))
 ;;         (while (< arg 0)
 ;;           (let ((pos (point))
 ;;                 (par-beg (save-excursion (start-of-paragraph-text) (point))))
 ;;            (if (and (re-search-backward sentence-end par-beg t)
 ;;                     (or (< (match-end 0) pos)
 ;;                         (re-search-backward sentence-end par-beg t)))
 ;;                (goto-char (match-end 0))
 ;;              (goto-char par-beg)))
 ;;           (setq arg (1+ arg)))
 ;;         (while (> arg 0)
 ;;           (let ((par-end (save-excursion (end-of-paragraph-text) (point))))
 ;;            (if (re-search-forward sentence-end par-end t)
 ;;                (skip-chars-backward " \t\n")
 ;;              (goto-char par-end)))
 ;;           (setq arg (1- arg)))
 ;;         (constrain-to-field nil opoint t)))

;;

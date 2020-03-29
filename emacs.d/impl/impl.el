(defun mage-display-benchmark()
(message "Mage loaded %s packages in %.03fs"
(length package-activated-list)
(or mage-init-time
  (setq mage-init-time
    (float-time (time-subtract (current-time) before-init-time))))))

 ;;横切变竖切，竖切边横切
(defun toggle-window-split ()
  "Vertical split shows more of each line,  horizontal split shows
  more lines. This code toggles between them. It only works for
  frames with exactly two windows."
  (interactive)
  (if (= (count-windows) 2)
    (let* ((this-win-buffer (window-buffer))
           (next-win-buffer (window-buffer (next-window)))
           (this-win-edges (window-edges (selected-window)))
           (next-win-edges (window-edges (next-window)))
           (this-win-2nd (not (and (<= (car this-win-edges)
                                       (car next-win-edges))
                                   (<= (cadr this-win-edges)
                                       (cadr next-win-edges)))))
           (splitter
             (if (= (car this-win-edges)
                    (car (window-edges (next-window))))
               'split-window-horizontally
               'split-window-vertically)))
      (delete-other-windows)
      (let ((first-win (selected-window)))
        (funcall splitter)
        (if this-win-2nd (other-window 1))
        (set-window-buffer (selected-window) this-win-buffer)
        (set-window-buffer (next-window) next-win-buffer)
        (select-window first-win)
        (if this-win-2nd (other-window 1))))))


;; 调节行间距
(setq-default line-spacing 2)
(defun toggle-line-spacing ()
"Toggle line spacing between 1 and 5 pixels."
(interactive)
(if (eq line-spacing 2)
(setq-default line-spacing 7)
(setq-default line-spacing 2)))








(provide 'impl)

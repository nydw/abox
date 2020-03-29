;;; powerline-themes.el --- Themes for Powerline

;; Copyright (C) 2012-2013 Donald Ephraim Curtis
;; Copyright (C) 2013 Jason Milkins
;; Copyright (C) 2012 Nicolas Rougier

;; Author: Donald Ephraim Curtis <dcurtis@milkbox.net>
;; URL: http://github.com/milkypostman/powerline/
;; Version: 2.0
;; Keywords: mode-line

;;; Commentary:
;;
;; Themes for Powerline.
;; Included themes: default, center, center-evil, vim, and nano.
;;

;;; Code:

(defcustom powerline-display-buffer-size t
  "When non-nil, display the buffer size."
  :group 'powerline
  :type 'boolean)

(defcustom powerline-display-mule-info t
  "When non-nil, display the mule info."
  :group 'powerline
  :type 'boolean)

(defcustom powerline-display-hud t
  "When non-nil, display the hud."
  :group 'powerline
  :type 'boolean)



(defface youth-active1 '((t (:foreground "grey20" :weight bold :inherit mode-line
                                             :background "#afd700" :inherit mode-line)))
         "Powerline face 5."
         :group 'powerline)

(defface youth-active2 '((t (:foreground "#87ffaf" :inherit mode-line
                                             :background "grey20" :inherit mode-line)))
         "Powerline face 6."
         :group 'powerline)

(defface youth-active3 '((t (:foreground "brightyellow" :weight bold :inherit mode-line
                                             :background "grey40" :inherit mode-line)))
         "Powerline face 7."
         :group 'powerline)

(defface youth-active4 '((t (:foreground "white" :inherit mode-line
                                             :background "grey40" :inherit mode-line)))
         "Powerline face 8."
         :group 'powerline)



;;;###autoload
(defun powerline-youth-theme ()
  "Setup the default mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'youth-active1 'powerline-inactive1))
                          (face2 (if active 'youth-active2 'powerline-inactive2))
                          (face3 (if active 'youth-active3 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw " " face2 'l)
                                     (when powerline-display-buffer-size
                                       (powerline-buffer-size face1 'l))
                                     (powerline-raw " " face1 'l)
                                     (when powerline-display-mule-info
                                       (powerline-raw mode-line-mule-info face1 'l))
                                     (powerline-raw " " face1 'l)
                                    ;(powerline-vc face3 'r)
                                     (powerline-raw "%f" face2 'l)
                                     (powerline-raw "%* " face2 'l)))
                                     ;(powerline-buffer-id nil 'l)
                                     ;(when (and (boundp 'erc-track-minor-mode) erc-track-minor-mode)
                                     ;(powerline-raw erc-modified-channels-object face1 'l))
                                     ;(powerline-major-mode face1 'l)
                                     ;(powerline-process face1)
                                     ;(powerline-minor-modes face1 'l)
                                     ;(powerline-narrow face1 'l)
                                     ;(funcall separator-left face1 face2)

                                     (rhs (list (powerline-raw global-mode-string face2 'r)
                                                (when (and (boundp 'which-func-mode) which-func-mode)
                                                  (powerline-raw which-func-format face2 'r))
                                                (set-face-foreground 'which-func "yellow")
                                                (set-face-background 'which-func "black")
                                                (powerline-raw "%4l" face1 'l)
                                                (powerline-raw ":" face1 'l)
                                                (powerline-raw "%3c" face1 'r)
                                                (powerline-raw " " face3 'r)
                                                (powerline-raw "%6p" face3 'r)
                                                (when powerline-display-hud
                                                  (powerline-hud face2 face1)))))
                     (concat (powerline-render lhs)
                             (powerline-fill face2 (powerline-width rhs))
                             (powerline-render rhs)))))))



(provide 'powerline-themes)

;;; powerline-themes.el ends here



(provide 'powerline-themes)

;;; powerline-themes.el ends here

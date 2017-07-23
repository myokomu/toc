;; tot stands for text to text. Whenever text is inserted in read-buffer,
;; the same text will be copied and pasted to the file of write-buffer."

(defun tot-write-here ()
  (interactive)
  (setq tot-write-buffer-path (buffer-file-name))
  (setq tot-write-buffer-name (buffer-name)))

(defun tot-read-here ()
  (interactive)
  (add-hook 'after-change-functions #'text-copy nil t))

(defvar tot-write-buffer-path nil)
(defvar tot-write-buffer-name nil)

(defun text-copy (beg end _len)
  (let ((text (buffer-substring-no-properties beg end)))
    (write-region text
                  nil
                  tot-write-buffer-path
                  'append)
    (set-buffer tot-write-buffer-name)
    (revert-buffer t t)))

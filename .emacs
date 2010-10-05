(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))                           
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))                               
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))   
;;(load "/home/jonathan/mw-screen-server.el")
;;    (require 'mw-screen-server)
;;     (mw-screen-server-install)
;;     (gnuserv-start)
;;(gnuserv-start)
(server-start)
; (defadvice server-process-filter (after post-mode-message first activate)
;    "If the buffer is in post mode, overwrite the server-edit
;    message with a post-save-current-buffer-and-exit message."
;    (if (eq major-mode 'post-mode)
;        (message
;         (substitute-command-keys "Type \\[describe-mode] for help composing; \\[post-save-current-buffer-and-exit] when done."))))
;;; ; This is also needed to see the magic message.  Set to a higher
;;; ; number if you have a faster computer or read slower than me.
    
; (font-lock-verbose 1000)

;;(load "/home/jonathan/.mutt/post")
;; ;;  (setq server-temp-file-regexp "mutt-")
;; ;;  (add-hook 'server-switch-hook
;; ;;          (function (lambda()
;; ;;                      (cond ((string-match "Post" mode-name)
;; ;;                             (post-goto-body))))))

;; ;; (add-to-list 'auto-mode-alist '("/mutt" . post-mode)) 

;; Customize post mode a bit.
(defun my-post-mode-hook ()
  ;Add a key binding for ispell-buffer.
  (local-set-key (kbd "C-c z") 'server-edit)
)
(add-hook 'post-mode-hook 'my-post-mode-hook)

    (add-hook 'after-init-hook 'server-start)
    (add-hook 'server-done-hook
              (lambda ()
                (shell-command
                 "screen -r -X select `cat ~/.emacsclient-caller`")))

;; jjg set C-s to help
;;(global-set-key "\M-i"  'help-command)
(global-set-key "\C-cs"  'help-command)
(define-key global-map "\C-h" 'backward-delete-char)

(fset 'sigjjg
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote (" >Cheers,JJG" 0 "%d")) arg)))

;; wanderlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; IMAP
(setq elmo-imap4-default-server "localhost")
;;(setq elmo-imap4-default-user "jjg") 
(setq elmo-imap4-default-authenticate-type 'clear) 
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)

;;(setq elmo-imap4-use-modified-utf7 t) 

;; SMTP
;; (setq wl-smtp-connection-type 'starttls)
;; (setq wl-smtp-posting-port 587)
;; (setq wl-smtp-authenticate-type "plain")
;; (setq wl-smtp-posting-user "mattofransen")
;; (setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "groll.co.za")

(setq wl-default-folder "%INBOX")
(setq wl-default-spec "%")
;; (setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP
;; (setq wl-trash-folder "%[Gmail]/Trash")

(setq wl-folder-check-async t) 

;;(setq elmo-imap4-use-modified-utf7 t)
(setq
;; Tell Emacs my name and e-mail address:
      user-full-name "Jonathan Groll"
      user-mail-address "jjg@groll.co.za"
      ;; mail-archive-file-name "Mail/SENT"
)
(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

;; (Require 'un-define)
;; (require 'jisx0213) (Require 'jisx0213)

;;from http://translate.google.com/translate?hl=en&sl=ja&u=http://www.tamaru.kuee.kyoto-u.ac.jp/kada/wl/unicode.html&ei=__CkTKX5PMeKswa2qpSsCA&sa=X&oi=translate&ct=result&resnum=4&sqi=2&ved=0CCgQ7gEwAw&prev=/search%3Fq%3Dwanderlust%2Bfrom%2B%2522%253D%253Futf-8%253F%26hl%3Den%26prmd%3Div

;;http://www.tamaru.kuee.kyoto-u.ac.jp/kada/wl/unicode.html
;;(require 'un-define)
;; (eval-after-load
;;     "mime-edit"
;;   '(let ((text (assoc "text" mime-content-types)))
;;      (set-alist 'text "plain"
;;                 '(("charset" "" "ISO-2022-JP" "US-ASCII"
;;                    "ISO-8859-1" "ISO-8859-8" "UTF-8")))
;;      (set-alist 'mime-content-types "text" (cdr text))))

;; emacs-fu wl iii:
;;from http://emacs-fu.blogspot.com/2010/02/i-have-been-using-wanderlust-e-mail.html
(setq mel-b-ccl-module nil)
(setq mel-q-ccl-module nil)
(setq base64-external-encoder '("mimencode"))
(setq base64-external-decoder '("mimencode" "-u"))
(setq base64-external-decoder-option-to-specify-file '("-o"))
(setq quoted-printable-external-encoder '("mimencode" "-q"))
(setq quoted-printable-external-decoder '("mimencode" "-q" "-u"))
(setq quoted-printable-external-decoder-option-to-specify-file '("-o"))
(setq base64-internal-decoding-limit 0)
(setq base64-internal-encoding-limit 0)
(setq quoted-printable-internal-decoding-limit 0)
(setq quoted-printable-internal-encoding-limit 0)

(setq-default mime-transfer-level 8)
(setq mime-header-accept-quoted-encoded-words t)

;;from http://emacs-w3m.namazu.org/
    (require 'w3m-load)
    (require 'mime-w3m)

;;--------------------------------------------------------------
;; Got many of the settings in the next big block
;; from:http://dis-dot-dat.blogspot.com/2010/04/my-wanderlust-setup.html
;;--------------------------------------------------------------

;; BBDB for harvesting Email addresses.
;; THe rest in in my WL file
(require 'bbdb)
(bbdb-initialize)

(setq
bbdb-use-pop-up nil
bbdb-offer-save 1 ;; 1 means save-without-asking
;;bbdb-use-pop-up t ;; allow popups for addresses
bbdb-electric-p t ;; be disposable with SPC
;;bbdb-popup-target-lines 1 ;; very small
bbdb-dwim-net-address-allow-redundancy t ;; always use full name
bbdb-quiet-about-name-mismatches 2 ;; show name-mismatches 2 secs
bbdb-always-add-address t ;; add new addresses to existing...
;; ...contacts automatically
;;bbdb-canonicalize-redundant-nets-p t ;; x@foo.bar.cx => x@bar.cx
bbdb-completion-type nil ;; complete on anything
bbdb-complete-name-allow-cycling t ;; cycle through matches
;; this only works partially
bbbd-message-caching-enabled t ;; be fast
bbdb-use-alternate-names t ;; use AKA
bbdb-elided-display t ;; single-line addresses

;; auto-create addresses from mail
bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook
;; bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
;; NOTE: there can be only one entry per header (such as To, From)
;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html

;; '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter")))

)

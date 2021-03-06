(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))                           
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))                               
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))   
(server-start)

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

;; load wanderlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; IMAP
(setq elmo-imap4-default-server "localhost")
(setq elmo-imap4-default-authenticate-type 'clear) 
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)

;; Use sendmail, so didn't define SMTP
;; (setq wl-smtp-connection-type 'starttls)
;; (setq wl-smtp-posting-port 587)
;; (setq wl-smtp-authenticate-type "plain")
;; (setq wl-smtp-posting-user "mattofransen")
;; (setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "groll.co.za")

(setq wl-default-folder "%INBOX")
(setq wl-default-spec "%")
(setq wl-folder-check-async t) 

(setq
;; Tell Emacs my name and e-mail address:
      user-full-name "Jonathan Groll"
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
bbdb-use-pop-up nil  ;; don't waste any precious screen real estate on BBDB
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

;; an attempt to make  wm scroll work as I like: (doesn't do it for MIME buffers)
(setq next-screen-context-lines 0)


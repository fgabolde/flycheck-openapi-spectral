;;; flycheck-openapi-spectral.el -- Support for flycheck in Swagger 2/OpenAPI 3 buffers using Spectral

;; -*- coding: utf-8 -*-

(flycheck-define-checker openapi-spectral
  "A Swagger/OpenAPI linter using Spectral.

See `https://github.com/stoplightio/spectral'."
  :command ("spectral" "lint" "-f" "text" (config-file "--ruleset" flycheck-openapi-spectralyml) source)
  :error-patterns ((warning line-start (file-name) ":" line ":" column " warning " (id (one-or-more (not blank))) " " (message))
                   (error line-start (file-name) ":" line ":" column " error " (id (one-or-more (not blank))) " " (message)))
  :modes yaml-mode
  :predicate (lambda ()
               (or
                (string-match
                 "swagger\\([[:space:]]\\)*:[[:space:]]*[\\\"']?2.0[\\\"']?"
                 ;; Need to avoid stack overflow for multi-line regex
                 (buffer-substring 1 (min (buffer-size) 300)))
                (string-match
                 "openapi\\([[:space:]]\\)*:[[:space:]]*[\\\"']?3.*[\\\"']?"
                 ;; Need to avoid stack overflow for multi-line regex
                 (buffer-substring 1 (min (buffer-size) 300))))))

(flycheck-def-config-file-var flycheck-openapi-spectralyml openapi-spectral
                              '(".spectral.yml" ".spectral.yaml" ".spectral.json"))

(add-to-list 'flycheck-checkers 'openapi-spectral)

;;; flycheck-openapi-spectral.el --- Support for flycheck in Swagger 2/OpenAPI 3 buffers using Spectral  -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C) 2022  Fabrice Gabolde

;; Author: Fabrice Gabolde <fgabolde@BIG02-fgabolde>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Requires https://github.com/stoplightio/spectral to be installed.

;;; Code:

(flycheck-define-checker openapi-spectral
  "A Swagger/OpenAPI linter using Spectral.

See `https://github.com/stoplightio/spectral'."
  :command ("spectral" "lint" "-f" "text" (config-file "--ruleset" flycheck-openapi-spectralyml) source)
  :error-patterns ((info line-start (file-name) ":" line ":" column " information " (id (one-or-more (not blank))) " " (message))
                   (warning line-start (file-name) ":" line ":" column " warning " (id (one-or-more (not blank))) " " (message))
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

(provide 'flycheck-openapi-spectral)
;;; flycheck-openapi-spectral.el ends here

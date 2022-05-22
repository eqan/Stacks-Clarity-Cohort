
;; L9
;; <add a description here>

;; constants
;;

;; data maps and vars
;;

;; private functions
;;
;; Use private functions as helper functions to perform large calculations

;; public functions
;;
;; Senior: > 40, Adult: 18-40, Minor: 18 <
(define-public (echo (age uint) (height uint)) 
    (if (> age u40)
        (ok "senior")
        (if (< age u18)
            (ok "minor")
            (ok "adult")
        )
    )
)

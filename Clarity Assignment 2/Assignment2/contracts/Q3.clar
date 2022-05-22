;; floor((EpochTime % 86400) / 3600)
;; floor(((EpochTime % 86400) % 3600) / 60)
;; floor((((EpochTime % 86400) % 3600) / 60) / 60)

(define-read-only (calculate-hours (time uint)) 
    (/ time u3600)
)

(define-read-only (calculate-minutes (time uint)) 
    (/ (mod (mod time u86400) u3600) u60)
)
(define-read-only (calculate-seconds (time uint)) 
    (let 
        (
            (last_digits (mod time u100))
        )
        (if (< last_digits u10) 
            (+ u00 last_digits)
            (+ last_digits u0)
        )
    )
)

(define-read-only (get-date (time uint)) 
    (let 
        (
            (hours (calculate-hours time))
            (minutes (calculate-minutes time))
            (seconds (calculate-seconds time))
            (result {hour: hours, min: minutes, sec: seconds})
        )
        (ok result)
    )
)
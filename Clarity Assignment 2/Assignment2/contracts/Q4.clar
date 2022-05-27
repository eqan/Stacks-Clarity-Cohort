(define-read-only (get-missing (numbers (list 10 uint)))
    (let 
        (
            (sum (fold + numbers u0)) ;; Adding all the integers from the list using fold
            (missing-number (- u55 sum)) ;; Subtracting the sum from the sum of first 10 decimals
        ) 
        (ok missing-number)
    )
)
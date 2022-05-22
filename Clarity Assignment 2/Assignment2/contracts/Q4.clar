(define-data-var number uint u1)

(define-read-only (get-missing (numbers (list 10 uint)))
    (let 
        (
            (result 
                (fold (if (not (is-eq number result)) (ok number) (+ number u1)) numbers u1)
            )
        )
        (ok number)
    )
    ;; (ok (fold * numbers 1))
)
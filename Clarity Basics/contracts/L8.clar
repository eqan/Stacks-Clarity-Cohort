
    ;; To not make local variables
    ;; (begin
    ;;     (+ 10 20)
    ;;     (+ 30 40)
    ;; )

    ;; To make local variables
    ;; (let
    ;;     (
    ;;         (sum (+ 10 20))
    ;;         (mul (* sum 20))
    ;;     )
    ;;     mul
    ;; )

(define-read-only (local-var) 
    (let
        (
            (sum (+ 10 20))
            (mul (* sum 20))
        )
        mul
    )
)
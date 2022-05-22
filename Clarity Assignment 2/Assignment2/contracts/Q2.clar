;; static int LeapYearsBefore(int year)
;; {
;;     System.Diagnostics.Debug.Assert(year > 0);
;;     year--;
;;     return (year / 4) - (year / 100) + (year / 400);
;; }

;; static int LeapYearsBetween(int start, int end)
;; {
;;     System.Diagnostics.Debug.Assert(start < end);
;;     return LeapYearsBefore(end) - LeapYearsBefore(start + 1);
;; }

(define-read-only (check-year (year uint)) 
    (let
        (
            (prev_year (- year u1))
        )
        (if (> year u0)
            (+ (- (/ prev_year u4) (/ prev_year u100)) (/ prev_year u400))
            (+ (- (/ year u4) (/ year u100)) (/ year u400))
        )
    )
)

(define-read-only (no-leap (start uint) (end uint))
    (if (< start end)
        (ok (+ (- (check-year end) (check-year (+ start u1))) u2))
        (ok u0)
    )
)
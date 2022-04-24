;; variable string

(define-data-var person (string-ascii 30) "Eqan")

(define-read-only (get-person)
    (var-get person)
)


;; List -> Arrays

  ;;                        type len    content of the len
  (define-data-var numbers (list 10 int) (list 1 2 3 4))
  (define-read-only (get-element)
      (unwrap-panic (element-at (var-get numbers) u0))
  )


;; Typles -> structs/udf

  (define-constant car {name: "eqan", age: 21})

;; mandatory for nested variables in ok/err in public functions
(define-public (set-person)
    (ok (var-set person 'Eqan'))
)


;; principals -> this/self/pointer/owner/caller || user/contract
  (define-constant owner "jdksakdasjdksa"
  (define-read-only (get-owner)
      owner
  )

;; responses -> ok/err

function claim(buffer) {
    if(beneficiary ==  principal)
        (transfer money to caller)
        (ok)
    else
    {
        (err)
    }
}

// you dont need to define the datatype in constant
  (define-constant size exprs)
  (define-constant size u10)
  (define-constant size 10)

// As this is a constant we just need to name the variable
  (define-read-only (get-size)
      size
  )

  (define-constant ERR_VALUE_NOT_EQUAL_TO (err false))
  (define-constant OK_VALUE_IS_EQUAL (ok true))

;; Only 1 type of value can be passed, but in the nested responses as above
;; we can pass multiple values
  (define-public (check-person)
      (if (is-eq "eqan" (var-get person))
        OK_VALUE_IS_EQUAL ;; true
        ERR_VALUE_NOT_EQUAL_TO ;; false
      )

  )


;; buffer

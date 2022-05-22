;; String -> ascii / utf-8 (emojis, urdu, different languages)
    ;; variable string      name       type      length   intial value
    (define-data-var       var_name (string-ascii 10)     "Ummar")

    ;; constant string     name       value
    (define-constant      const_name "Ali")

    (define-read-only (get-var-name)
        (var-get var_name) ;; we need var-get to access global variables
    )

     (define-read-only (get-const-name)
        const_name  ;; we can acess global constants directly
    )

;; integers -> uint (0,2^32) / int (-2^31, 2^31)

    (define-data-var  var_size int 10) 
    (define-constant const_size 10)

    (define-read-only (get-var-size)
        (var-get var_size)
    )

    (define-read-only (get-const-size)
        const_size
    )

;; boolean -> true/false

    (define-data-var var_isValid bool true)
    (define-constant const_isValid false)

    (define-read-only (get-var-isValid)
        (var-get var_isValid)
    )

    (define-read-only (get-const-isValid)
       const_isValid
    )

;; list -> arrays

                            ;;  max-len    type    inital
    (define-data-var var_months (list 10    int) (list 1 2 3 4 5 6 7 8 9 10))

    (define-constant const_months (list 1 2 3 4 5 6 7 8 9 10))

    (define-read-only (get-var-months)
        (var-get var_months)
    )

    (define-read-only (get-const-months)
        const_months
    )

;; tuples -> structs / udf

                                    ;; structure defination                      ;; value
    (define-data-var var_person {name: (string-ascii 10), age: int} {name: "Ummar", age: 21})

    (define-constant const_person {name: "Ummar", age: 21})

    (define-read-only (get-var-person)
        (var-get var_person)
    )

    (define-read-only (get-const-person)
        const_person
    )


;; principals -> this/self/pointer/owner/caller || user/contract


    (define-data-var var_owner principal 'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC)

    (define-constant const_owner 'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC)

   
   
    (define-read-only (get-var-owner)
        (var-get var_owner)
    )

    (define-read-only (get-const-owner)
        const_owner
    )

;; responses -> ok/err 


     (define-constant ERR_NO_VALUE_FOUND (err 404))

     (define-read-only (get-err-response)
        ERR_NO_VALUE_FOUND
    )

;; buffer 

                                  ;; hexadecimal
    (define-constant const_buffer 0x68656c6c6f21)
    (define-data-var var_buffer (buff 32) 0x2348564324)

    (define-read-only (get-const-buffer)
        const_buffer
    )

    (define-read-only (get-var-buffer)
        (var-get var_buffer)
    )


;; Optional -> some/none(null)

    (define-constant const_months_2 (list 1 2 3 4 5 6 7 8 9 10))

    (define-read-only (get-index)
        (element-at const_months_2 u20)
    )

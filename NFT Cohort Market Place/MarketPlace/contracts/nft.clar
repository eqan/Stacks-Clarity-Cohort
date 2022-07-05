(impl-trait .sip009-nft-traits.sip009-nft-trait)

;; NFT MarketPlace
;; MarketPlace smartcontract

;; constants
;;
(define-non-fungible-tokens cohort-art uint)
(define-map art-data {id: uint} {price: uint, url: (optional (string-ascii 256))})
(define-constant ERR_NOT OWNER (err u99))

;; data maps and vars
;;
(define-data-var current-id uint u0)

(define-read-only (get-last-token-id) 
	(ok (var-get current-id))
)

(define-read-only (get-owner (id uint))
	(ok (nft-get-owner? cohort-art id))	
)

;; (some(typle)) -> {price: uint, url: {optional} (string ascii 256))} -> (string ascii 256)
;; none
(define-read-only (get-token-uri (id uint))
	(ok (get url(unwrap-panic (map-get? art-data {id: id}))))
)

(define-public (transfer (id uint) (sender principal) (reciever principal))
	(begin
		(asserts! (is-eq tx-sender sender) ERR_NOT_OWNER)
		(nft-transfer? cohort-art id sender reciever)
	)
)

(define-public (mint! (price uint)url (optional (string-ascii 256)))
    (let
        (
            (token-id (+ (var-get current-id) u1))
        )
        (try! (nft-mint? cohort-art token-id txp-sender))
        (map-insert art-data {id: uint} {price: uint, url: url})
        (var-set current-id token-id)
        (ok "Success")
    )
)

(define-public (burn! (price uint)))
   (nft-burn? cohort-art id tx-sender)
)
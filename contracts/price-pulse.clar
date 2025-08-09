;; Title: PricePulse - Next-Generation Prediction Protocol
;;
;; Summary:
;; Revolutionary decentralized prediction marketplace leveraging blockchain transparency
;; to create fair, automated betting markets on cryptocurrency price movements with
;; instant settlements and proportional reward distribution.
;;
;; Description:
;; PricePulse transforms traditional prediction markets through smart contract automation,
;; enabling participants to stake tokens on binary price outcomes with mathematical
;; precision. The protocol features oracle-verified settlements, transparent fee structures,
;; and secure fund management. Built on Stacks blockchain for Bitcoin-level security,
;; PricePulse offers seamless user experience with programmable market creation,
;; automated reward calculations, and trustless claim processing.

;; CONSTANTS & ERROR CODES

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-invalid-prediction (err u102))
(define-constant err-market-closed (err u103))
(define-constant err-already-claimed (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-parameter (err u106))

;; DATA VARIABLES

(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
(define-data-var minimum-stake uint u1000000)
(define-data-var fee-percentage uint u2)
(define-data-var market-counter uint u0)

;; DATA STRUCTURES

(define-map markets
  uint
  {
    start-price: uint,
    end-price: uint,
    total-up-stake: uint,
    total-down-stake: uint,
    start-block: uint,
    end-block: uint,
    resolved: bool,
  }
)

(define-map user-predictions
  {
    market-id: uint,
    user: principal,
  }
  {
    prediction: (string-ascii 4),
    stake: uint,
    claimed: bool,
  }
)

;; CORE MARKET FUNCTIONS

;; Create a new prediction market
(define-public (create-market
    (start-price uint)
    (start-block uint)
    (end-block uint)
  )
  (let ((market-id (var-get market-counter)))
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> end-block start-block) err-invalid-parameter)
    (asserts! (> start-price u0) err-invalid-parameter)

    (map-set markets market-id {
      start-price: start-price,
      end-price: u0,
      total-up-stake: u0,
      total-down-stake: u0,
      start-block: start-block,
      end-block: end-block,
      resolved: false,
    })
    (var-set market-counter (+ market-id u1))
    (ok market-id)
  )
)

;; Submit prediction and stake tokens
(define-public (make-prediction
    (market-id uint)
    (prediction (string-ascii 4))
    (stake uint)
  )
  (let (
      (market (unwrap! (map-get? markets market-id) err-not-found))
      (current-block stacks-block-height)
    )
    (asserts!
      (and (>= current-block (get start-block market)) (< current-block (get end-block market)))
      err-market-closed

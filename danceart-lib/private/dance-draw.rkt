#lang racket/base

;; dance-draw -- render a "dancer" (the arm-diagram figure) to a PNG.
;;
;; A dancer is two arms pointing at clock positions (left green, right
;; blue) over a body whose shape shows the facing.  Ported from the tonart
;; concert's dance-annotation.  `save-dancer!` writes one to a PNG file.

(require 2htdp/image)
(provide make-dancer save-dancer!)

(define (the-pen color) (pen color 8 "solid" "round" "bevel"))
(define (arm-at hour colour)
  (rotate (* -30 hour) (put-pinhole 0 110 (line 0 110 (the-pen colour)))))
(define (make-body orientation)
  (define (left-body)
    (beside (square 30 'solid 'yellow)
            (rectangle 30 120 'solid 'yellow)
            (rectangle 30 120 'solid (color 130 0 200 255))))
  (case orientation
    [(towards) (ellipse 100 150 'solid 'yellow)]
    [(away)    (ellipse 100 150 'solid (color 130 0 200 210))]
    [(left)    (left-body)]
    [(right)   (flip-horizontal (left-body))]))

(define (make-dancer left-hour right-hour orientation)
  (define left-arm (arm-at left-hour 'green))
  (define right-arm (arm-at right-hour 'blue))
  (define body (make-body orientation))
  (clear-pinhole
   (case orientation
     [(towards)
      (define one-arm (overlay/pinhole right-arm (put-pinhole 10 75 body)))
      (underlay/pinhole (put-pinhole (+ (pinhole-x one-arm) 80) (pinhole-y one-arm) one-arm) left-arm)]
     [(away)
      (define one-arm (underlay/pinhole left-arm (put-pinhole 10 75 body)))
      (overlay/pinhole (put-pinhole (+ (pinhole-x one-arm) 80) (pinhole-y one-arm) one-arm) right-arm)]
     [(left)
      (define one-arm (overlay/pinhole left-arm (put-pinhole 40 50 body)))
      (overlay/pinhole (put-pinhole (- (pinhole-x one-arm) 5) (pinhole-y one-arm) one-arm) right-arm)]
     [(right)
      (define one-arm (overlay/pinhole right-arm (put-pinhole 40 50 body)))
      (overlay/pinhole (put-pinhole (- (pinhole-x one-arm) 5) (pinhole-y one-arm) one-arm) left-arm)])))

;; render a dancer to `path` (a PNG); l/r are clock hours (numbers),
;; facing is a string ("towards"/"away"/"left"/"right")
(define (save-dancer! l r facing path)
  (save-image (make-dancer l r (string->symbol facing)) path))

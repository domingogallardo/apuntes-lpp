#lang racket
(require 2htdp/image)

(provide caja-puntero)

;; ----------------------------------
;; Dibujo de diagramas caja y puntero
;; ----------------------------------

(define tamaño-texto 15)
(define ancho-puntero 1)

(define (caja apaisado)
  ((if apaisado beside above)
   (square 30 "outline" "black")
   (square 30 "outline" "black")))

(define (puntero largo apaisado)
  (rotate
   (if apaisado -90 180)
   (above (isosceles-triangle 10 45 "solid" "black")
          (rectangle ancho-puntero largo "solid" "black")
          (circle 3 "solid" "black"))))

(define (escrito dato)
  (text (format "~a" dato) tamaño-texto "black"))

(define (ajusta imagen ancho alto)
  (scale/xy
   (/ (min 25 ancho) ancho)
   (/ (min 25 alto) alto)
   imagen))

(define (escalada imagen)
  (ajusta imagen
          (image-width imagen)
          (image-height imagen)))

(define (pinta-caja-puntero dato apaisado)
  (if (pair? dato)
      (enlaza (pinta-caja-puntero (car dato) (not apaisado))
              (pinta-caja-puntero (cdr dato) apaisado)
              (pair? (car dato))
              (pair? (cdr dato))
              apaisado)
      (escrito dato)))

(define (pon-car caja imagen)
  (overlay/xy imagen
              (- (/ (image-width imagen) 2) 15)
              (- (/ (image-height imagen) 2) 15)
              caja))

(define (pon-cdr caja imagen apaisado)
  (overlay/xy imagen
              (- (/ (image-width imagen) 2) (if apaisado 45 15))
              (- (/ (image-height imagen) 2) (if apaisado 15 45))
              caja))

(define (enlaza-car caja imagen apaisado)
  (overlay/xy (puntero (- ((if apaisado image-height image-width) caja) 12) (not apaisado))
              -12 -12
              (overlay/xy imagen
                          (if apaisado 0 (- (+ (image-width caja) 15)))
                          (if apaisado (- (+ (image-height caja) 15)) 0)
                          caja)))

(define (enlaza-cdr caja imagen apaisado)
  (overlay/xy (puntero (- ((if apaisado image-width image-height) caja) 42) apaisado)
              (if apaisado -42 -12)
              (if apaisado -12 -42)
              (overlay/xy imagen
                          (if apaisado (- (+ (image-width caja) 15)) 0)
                          (if apaisado 0 (- (+ (image-height caja) 15)))
                          caja)))

(define (pinta-car enlazado imagen apaisado)
  (if enlazado
      (enlaza-car (caja apaisado) imagen apaisado)
      (pon-car (caja apaisado) (escalada imagen))))

(define (pinta-cdr enlazado caja imagen apaisado)
  (if enlazado
      (enlaza-cdr caja imagen apaisado)
      (pon-cdr caja (escalada imagen) apaisado)))

(define (enlaza imagen-car imagen-cdr enlazar-car enlazar-cdr apaisado)
  (pinta-cdr
      enlazar-cdr
      (pinta-car enlazar-car imagen-car apaisado)
      imagen-cdr
      apaisado))

(define (caja-puntero dato)
  (pinta-caja-puntero dato #t))

; Pruebas
; (caja-puntero '(1 . 2))
; (caja-puntero '(1))
; (caja-puntero '((1) . 2))
; (caja-puntero '(0 1))
; (caja-puntero '(1 (2 A 5) () #t ("as" . F) #\x))
; (caja-puntero '(1 (2 (a . b) 5) () #t ("as" . F) #\x))


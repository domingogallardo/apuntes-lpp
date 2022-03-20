#lang racket
(require 2htdp/image)

(provide hoja?)
(provide pinta-lista)

(provide crea-diccionario)
(provide get)
(provide put)

(provide exists?)
(provide for-all?)

(provide caja-puntero)

;;---------------------
;; Listas estructuradas
;;---------------------

(define (hoja? elem)
  (not (list? elem)))

;; --------------------------
;;  Pinta lista estructurada
;; --------------------------

(define t-espacio 8)
(define t-nodo 16)

(define (contenido imagen)
  (ajusta imagen
          (image-width imagen)
          (image-height imagen)))

(define (enlaza-raiz imagen pareja)     ; En pareja se espera la imagen de los hijos y
  (overlay/align "center" "top" imagen  ; una lista de las posiciones x de sus raices.
                 (foldl (lambda (x resultado)
                          (add-line resultado
                                    (/ (image-width resultado) 2)
                                    (+ (/ (image-height imagen) 2) t-espacio)
                                    x (+ (image-height imagen) t-espacio) "black"))
                        (above (rectangle (image-width (car pareja))
                                          (+ (image-height imagen) t-espacio)
                                          "solid"
                                          "transparent")
                               (car pareja))
                        (cdr pareja))))

(define (pinta-nodo dato)
  (overlay (contenido (escrito dato))
           (circle (- t-nodo 1) "solid" "white")
           (circle t-nodo "solid" "white")))

(define (junta-hijos lista)         ; Devuelve la pareja que necesita enlaza-raiz:
  (foldl (lambda (imagen resultado) ;                    (imagen . (x1 x2 ... xn))
           (cons (beside/align "top" (car resultado)
                                     (rectangle t-espacio (image-height imagen)
                                                "solid"
                                                "transparent")
                                     imagen)
                 (append (cdr resultado)
                         (list (+ t-espacio (image-width (car resultado))
                                  (/ (image-width imagen) 2))))))
         (cons (car lista) (list (/ (image-width (car lista)) 2)))
         (cdr lista)))


(define (pinta-lista lista)
  (if (hoja? lista)
      (pinta-nodo lista)
      (enlaza-raiz (pinta-nodo "*")
                   (junta-hijos (map pinta-lista lista)))))


;; ------------
;; Diccionario
;;-------------

(define (crea-diccionario)
  (mcons '*diccionario* '()))

(define (busca key dic)
  (cond
    ((null? dic) #f)
    ((equal? key (mcar (mcar dic)))
     (mcar dic))
    (else (busca key (mcdr dic)))))

(define (get key dic)
  (define record (busca key (mcdr dic)))
  (if (not record)
      #f
      (mcdr record)))

(define (put key value dic)
  (define record (busca key (mcdr dic)))
  (if (not record)
      (set-mcdr! dic
                (mcons (mcons key value)
                      (mcdr dic)))
      (set-mcdr! record value))
  value)

;;----------------------------
;; Funciones de orden superior
;;-----------------------------

(define (exists? predicado lista)
  (if (null? lista)
      #f
      (or (predicado (first lista))
          (exists? predicado (rest lista)))))


(define (for-all? predicado lista)
  (or (null? lista)
      (and (predicado (first lista))
           (for-all? predicado (rest lista)))))


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


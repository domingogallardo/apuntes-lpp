#lang racket
(require rackunit)
(require 2htdp/image)

(provide dato-arbol)
(provide hijos-arbol)
(provide hoja-arbol?)
(provide construye-arbol)

(provide dato-arbolb)
(provide hijo-izq-arbolb)
(provide hijo-der-arbolb)
(provide arbolb-vacio)
(provide vacio-arbolb?)
(provide hoja-arbolb?)
(provide construye-arbolb)

(provide hoja?)

(provide pinta-lista)
(provide pinta-arbol)
(provide pinta-arbolb)


(provide crea-diccionario)
(provide get)
(provide put)

(provide exists?)
(provide for-all?)

(provide caja-puntero)

(provide cartas)

;; --------------------------
;; Cartas y baraja francesa
;; --------------------------

(define (crea-parejas elemento lista)
  (if (null? lista)
      '()
      (cons (cons elemento (first lista))
            (crea-parejas elemento (rest lista)))))
  
(define (producto-cartesiano lista-x lista-y)
  (if (null? lista-x)
      '()
      (append (crea-parejas (first lista-x) lista-y)
              (producto-cartesiano (rest lista-x) lista-y))))

(check-equal? (producto-cartesiano '(J Q K) '(♠ ♣ ♥ ♦))
              '((J . ♠) (J . ♣) (J . ♥) (J . ♦)
                (Q . ♠) (Q . ♣) (Q . ♥) (Q . ♦)
                (K . ♠) (K . ♣) (K . ♥) (K . ♦)))

(define (crea-carta pareja)
  (string->symbol (string (car pareja) (cdr pareja))))

(check-equal? (crea-carta '(#\Q . #\♥)) 'Q♥)

(define (crea-cartas lista-parejas)
  (if (null? lista-parejas)
      '()
      (cons (crea-carta (first lista-parejas))
            (crea-cartas (rest lista-parejas)))))

(check-equal? (crea-cartas '((#\A . #\♣) (#\K . #\♦))) '(A♣ K♦))

(define baraja (crea-cartas
                (producto-cartesiano
                 (string->list "A23456789JQK")
                 (string->list "♠♣♥♦"))))

(define (pon-en-primera-lista elemento dos-listas)
  (cons (cons elemento (first dos-listas)) (rest dos-listas)))

(define (mueve-ref n dos-listas)
  (if (= n 0)
      (list (rest (first dos-listas))
            (cons (first (first dos-listas))
                  (second dos-listas)))
      (pon-en-primera-lista (first (first dos-listas))
                            (mueve-ref (- n 1)
                                       (list (rest (first dos-listas))
                                             (second dos-listas))))))

(define (cartas-ite n dos-listas)
  (if (= n 0)
      dos-listas
      (cartas-ite (- n 1)
                  (mueve-ref (random (length (first dos-listas)))
                             dos-listas))))

(define (cartas n)
  (second (cartas-ite n (list baraja '()))))


;; --------------------------
;; Árboles y árboles binarios
;; --------------------------

(define (dato-arbol arbol) 
    (first arbol))

(define (hijos-arbol arbol) 
    (rest arbol))

(define (hoja-arbol? arbol) 
   (null? (hijos-arbol arbol)))

(define (construye-arbol dato lista-arboles)
   (cons dato lista-arboles))

(define (dato-arbolb arbol)
   (first arbol))

(define (hijo-izq-arbolb arbol)
   (second arbol))

(define (hijo-der-arbolb arbol)
   (third arbol))

(define arbolb-vacio '())

(define (vacio-arbolb? arbol)
   (equal? arbol arbolb-vacio))

(define (hoja-arbolb? arbol)
   (and (vacio-arbolb? (hijo-izq-arbolb arbol))
        (vacio-arbolb? (hijo-der-arbolb arbol))))

(define (construye-arbolb dato hijo-izq hijo-der)
    (list dato hijo-izq hijo-der))

;; --------------------
;; Listas estructuradas
;; --------------------

(define (hoja? elem)
  (not (list? elem)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pintar arbol genérico ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define t-nodo 16)
(define t-letra 14)
(define t-ajuste 28)
(define t-espacio 8)

(define (pinta-nodo dato circulo?)
  (overlay (contenido (escrito dato))
           (circle (- t-nodo 1) "solid" "white")
           (circle t-nodo "solid" (if circulo? "black" "white"))))

(define (escrito dato)
  (text (format "~a" dato) t-letra "black"))

(define (ajusta imagen ancho alto)
  (scale/xy
   (/ (min t-ajuste ancho) ancho)
   (/ (min t-ajuste alto) alto)
   imagen))

(define (contenido imagen)
  (ajusta imagen
          (image-width imagen)
          (image-height imagen)))

(define (pinta-arbol arbol)
  (if (hoja-arbol? arbol)
      (pinta-nodo (dato-arbol arbol) #t)
      (enlaza-raiz (pinta-nodo (dato-arbol arbol) #t)
                   (junta-hijos (map pinta-arbol (hijos-arbol arbol))))))

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
         (cons (first lista) (list (/ (image-width (first lista)) 2)))
         (rest lista)))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pintar arbol binario ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (pinta-arbolb arbolb)
  (cond
    ((vacio-arbolb? arbolb) (circle t-nodo "solid" "white"))
    ((hoja-arbolb? arbolb) (pinta-nodo (dato-arbolb arbolb) #t))
    ((vacio-arbolb? (hijo-izq-arbolb arbolb))
     (enlaza-uno #f (pinta-nodo (dato-arbolb arbolb) #t)
                 (junta-hijos (list (pinta-arbolb arbolb-vacio)
                                    (pinta-arbolb (hijo-der-arbolb arbolb))))))
    ((vacio-arbolb? (hijo-der-arbolb arbolb))
     (enlaza-uno #t (pinta-nodo (dato-arbolb arbolb) #t)
                 (junta-hijos (list (pinta-arbolb (hijo-izq-arbolb arbolb))
                                    (pinta-arbolb arbolb-vacio)))))
    (else (enlaza-raiz (pinta-nodo (dato-arbolb arbolb) #t)
                       (junta-hijos (list (pinta-arbolb (hijo-izq-arbolb arbolb))
                                          (pinta-arbolb (hijo-der-arbolb arbolb))))))))

(define (enlaza-uno izq imagen pareja)   ; En pareja se espera lo mismo que en enlaza-raiz.
  (overlay/align "center" "top" imagen   ; iqz: #t enlaza a iquierda y #f enlaza a derecha.
                 (add-line (above (rectangle (image-width (car pareja))
                                          (+ (image-height imagen) t-espacio)
                                          "solid"
                                          "transparent")
                                  (car pareja))
                           (/ (image-width (car pareja)) 2)
                           (+ (/ (image-height imagen) 2) t-espacio)
                           ((if izq car cadr) (cdr pareja))
                           (+ (image-height imagen) t-espacio)
                           "black")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pintar lista estructurada ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (pinta-lista lista)
  (if (hoja? lista)
      (pinta-nodo lista #f)
      (enlaza-raiz (pinta-nodo "*" #f)
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

(define exists? ormap)
(define for-all? andmap)


;; ----------------------------------
;; Dibujo de diagramas caja y puntero
;; ----------------------------------

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


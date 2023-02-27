
# Práctica 5: Funciones como datos de primera clase y funciones de orden superior

## Antes de la clase de prácticas ##

- Antes de empezar esta práctica es importante que revises la solución
  de la práctica 4. Puedes preguntar las dudas al profesor de prácticas.

- Los siguientes ejercicios están basados en los conceptos de teoría
vistos la semana pasada. Antes de la clase de prácticas debes repasar
todos los conceptos y **probar en el DrRacket** todos los ejemplos de
los siguientes apartados del tema 2 [_Programación
Funcional_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#54-generalizacion):

    - 5.4. Generalización. 
    - 5.5. Funciones que devuelven otras funciones. 
    - 5.6. Funciones en estructuras de datos. 
    - 5.7. Funciones de orden superior.

## Ejercicios

Descarga el [fichero `lpp.rkt`](https://raw.githubusercontent.com/domingogallardo/apuntes-lpp/master/src/lpp.rkt),
pulsando el botón derecho del ratón y seleccionando la opción _Guardar
como_ `lpp.rkt`. Guárdalo en la misma carpeta en la que tengas el
fichero `practica5.rkt`.

El fichero contiene la definición de las funciones de orden superior `exists?` y `for-all?`.



### Ejercicio 1 ###

a) Define la función `(aplica-veces f1 f2 n x)` que aplica `n` veces
las funciones `f2` y `f1` al número `x`. 

Por ejemplo, `(aplica-veces doble suma-2 3 5)` deberá devolver el
resultado de sumarle 2 a 5 (7), después calcular el doble (14),
después sumarle otra vez 2 al resultado (16), volver a calcular su
doble (32) y, por último, sumarle 2 al resultado (34) y calcular su
doble. Esto es, aplica 3 veces las funciones `suma-2` y `doble`
tomando como número inicial el 5. El resultado será 68.

Ejemplos:

```racket
(aplica-veces (lambda (x) (+ x 1)) (lambda (x) (+ x 2)) 2 10) ; ⇒ 16
(aplica-veces (lambda (x) (* x x)) (lambda (x) (+ x 1)) 4 3) ; ⇒ 7072978201
```

b) Implementa la función recursiva `(mueve-al-principio-condicion pred
lista)` que recibe un predicado y una lista. La función es una
generalización de la función de la práctica anterior y debe devolver
la lista resultante de mover la primera aparición del dato que cumpla
el predicado al comienzo de la lista, dejando el resto de la lista sin
modificar.

A diferencia de la práctica anterior, en la lista puede no haber
ningún elemento que cumpla el predicado. En ese caso se devolverá la
lista original.


Ejemplos:

```racket
(mueve-al-principio-condicion number? '(a b c 1 d 1 e) ; ⇒ (1 a b c d 1 e)
(mueve-al-principio-condicion number? '(1 a b 1 c)) ; ⇒ (1 a b 1 c)
(mueve-al-principio-condicion number? '(a b c d)) ; ⇒ '(a b c d)
```

!!! Hint "Pista"
    El hecho de que se permita que no haya ningún elemento que cumpla
    el predicado obliga a cambiar bastante la solución de la práctica
    anterior. 
    
    Fíjate por ejemplo en la función `(inserta-en-segunda-posicion
    dato lista)` de la solución. En el caso en que no haya en la lista
    ningún elemento que cumpla la condición esta función deberá
    **añadir en cabeza** el dato, en lugar de insertarlo en segunda
    posición. De hecho, podríamos cambiar el nombre de la función
    auxiliar y llamarla `inserta-segundo-cond` o algo así.


c) Vamos a generalizar la función de la práctica anterior
`(comprueba-simbolos)` llamándola `(comprueba pred lista1
lista2)` y pasándole como parámetro un predicado de comparación. La
función ahora podrá procesar cualquier tipo de listas (de símbolos, de
cadenas, de listas, etc.). La función pasada como parámetro se encarga
de comparar si el elemento de la primera lista cumple la condición con el
elemento de la segunda.

Implementa la función `(comprueba pred lista1 lista2)`.

Ejemplo:

```racket
(comprueba (lambda (x y)
             (= (string-length (symbol->string x)) y))
           '(este es un ejercicio de examen) 
           '(2 1 2 9 1 6))
; ⇒ ((un . 2) (ejercicio . 9) (examen . 6))

(comprueba (lambda (x y)
              (= (string-length x) (string-length y)))
             '("aui" "a" "ae" "c" "aeiou")
             '("hola" "b" "es" "que" "cinco"))
; ⇒ (("a" . "b") ("ae" . "es") ("aeiou" . "cinco"))
```


### Ejercicio 2 ###

Queremos ordenar de menor a mayor una lista que contenga cualquier
tipo de elemento, no solo números. Para ello vamos a generalizar el
ejercicio 2 de la práctica anterior, añadiendo un parámetro funcional,
un predicado `(menor-igual? dato1 dato2)` que nos dice si el dato1 es
menor o igual que el dato 2.

a) Generaliza las funciones `inserta-ordenada` y `ordena` añadiéndoles
el parámetro adicional `menor-igual?` que es una función predicado que
comprueba si un dato de los que componen la lista es menor o igual que
otro. Llama a las funciones resultantes `inserta-ordenada-genérica` y
`ordena-genérica`.


b) Escribe tres pruebas. En la primera deberás ordenar una lista de
cadenas por su longitud, en la segunda la lista de cadenas por su
orden lexicográfico y en la tercera deberás ordenar una lista de
parejas de números por la suma de su parte izquierda y su parte
derecha:

```racket
(check-equal? (ordena-generica '("Hola" "me" "llamo" "Iñigo" "Montoya") ...... ) '("me" "Hola" "llamo" "Iñigo" "Montoya"))
(check-equal? (ordena-generica '("Hola" "me" "llamo" "Iñigo" "Montoya") ....... ) '("Hola" "Iñigo" "Montoya" "llamo" "me"))
(check-equal? (ordena-generica '((2 . 2) (1 . 1) (3 . 0) (5 . 1)) ...... ) '((1 . 1) (3 . 0) (2 . 2) (5 . 1)))
```

c) Define la función `(ordena-cartas lista-cartas)` que ordene una
lista de cartas de menor a mayor valor usando la función anterior
`ordena-generica`. Deberás incluir la función `valor-carta` y sus
funciones auxiliares definidas en prácticas anteriores.


Ejemplo:

```racket
(ordena-cartas '(Q♠ J♣ 5♣ Q♥ J♦)) ; ⇒ '(5♣ J♣ J♦ Q♠ Q♥)
```

### Ejercicio 3 ###

a) Indica qué devuelven las siguientes expresiones, sin utilizar el
intérprete. Comprueba después si has acertado.

```racket
(map (lambda (x)
         (cond 
            ((symbol? x) (symbol->string x))
            ((number? x) (number->string x))
            ((boolean? x) (if x "#t" "#f"))
            (else "desconocido"))) '(1 #t hola #f (1 . 2))) ; ⇒ ?
         
(filter (lambda (x) 
            (equal? (string-ref (symbol->string x) 1) #\a)) 
    '(alicante barcelona madrid almería)) ; ⇒ ?

(foldr (lambda (dato resultado)
          (string-append dato "*" resultado)) "" 
          '("Hola" "que" "tal")) ; ⇒ ?

(foldr append '() '((1 2) (3 4 5) (6 7) (8))) ; ⇒ ?

(foldl (lambda (dato resultado)
         (string-append
          (symbol->string (car dato))
          (symbol->string (cdr dato))
          resultado)) "" '((a . b) (hola . adios) (una . pareja))) ; ⇒ ?

(foldr (lambda (dato resultado)
           (cons (+ (car resultado) dato)
                 (+ (cdr resultado) 1))) '(0 . 0) '(1 1 2 2 3 3)) ; ⇒ ?

(apply + (map cdr '((1 . 3) (2 . 8) (2 . 4)))) ; ⇒ ?

(apply min (map car (filter (lambda (p)
                                  (> (car p) (cdr p))) 
                                  '((3 . 1) (1 . 20) (5 . 2))))) ; ⇒ ?
```

b) Sin utilizar el intérprete DrRacket, rellena los siguientes huecos
para obtener el resultado esperado. Después usa el intérprete para
comprobar si has acertado.


```racket 

; Los siguientes ejercicios utilizan esta definición de lista

(define lista '((2 . 7) (3 . 5) (10 . 4) (5 . 5)))


; Queremos obtener una lista donde cada número es la suma de las
; parejas que son pares

(filter ________
        (________ (lambda (x) (+ (car x)
                                 (cdr x)))
               lista))
; ⇒ (8 14 10)

; Queremos obtener una lista de parejas invertidas donde la "nueva"
; parte izquierda es mayor que la derecha.

(filter ___________
        (map ____________ lista))
; ⇒ ((7 . 2) (5 . 3))

; Queremos obtener una lista cuyos elementos son las partes izquierda
; de aquellas parejas cuya suma sea par.

(foldr __________ '()
        (_________ (lambda (x) (even? (+ (car x) (cdr x)))) lista))
; ⇒ (3 10 5)
```

c) Rellena los siguientes huecos **con una única expresión** en la que
se utilice alguna función previamente definida (`f` o `g`). Comprueba
con el intérprete si lo has hecho correctamente.


```racket
(define (f1 x) (lambda (y z) (string-append y z x)))
(define g1 (f "a"))
(check-equal? ____________________ "claselppa")



(define (f2 x) (lambda (y z) (list y x z)))
_____________
(check-equal? (g2 "hola" "clase") (list "hola" "lpp" "clase"))


(define (f3 g3) (lambda(z x) (g z x)))
(check-equal? _____________________  '(3 . 4))
```

### Ejercicio 4 ###

a) Implementa utilizando funciones de orden superior la función
`(contar-datos-iguales-fos lista-parejas)` que recibe una lista de
parejas y devuelve el número de parejas que tienen sus dos datos
iguales.

```racket
(contar-datos-iguales-fos 
   '((2 . 3) ("hola" . "hola") (\#a . \#a) (true . false))) 
; ⇒ 2
(contar-datos-iguales-fos 
   '((2 . "hola") ("hola" . 3) (\#a . true) (\#b . false))) 
; ⇒ 0
```

b) Implementa, utilizando funciones de orden superior, la función
`(expande-lista-fos lista-parejas)`, que hace lo mismo que la función
`(expande-lista lista-parejas)` de la práctica anterior. Igual que en
la práctica anterior debes usar la función `expande-pareja`.

```
(expande-lista-fos '((#t . 3) ("LPP" . 2) (b . 4))) 
; ⇒ '(#t #t #t "LPP" "LPP" b b b b))
```

c) Implementa, utilizando funciones de orden superior, la función
`(comprueba-simbolos-fos lista-simbolos lista-num)` que hace lo mismo
que la función `comprueba-simbolos` del ejercicio 6a) de la práctica
pasada.

Ejemplo:

```
(comprueba-simbolos-fos '(este es un ejercicio de examen) '(2 1 2 9 1 6))
; ⇒ ((un . 2) (ejercicio . 9) (examen . 6))
```

### Ejercicio 5 ###

a) Implementa usando funciones de orden superior la función `(suma-n-izq n
lista-parejas)` que recibe una lista de parejas y devuelve otra lista
a la que hemos sumado `n` a todas las partes izquierdas.

Ejemplo

```racket
(suma-n-izq 10 '((1 . 3) (0 . 9) (5 . 8) (4 . 1)))
; ⇒ ((11 . 3) (10 . 9) (15 . 8) (14 . 1))
```


b) Implementa usando funciones de orden superior la función `(aplica-2 func
lista-parejas)` que recibe una función de dos argumentos y una lista
de parejas y devuelve una lista con el resultado de aplicar esa
función a los elementos izquierdo y derecho de cada pareja.

Ejemplo:

```racket
(aplica-2 + '((2 . 3) (1 . -1) (5 . 4)))
; ⇒ (5 0 9)
(aplica-2 (lambda (x y)
             (if (even? x)
                 y
                 (* y -1))) '((2 . 3) (1 . 3) (5 . 4) (8 . 10)))
; ⇒ (3 -3 -4 10)
```


### Ejercicio 6 ###

a) Completa la definición de la siguiente función de orden superior
`(busca-mayor mayor? lista)` que busca el mayor elemento de una
lista. Recibe un predicado `mayor?` que compara dos elementos de la
lista y devuelve `#t` o `#f` dependiendo de si el primero es mayor que
el segundo. 

Al usar un predicado como argumento, estamos definiendo una función
genérica que podemos usar para obtener el mayor elemento de listas de
números, de cadenas, de parejas, etc. En cada caso deberemos pasar
como parámetro `mayor?` la función de comparación apropiada.

```racket
(define (busca-mayor mayor? lista)
  (foldl __________ (first lista) (rest lista)))
```  


!!! Hint "Pista"
    Fíjate que como elemento base de `foldl` estamos usando el primer
    elemento de la lista y que el plegado lo hacemos sobre el resto de
    la lista.

Escribe algunos `check-equal?` en los que compruebes el funcionamiento
de `busca-mayor`, utilizando funciones `mayor?` distintas.

b) Implementa, usando el predicado de orden superior `for-all?` dos
versiones de la función `(todos-menores? lista n)` que recibe una
lista con sublistas de números y un número `n` y comprueba si todos
los números en las sublistas son menores que `n`.

La primera versión la debes implementar usando `for-all?` y la
función `busca-mayor` definida en el apartado anterior y la segunda
usando `for-all?` y la función de orden superior `exists?`.

Ejemplo:

```racket
(todos-menores? '((10 30 20) (1 50 30) (30 40 90)) 100) ; ⇒ #t
(todos-menores? '((10 30 20) (1 50 30) (30 40 90)) 90) ; ⇒ #f
(todos-menores? '((10 30 20) (1 50 30) (30 40 90)) 55) ; ⇒ #f
```

c) Define, usando funciones de orden superior, la función
`(cuenta-repetidas-fos cartas)` a la que le pasamos una lista de
cartas y cuenta el número de ocurrencias de los distintos valores de
las cartas. La función debe devolver una lista ordenada de parejas que
indican el número de veces que aparece cada valor. La parte izquierda
de cada pareja será el número de veces que aparece el valor y la parte
derecha el propio valor.

Por ejemplo en la lista de cartas `(J♦ Q♠ 2♦ 5♣ J♣ 2♣ Q♥)` aparecen 2
doses, 1 cinco, 2 dieces y 2 onces. La función debe devolver entonces
la lista `((2 . 2) (1 . 5) (2 . 10) (2 .11))`.

```racket
(cuenta-repetidas-fos '(J♦ Q♠ 2♦ 5♣ J♣ 2♣ Q♥)) ; ⇒  ((2 . 2) (1 . 5) (2 . 10) (2 . 11))
```

!!! Hint "Pista"
    La función puede primero ordenar las cartas y después aplicar
    alguna función de orden superior que haga el trabajo de contar,
    procesando la lista de cartas ya ordenada. 

----

Lenguajes y Paradigmas de Programación, curso 2022-23  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

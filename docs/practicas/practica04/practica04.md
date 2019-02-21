# Práctica 4: Funciones como datos de primera clase y funciones de orden superior

## Entrega de la práctica

Para entregar la práctica debes subir a Moodle el fichero
`practica04.rkt` con una cabecera inicial con tu nombre y apellidos, y
las soluciones de cada ejercicio separadas por comentarios. Cada
solución debe incluir:

- La **definición de las funciones** que resuelven el ejercicio.
- Un conjunto de **pruebas** que comprueben su funcionamiento
  utilizando la librería `schemeunit`.
  

## Ejercicios

### Ejercicio 1 ###

a) Indica qué devuelven las siguientes expresiones, sin utilizar el
intérprete. Comprueba después si has acertado.

```scheme
(map (lambda (x)
         (cond 
            ((symbol? x) (symbol->string x))
            ((number? x) (number->string x))
            ((boolean? x) (if x "#t" "#f"))
            (else "desconocido"))) '(1 #t hola #f (1 . 2))) ; ⇒ ?
         
(filter (lambda (x) 
            (equal? (string-ref (symbol->string x) 1) #\a)) '(alicante barcelona madrid almería)) ; ⇒ ?

(fold-right (lambda (dato resultado) (cons dato resultado)) '() '(1 2 3 4 5)) ; ⇒ ?

(fold-left (lambda (resultado dato) (cons dato resultado)) '() '(1 2 3 4 5)) ; ⇒ ?
```

b) Sin utilizar el intérprete DrRacket, rellena los siguientes huecos
para obtener el resultado esperado. Después usa el intérprete para
comprobar si has acertado.


```scheme 
(______ list 0 '(1 2 3))
; ⇒ {1 {2 {3 0}}}

(______ list "hola" '("como" "estas" "adios"))
; ⇒ {{{"hola" "como"} "estas"} "adios"}


; Los siguientes ejercicios se realizan con esta
; definición de lista

(define lista '((2 . 7) (3 . 5) (10 . 4) (5 . 5)))


; Queremos obtener una lista donde cada número es la suma de las
; parejas que son pares

(filter ________
        (________ (lambda (x) (+ (car x)
                                 (cdr x)))
               lista))
; ⇒ {8 14 10}

; Queremos obtener una lista de parejas invertidas donde la "nueva"
; parte izquierda es mayor que la derecha.

(filter ___________
        (map ____________ lista))
; ⇒ {{7 . 2} {5 . 3}}

; Queremos obtener una lista cuyos elementos son las partes izquierda
; de aquellas parejas cuya suma sea par.

(fold-right __________ '()
        (_________ (lambda (x) (even? (+ (car x) (cdr x)))) lista))
; ⇒ {3 10 5}
```


### Ejercicio 2 ###

Implementa, utilizando funciones de orden superior, las funciones
`longitud-impar`, `suma-longitudes` y `mayusculas` que reciben una
lista de símbolos y devuelven:

- `(longitud-impar lista-simbolos)`: una lista con aquellos símbolos
  que tienen longitud impar.
- `(suma-longitudes lista-simbolos)`: la suma de las longitudes
  de todos los símbolos de la lista.
- `(mayusculas lista-simbolos)`: una lista con los símbolos escritos
  en mayúscula.

!!!Hint "Pista" 
    Puedes usar las funciones `symbol->string`, `string->symbol` y
    `string-upcase`.

Ejemplos:

```scheme
(define lista '(me gusta LPP porque aprendo nuevos paradigmas de programación)
(longitud-impar lista) ; ⇒ {gusta LPP aprendo}
(suma-longitudes lista) ; ⇒ 53
(mayusculas lista)
; ⇒ {ME GUSTA LPP PORQUE APRENDO NUEVOS PARADIGMAS DE PROGRAMACIÓN}
```


### Ejercicio 3 ###

a) Implementa **utilizando funciones de orden superior** las funciones
`(cartas lista-simbolos)` y `(cuenta-cartas n lista-parejas)` de la
práctica 3.

b) Implementa la función `(posicion dato lista)` que devuelva la
posición de un dato en una lista o `#f` si el dato no está en la
lista. Puedes usar funciones auxiliares y funciones de orden
superior **pero no recursión**.

Ejemplos:

```scheme
(posicion 'c '(a b c d)) ; ⇒ 2
(posicion 10 '(1 2 3 4 5)) ; ⇒ #f
```

### Ejercicio 4 ###


a) Implementa usando funciones de orden superior la función `(suma-n-izq n
lista-parejas)` que recibe una lista de parejas y devuelve otra lista
a la que hemos sumado `n` a todas las partes izquierdas.

Ejemplo

```scheme
(suma-n-izq 10 '((1 . 3) (0 . 9) (5 . 8) (4 . 1)))
; ⇒ {{11 . 3} {10 . 9} {15 . 8} {14 . 1}}
```


b) Implementa usando funciones de orden superior la función `(aplica-2 func
lista-parejas)` que recibe una función de dos argumentos y una lista
de parejas y devuelve una lista con el resultado de aplicar esa
función a los elementos izquierdo y derecho de cada pareja.

Ejemplo:

```scheme
(aplica-2 + '((2 . 3) (1 . -1) (5 . 4)))
; ⇒ {5 0 9}
(aplica-2 (lambda (x y)
             (if (even? x)
                 y
                 (* y -1))) '((2 . 3) (1 . 3) (5 . 4) (8 . 10)))
; ⇒ {3 -3 -4 10}
```


### Ejercicio 5 ###

a) Implementa las **funciones constructoras** `(construye-multiplicador k)` y
`(construye-exponenciador k)` similares al ejemplo visto en teoría
`(construye-sumador k)`.

La función `construye-multiplicador` construye una función multiplicadora
por `k`. Y la función `construye-exponenciador` construye una función de un
argumento `x` que eleva `k` a `x`.


Ejemplo:

```scheme
(define multiplica-por-10 (construye-multiplicador 10))
(multiplica-por-10 3) ; ⇒ 30
(define multiplica-por-5 (construye-multiplicador 5))
(multiplica-por-5 3) ; ⇒ 15
(define elevado-2-a (construye-exponenciador 2))
(elevado-2-a 3) ; ⇒ 8
(define elevado-5-a (construye-exponenciador 5))
(elevado-5-a 3) ; ⇒ 125
```

b) Queremos definir una función constructora que obtenga una **función
segura** a partir de otra función, como en el ejemplo de teoría. Pero
en este caso queremos que la función a convertir en segura sea una
función de dos argumentos.

Define la función `(construye-segura-2 f p)` que recibe una
función `f` de dos argumentos y un predicado `p` también de dos
argumentos y que devuelva una versión segura de la función en la que
antes de invocarla se debe comprobar si los argumentos cumplen el
predicado.

Pruébala con las funciones `es-prefijo?` de la práctica anterior,
`append` y alguna otra función que se te ocurra. Para que la prueba
funcione correctamente deberás completar también la expresión lambda.

Ejemplos de uso:

```scheme
(define es-prefijo-segura? (construye-segura-2 (lambda (x y) _________) es-prefijo?))
(define append-segura (construye-segura-2 (lambda (x y) _______) append))

(es-prefijo-segura? "pre" "prefijo") ; ⇒ #t
(es-prefijo-segura? "pre" "p") ; ⇒ 'error
(append-segura '(1 2 3) '(4 5)) ; ⇒ '(1 2 3 4 5)
(append-segura '(1 2 3) 4) ; ⇒ 'error
```


### Ejercicio 6 ###

a) Utilizando una **composición de las funciones de orden superior
`fold-right` y `map`**, implementa la función `(cadena-mayor lista)` que
recibe un lista de cadenas y devuelve una pareja con la cadena de
mayor longitud y dicha longitud.  En el caso de que haya más de una
cadena con la máxima longitud, se devolverá la última de ellas que
aparezca en la lista.

```scheme
(cadena-mayor '("vamos" "a" "obtener" "la" "cadena" "mayor")) ; ⇒  {"obtener" . 7}  
(cadena-mayor '("prueba" "con" "maximo" "igual")) ; ⇒ {"maximo" . 6} 
(cadena-mayor '("hola")) ; ⇒ {"hola" . 4} 
``` 

b) La función `map` de Scheme también puede mapear una función de dos
argumentos sobre dos listas. Por ejemplo:

```scheme
(map (lambda (x y)
         (+ x y)) '(1 2 3 4) '(4 4 4 4))
; ⇒ {5 6 7 8}
```

Implementa la función `(filtra-simbolos lista-simbolos lista-num)` de
de la práctica 3, usando **una composición de funciones en las que se
use `map`** como en el ejemplo anterior.


----

Lenguajes y Paradigmas de Programación, curso 2018-19  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

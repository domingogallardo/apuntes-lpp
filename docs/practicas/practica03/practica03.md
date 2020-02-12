
# Práctica 3: Funciones recursivas sobre listas

## Entrega de la práctica

Para entregar la práctica debes subir a Moodle el fichero
`practica03.rkt` con una cabecera inicial con tu nombre y apellidos, y
las soluciones de cada ejercicio separadas por comentarios. Cada
solución debe incluir:

- La **definición de las funciones** que resuelven el ejercicio.
- Un conjunto de **pruebas** que comprueben su funcionamiento
  utilizando el API `RackUnit`.

## Ejercicio 1

a) Implementa la función recursiva `(contiene-prefijo prefijo
lista-pal)` que recibe una cadena y una lista de palabras. Devuelve
una lista con los booleanos resultantes de comprobar si la cadena es
prefijo de cada una de las palabras de la lista.

Debes definir una función auxiliar `(es-prefijo? pal1 pal2)` que
compruebe si la palabra 1 es prefijo de la palabra 2.

!!! Hint "Pista"
    Puedes usar la función `(substring palabra inicio final)` que devuelve
    la subcadena de la `palabra` que va desde la posición `inicio` hasta
    la posición `final` (sin incluir).

Ejemplos:

```scheme
(es-prefijo? "ante" "anterior") ; ⇒ #t
(contiene-prefijo "ante" '("anterior" "antígona" "antena" "anatema")) ; ⇒ (#t #f #t #f)
```


b) Implementa la función recursiva `(inserta n lista-ordenada)` que recibe un
número y una lista ordenada de números y devuelve la lista resultante
de insertar el número `n` en la posición correspondiente de la lista.

Ejemplo:

```scheme
(inserta 10 '(-8 2 3 11 20)) ; ⇒ (-8 2 3 10 11 20)
```

Usando la función anterior `inserta` implementa la función recursiva
`(ordena lista)` que recibe una lista de números y devuelve una lista
ordenada.

Ejemplo:

```scheme
(ordena '(2 -1 100 4 -6)) ; ⇒ (-6 -1 2 4 100)
```


### Ejercicio 2 ###

Define la función recursiva `(calcular-lista lista)` que recibe una lista que
contiene símbolos (los operadores `+`,`-`,`*`,`/`) y parejas de números
(operandos), representando operaciones matemáticas. Se considera que
la lista siempre está bien formada, con sus elementos en este orden:
`(símbolo pareja símbolo pareja...)`. Tiene que devolver una lista con
los resultados de las operaciones.

Ejemplos:

```scheme
(calcular-lista '(+ (2 . 3) * (4 . 5))) ; ⇒ (5 20)
(calcular-lista '(/ (-6 . 2) - (4.5 . 0.5) + (2 . 3))) ; ⇒ (-3 4.0 5)
```


### Ejercicio 3 ###

a) Indica qué devuelven las siguientes expresiones en Scheme. Puede ser
que alguna expresión contenga algún error. Indícalo también en ese
caso y explica qué tipo de error. Hazlo sin el intérprete, y después
comprueba con el intérprete si tu respuesta era correcta.


```scheme
((lambda (x) (* x x)) 3) ; ⇒ ?
((lambda () (+ 6 4))) ; ⇒ ?
((lambda (x y) (* x (+ 2 y))) (+ 2 3) 4) ; ⇒ ?
((lambda (x y) (* x (+ 2 x))) 5) ; ⇒ ?


(define f (lambda (a b) (string-append "***" a b "***")))
(define g f)
(procedure? g) ; ⇒ ?
(g "Hola" "Adios") ; ⇒ ?
```

b) Hemos visto en teoría que la forma especial `define` para construir
funciones es _azucar sintáctico_ y que el intérprete de Scheme la
convierte en una expresión equivalente usando la forma especial
`lambda`.

Escribe cuál sería las expresiones equivalentes, usando la forma
especial `lambda` a las siguientes definiciones de funciones:

```scheme
(define (suma-3 x)
   (+ x 3))
    
(define (factorial x)
   (if (= x 0)
      1
      (* x (factorial (- x 1)))))
```


c) Suponiendo las siguientes definiciones de funciones indica qué
devolverían las invocaciones. Puede ser que alguna expresión contenga
algún error. Indícalo también en ese caso y explica qué tipo de error.

Hazlo sin el intérprete, y después comprueba con el intérprete si tu
respuesta era correcta.


```scheme
(define (doble x)
   (* 2 x))
   
(define (foo f g x y)
   (f (g x) y))

(define (bar f p x y)
   (if (and (p x) (p y))
       (f x y)
       'error))
       
(foo + 10 doble 15) ; ⇒ ?
(foo doble + 10 15) ; ⇒ ?
(foo + doble 10 15) ; ⇒ ?
(foo string-append (lambda (x) (string-append "***" x)) "Hola" "Adios") ; ⇒ ?

(bar doble number? 10 15) ; ⇒ ?
(bar string-append string? "Hola" "Adios") ; ⇒ ?
(bar + number? "Hola" 5) ; ⇒ ?
```


### Ejercicio 4 ###

Escribe la función `(expande pareja1 pareja2 ... pareja_n)` que recibe
un número variable de argumentos y devuelva una lista donde se hayan
"expandido" las parejas, añadiendo tantos elementos como el número que
indique cada pareja. 

La función `expande` deberá llamar a una función recursiva
`(expande-lista lista-parejas)` que trabaje sobre una lista de parejas.

!!! Hint "Pista"
    Puedes definir una función auxiliar `(expande-pareja pareja)` que
    recibe una pareja y devuelve la lista expandida resultante de expandir
    sólo esa pareja.

Ejemplo:

```scheme
(expande '(#t . 3) '("LPP" . 2) '(b . 4)) 
; ⇒ (#t #t #t "LPP" "LPP" b b b b)
```

### Ejercicio 5 ###

a) Implementa la función recursiva `(cartas lista-simbolos)` que
recibe una lista de símbolos que representan cartas y devuelve una
lista de parejas con el palo y el valor de cada una. Debes llamar a la
función `(carta simbolo)` definida en la práctica anterior.

```scheme
(cartas '(O3 B6 C2 OA)) ; ⇒ ((Oros . 9) (Bastos . 4) (Copas . 1) (Oros . 10))
```

b) Implementa la función recursiva `(cuenta-cartas valor
lista-parejas)` que recibe una lista de parejas que representan cartas
y devuelva el número de cartas con valor igual al que se pasa como
parámetro.

```scheme
(cuenta-cartas 9 '((Oros . 9) (Bastos . 4) (Copas . 1) (Oros . 10) (Copas . 9))) ; ⇒ 2
```


### Ejercicio 6 ###

a) Implementa la función recursiva `(resultados‐quiniela lista‐parejas)`
que devuelve una lista de 1, X, 2 a partir de una lista de parejas que
representa resultados de partidos de fútbol. El resultado es 1 cuando
el número izquierdo de la pareja es mayor que el derecho, un 2 cuando
es al revés, y una X cuando los dos números son iguales.

!!! Hint "Pista"
    Puedes definir una función `(resultado-partido partido)`
    que reciba una pareja y devuelva 1, X o 2.

```scheme
(resultados-quiniela '((1 . 2) (1 . 1) (0 . 2) (1 . 0) (0 . 0)))  ; ⇒ (2 X 2 1 X)
(resultados-quiniela '((2 . 2))) ; ⇒ (X)
(resultados-quiniela '((3 . 2) (1 . 0) (0 . 1)))  ; ⇒ (1 1 2)
```

b) Implementa la función recursiva `(cuenta-resultados resultado lista-resultados)`
donde `resultado` puede ser un uno, una equis o un dos y cuenta el
número de ese resultado en la lista de partidos.

Ejemplo:

```scheme
(cuenta-resultados 'X '((1 . 2) (1 . 1) (0 . 2) (1 . 0) (0 . 0))) ; ⇒ 2
(cuenta-resultados 1 '((1 . 2) (1 . 1) (0 . 2) (1 . 0) (0 . 0))) ; ⇒ 1
(cuenta-resultados 2 '((1 . 2) (1 . 1) (0 . 2) (1 . 0) (0 . 0))) ; ⇒ 2
```

c) Implementa la función recursiva `(cuenta-resultados-lista
lista-resultados)` que devuelva una lista de tres elementos que
representan el número de 1s, de Xs y de 2s existentes en la lista de
resultados original.

!!! Hint "Pista"
    Puedes definir una función auxiliar `(inc-pos n lista)` que
    incremente el número de la lista situado en la posición `n`.

```scheme
(cuenta-resultados-lista '((1 . 2) (1 . 1) (0 . 2) (1 . 0) (0 . 0))) ; ⇒ (1 2 2)
(cuenta-resultados-lista '((2 . 2))) ; ⇒ (0 1 0)
(cuenta-resultados-lista '((1 . 0) (2 . 0) (0 . 1)))  ; ⇒ (2 0 1)
```


### Ejercicio 7 ###

Implementa una función recursiva `(filtra-simbolos lista-simbolos
lista-num)` que recibe una lista de símbolos y una lista de números
enteros (ambas de la misma longitud) y devuelve una lista de
parejas. Cada pareja está formada por el símbolo de la i-ésima
posición de `lista-simbolos` y el número entero situado esa posición
de `lista-num`, siempre y cuando dicho número se corresponda con la
longitud de la cadena correspondiente al símbolo. Puedes utilizar las
funciones predefinidas `string-length` y `symbol->string`.

Ejemplo:

```scheme
(filtra-simbolos '(este es un ejercicio de examen) '(2 1 2 9 1 6))
; ⇒ ((un . 2) (ejercicio . 9) (examen . 6))
```



----

Lenguajes y Paradigmas de Programación, curso 2018-19  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

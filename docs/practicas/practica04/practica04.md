# Práctica 4: Funciones recursivas con listas

## Antes de la clase de prácticas ##

- Antes de empezar esta práctica es importante que revises la solución
  de la práctica 3. Puedes preguntar las dudas al profesor de prácticas.

- Los siguientes ejercicios están basados en los conceptos de teoría
vistos la semana pasada. Antes de la clase de prácticas debes repasar
todos los conceptos y **probar en el DrRacket** todos los ejemplos de
los siguientes apartados del tema 2 [_Programación
Funcional_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#43-funciones-recursivas-que-construyen-listas):

    - 4.3. _Funciones recursivas que construyen listas_
    - 4.4. _Funciones con número variable de argumentos_
    - 5 _Funciones como tipos de datos de primera clase_ (incluido hasta el
      apartado 5.3. _Función apply_)


## Ejercicios


### Ejercicio 1 ###

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

```racket
(es-prefijo? "ante" "anterior") ; ⇒ #t
(contiene-prefijo "ante" '("anterior" "antígona" "antena" "anatema")) 
; ⇒ (#t #f #t #f)
```

b) Vamos a generalizar la solución del ejercicio 4 de la práctica 2 e
implementar la función recursiva `(cadenas-mayores lista1 lista2)`
teniendo en cuenta que las listas que recibe tienen un número
indeterminado de cadenas. En el caso en que una de las listas sea
mayor que la otra, se deberán añadir todas sus cadenas a la lista
resultante.

Ejemplos:

```racket
(cadenas-mayores '("hola" "que" "tal") '("adios")) 
; ⇒ ("adios" "que" "tal")
(cadenas-mayores '("hola" "que" "tal") '("meme" "y" "adios"))
; ⇒ ("hola" "que" "adios")
(cadenas-mayores '("la" "primera" "práctica" "de" "recursión")
                 '("confiar" "en" "la" "recursión" "facilita" "su" "resolución"))
; ⇒ ("confiar" "primera" "práctica" "recursión" "recursión" "su" "resolución")
```

### Ejercicio 2 ###


a) Implementa la función recursiva `(inserta-pos dato pos lista)` que
recibe un dato, una posición y una lista e inserta el dato en la
posición indicada de la lista. Si la posición es 0, el dato se inserta
en cabeza. Suponemos que la posición siempre será positiva y menor o
igual que la longitud de la lista.

Ejemplos:

```racket
(inserta-pos 'b 2 '(a a a a)) ; ⇒ '(a a b a a)
(inserta-pos 'b 0 '(a a a a)) ; ⇒ '(b a a a a)
```

b) Implementa la función recursiva `(inserta-ordenada n
lista-ordenada)` que recibe un número y una lista de números ordenados
de menor a mayor y devuelve la lista resultante de insertar el número
`n` en la posición correcta para que la lista siga estando ordenada.

Ejemplo:

```racket
(inserta-ordenada 10 '(-8 2 3 11 20)) ; ⇒ (-8 2 3 10 11 20)
```

c) Usando la función anterior `inserta-ordenada` implementa la función recursiva
`(ordena lista)` que recibe una lista de números y devuelve una lista
ordenada.

Ejemplo:

```racket
(ordena '(2 -1 100 4 -6)) ; ⇒ (-6 -1 2 4 100)
```

### Ejercicio 3 ###

a) Implementa la función recursiva `(mueve-al-principio lista dato)` que recibe una lista y un 
dato que está contenido en la lista. La función debe devolver la lista resultante de
mover la primera aparición del dato al comienzo de la lista, dejando el resto de la lista
sin modificar. Suponemos que el dato que se pasa como parámetro está contenido en la lista.

Ejemplo:

```racket
(mueve-al-principio '(a b e c d e f) 'e) ; ⇒ (e a b c d e f)
(mueve-al-principio '(a b c d e f g) 'a) ; ⇒ (a b c d e f g))
```

b) Implementa una función recursiva `(comprueba-simbolos lista-simbolos
lista-num)` que recibe una lista de símbolos y una lista de números
enteros (ambas de la misma longitud) y devuelve una lista de
parejas. Cada pareja está formada por el símbolo de la i-ésima
posición de `lista-simbolos` y el número entero situado esa posición
de `lista-num`, siempre y cuando dicho número se corresponda con la
longitud de la cadena correspondiente al símbolo. Puedes utilizar las
funciones predefinidas `string-length` y `symbol->string`.

Ejemplo:

```racket
(comprueba-simbolos '(este es un ejercicio de examen) '(2 1 2 9 1 6))
; ⇒ ((un . 2) (ejercicio . 9) (examen . 6))
```



### Ejercicio 4 ###

Vamos a implementar distintas versiones de funciones que expanden
una lista original. 

En el primer apartado definiremos una función auxiliar que se deberá
usar en todos los demás apartados.

a) Escribe la función recursiva `(expande-pareja pareja)` que recibe
una pareja formada por un dato y un número _n_ y devuelve la lista
formada por _n_ repeticiones del dato.

Ejemplo:

```racket
(expande-pareja '(hola . 3)) ; ⇒ (hola hola hola)
(expande-pareja '(#t . 5)) ; ⇒ (#t #t #t #t #t)
```

b) Vamos a implementar dos versiones de la función `(expande-parejas
pareja1 ... pareja_n)` que recibe un número variable de
argumentos y devuelve una lista donde se han "expandido" las parejas,
creando una lista con tantos elementos como el número que indique cada
pareja. Todos los argumentos son opcionales; si no hay argumentos se
devolverá la lista vacía.

Ejemplo:

```racket
(expande-parejas '(#t . 3) '("LPP" . 2) '(b . 4)) 
; ⇒ (#t #t #t "LPP" "LPP" b b b b)
```

b.1) Escribe una solución en la que la función `expande-parejas`
llame a una función recursiva `(expande-lista lista-parejas)`
que trabaje sobre una lista de parejas.

b.2) Escribe una solución en la que la propia función
`expande-parejas` sea recursiva. 

!!! Hint "Pista"
    Repasa el apartado 5.3.1 de teoría.

c) Implementa la función recursiva `(expande2 lista)`. Recibe una
lista en la que hay intercalados algunos números enteros
positivos. Devuelve la lista original en la que se han expandido los
elementos siguientes a los números, tantas veces como indica el
número. La lista nunca va a contener dos números consecutivos y
siempre va a haber un elemento después de un número.

Debes usar también para su implementación la función `(expande-pareja
pareja)` definida en el apartado a).

Ejemplo:

```racket
(expande2 '(4 clase ua 3 lpp aulario)) 
; ⇒ (clase clase clase clase ua lpp lpp lpp aulario))
```

En el ejemplo, el 4 indica que el siguiente elemento
(`clase`) se debe repetir 4 veces en la lista expandida y el 3 indica
que el siguiente elemento (`lpp`) se va a repetir 3 veces.

Como en los anteriores ejercicios, te recomendamos implementar alguna
función auxiliar.


### Ejercicio 5 ###

Truco de cartas.

### Ejercicio 6 ###

a) Indica qué devuelven las siguientes expresiones en Scheme. Puede ser
que alguna expresión contenga algún error. Indícalo también en ese
caso y explica qué tipo de error. Hazlo sin el intérprete, y después
comprueba con el intérprete si tu respuesta era correcta.


```racket
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

```racket
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


```racket
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

## Entrega de la práctica

Sube la solución de los ejercicios al cuestionario de Moodle Entrega
práctica 4 hasta el domingo 27 de febrero a las 21:00 h.

Tal y como hemos comentado al comienzo de la práctica, debes incluir
casos de prueba en todo el código que escribas.

Una vez finalizado el plazo de entrega podrás revisar el cuestionario
y visualizar la solución. Corrige la entrega, comparando la solución
con la tuya. Puedes consultar cualquier duda con tu profesor en la
clase de prácticas de la semana que viene.

----

Lenguajes y Paradigmas de Programación, curso 2021-22  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

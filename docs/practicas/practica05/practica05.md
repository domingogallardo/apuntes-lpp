
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

a) Define la función recursiva `(aplica-veces f1 f2 n x)` que aplica
`n` veces las funciones `f2` y `f1` al número `x`. 

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
(mueve-al-principio-condicion number? '(a b c d)) ; ⇒ (a b c d)
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
ejercicio 2 de la práctica anterior, añadiendo un parámetro adicional (un predicado),
al que llamaremos `menor-igual?`.

a) Generaliza las funciones `inserta-ordenada` y `ordena` añadiéndoles
este parámetro adicional que es un predicado que
comprueba si un dato de los que componen la lista es menor o igual que
otro. Llama a las funciones resultantes `inserta-ordenada-genérica` y
`ordena-genérica`.

```racket
(ordena-generica '(3 5 1) <=) ;=> (1 3 5)
```

b) Completa las siguientes tres pruebas. En la primera deberás ordenar una lista de
cadenas por su longitud, en la segunda la lista de cadenas por su
orden lexicográfico y en la tercera deberás ordenar una lista de
parejas de números por la suma de su parte izquierda y su parte
derecha:

```racket
(check-equal? (ordena-generica '("Hola" "me" "llamo" "Iñigo" "Montoya") ________ ) '("me" "Hola" "llamo" "Iñigo" "Montoya"))
(check-equal? (ordena-generica '("Hola" "me" "llamo" "Iñigo" "Montoya") ________ ) '("Hola" "Iñigo" "Montoya" "llamo" "me"))
(check-equal? (ordena-generica '((2 . 2) (1 . 1) (3 . 0) (5 . 1)) ________ ) '((1 . 1) (3 . 0) (2 . 2) (5 . 1)))
```

c) Define la función `(ordena-cartas lista-cartas)` que ordene una
lista de cartas de menor a mayor valor usando la función anterior
`ordena-generica`. Deberás incluir la función `valor-carta` y sus
funciones auxiliares definidas en prácticas anteriores.


Ejemplo:

```racket
(ordena-cartas '(Q♠ J♣ 5♣ Q♥ J♦)) ; ⇒ (5♣ J♣ J♦ Q♠ Q♥)
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
(define g1 (f1 "a"))
(check-equal? ____________________ "claselppa")



(define (f2 x) (lambda (y z) (list y x z)))
_____________
(check-equal? (g2 "hola" "clase") (list "hola" "lpp" "clase"))


(define (f3 g3) (lambda(z x) (g3 z x)))
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
; ⇒ (#t #t #t "LPP" "LPP" b b b b))
```

c) Implementa, utilizando funciones de orden superior, la función
`(comprueba-simbolos-fos lista-simbolos lista-num)` que hace lo mismo
que la función `comprueba-simbolos` del ejercicio 3b) de la práctica
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

b) Completa la definición de la siguiente función de orden superior
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

c) Implementa, usando el predicado de orden superior `for-all?` dos
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

### Ejercicio 6

Vamos a mejorar el juego de cartas de la semana anterior, usando la baraja
completa y dando más libertad al reparto de cartas en montones, haciendo más
inverosímil todavía la adivinación de la carta elegida.

Usamos la función `(cartas num-cartas)` del fichero `lpp.rkt` y la función
`(reparte-tres lista-cartas)` definida en la práctica anterior.

!!! Important "Usa funciones de orden superior"
    Para la implementación de las siguientes funciones deberás usar, siempre que sea
    posible, funciones de orden superior en lugar de funciones recursivas.

a) Define una nueva versión de la función `coloca` usando número variable de
argumentos. La nueva versión de la función `(coloca ...)` solo tiene como
obligatorio el primer argumento, la lista de n listas. El resto de argumentos es
opcional y puede ir de 0 a n elementos.

Se asume que la lista de n listas debe tener tantas listas como
elementos se pasen como argumentos, y si no se pasa ningún argumento
se devuelve por convenio la lista de n listas tal cual, sin variar.

Ejemplo:

```racket
(coloca '(() () ()) 'a 'b 'c)) ; ⇒ ((a) (b) (c))
(coloca '((a) (a)) 'b 'b)) ; ⇒ ((b a) (b a))
(coloca '((a b c d)) 'e) ; ⇒ ((e a b c d))
(coloca '()) ; ⇒ '()
(coloca '((a) (b c) (d e f) (g h i j)) 'k 'l 'm 'n)) ; ⇒ ((k a) (l b c) (m d e f) (n g h i j))
```

Implementa una función `reparte-cuatro` inspirada en `reparte-tres` y con idéntica estructura.

```racket
(reparte-cuatro '(A♣ 2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ J♣ Q♣ K♣)) ; ⇒ '((A♣ 5♣ 9♣) (2♣ 6♣ J♣) (3♣ 7♣ Q♣) (4♣ 8♣ K♣))
```

b) Implementa la función `(escoge-en-orden lista funcion_ordinal_1
... función_ordinal_n)` que aplica a un primer argumento obligatorio `lista`
la serie de funciones "ordinales" (`first`, `second`, `third` ... `tenth`)
pasadas a continuación de la lista como un número variable de argumentos,
devolviendo la lista de resultados de aplicar esas funciones en el
orden en que se han proporcionado.

```racket
(escoge-en-orden '(1 2 3 4 5)) ; ⇒  '()
(escoge-en-orden '(1 2 3 4 5) fourth second) ; ⇒ (4 2)
(escoge-en-orden '(a b c d) third second fourth first) ; ⇒ (c b d a)
(escoge-en-orden '(dos tres un) third first second) ; ⇒ (un dos tres)
```

Usando las funciones definidas anteriormente, implementa las funciones
`(reordena-tres-montones baraja f-ordinal1 f-ordinal2 f-ordinal3)` y
`(reordena-cuatro-montones baraja f-ordinal1 f-ordinal2 f-ordinal3 f-ordinal4)`
que reparten las cartas de una supuesta baraja (lista de cartas) en tres o
cuatro montones (lista de sublistas de cartas) y después reordena los montones,
o sublistas, según el orden establecido por las funciones "ordinales" pasadas
como argumentos a continuación de la baraja.

```racket
(reordena-tres-montones  '(A♣ 2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ J♣ Q♣ K♣) second first third)
; ⇒
; ((2♣ 5♣ 8♣ Q♣) (A♣ 4♣ 7♣ J♣) (3♣ 6♣ 9♣ K♣))
              
(reordena-cuatro-montones  '(A♣ 2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ J♣ Q♣ K♣) fourth second first third)
; ⇒
; ((4♣ 8♣ K♣) (2♣ 6♣ J♣) (A♣ 5♣ 9♣) (3♣ 7♣ Q♣))
```

c) Implementa la función `(junta-montones montones)` concatena la lista de sublistas
de cartas (montones) en una sola lista de cartas.

```racket
(junta-montones '((4♣ 8♣ K♣) (2♣ 6♣ J♣) (A♣ 5♣ 9♣) (3♣ 7♣ Q♣)))
; ⇒
; (4♣ 8♣ K♣ 2♣ 6♣ J♣ A♣ 5♣ 9♣ 3♣ 7♣ Q♣)
```

d) Una vez que has implementado las funciones anteriores ya solo te
queda copiar la siguiente definición para poder hacer el truco de
cartas. 

La función `(adivina lista-cartas par1 par2 par3)` es la que hace toda la magia
y calcula la posición de la carta escogida a partir de las posiciones de los
montones en los que ésta ha aparecido en tres reparticiones de la baraja.

```racket
(define (adivina baraja par1 par2 par3)
  (list-ref baraja
            (+ (* (- (car par3) 1) (cdr par2) (cdr par1))
               (* (- (car par2) 1) (cdr par1))
               (- (car par1) 1))))
```

Cada pareja codifica en su parte derecha el número de montones en los que se ha
repartido la baraja y en su parte izquierda el montón en el que el espectador ha
visto la carta. Por ejemplo, la pareja `(2 . 4)` representa que la baraja se ha
repartido en 4 montones y que la carta escogida está en el segundo montón.

Lo curioso de la función de adivinación es que funciona correctamente siempre
que se haya repartido la baraja dos veces en cuatro montones y una en tres (las
partes derechas de las tres parejas deben sumar 11).

Veamos un ejemplo de realización del juego, tal y como ya hicimos en la práctica
pasada.

La siguiente función, con la constante 90 como argumento, genera
siempre la secuencia aleatoria que permite seguir el ejemplo. Si se
cambia por otra constante, la secuencia también se reperirá siempre
aunque será otra. Tener siempre la misma secuencia aleatoria permite
poder depurar la programación trabajando siempre con el mismo ejemplo
aleatorio.

```racket
(random-seed 90)
```
Si en lugar de una constante se usa un valor variable, se obtiene una
secuencia aleatoria distinta cada vez que se ejecute el programa. 

Ejemplo:

```racket
(random-seed (modulo (current-milliseconds) (expt 2 31)))
```

1. Repartimos una lista de 48 cartas en cuatro montones. Pedimos a un espectador
   que nos diga en qué orden colocamos los montones, poniendo, por ejemplo,
   primero el primero, después el cuarto, después el segundo y después el tercero:

    ```racket
    (define t1 (reordena-cuatro-montones (cartas 48) first fourth second third))
    ```

2. Visualizamos los montones y pedimos al espectador que piense en una
carta sin decirla. Por ejemplo el as de tréboles. 

    ```racket
    t1 ; ⇒ ((K♦ 3♦ 6♠ 6♦ 3♥ K♣ 8♦ 5♦ 6♣ 8♥ 5♠ A♣)
       ;   (8♠ 8♣ 9♠ 7♠ 2♣ 7♣ K♥ Q♠ 7♥ Q♣ 9♦ J♥)
       ;   (4♠ 2♥ K♠ Q♥ 7♦ J♣ 9♣ 6♥ 2♠ 9♥ 4♣ A♥)
       ;   (5♣ 2♦ J♦ 4♥ A♠ 5♥ 3♠ J♠ A♦ 3♣ 4♦ Q♦))
    ```

3. Preguntamos al espectador en qué montón se encuentra la carta. Anotamos en la
parte izquierda de `p1` el montón en el que está (montón 1), y la parte derecha el
número de montones (4).

    ```racket
    (define p1 '(1 . 4))
    p1
    ```

4. Repetimos la operación con `t2`, pero ahora repartiendo en tres montones nada
más. Podemos pedir a otro espectador que nos diga el orden en el que se
colocan los montones. Por ejemplo, primero el segundo, después el tercero y
después el primero.

    ```racket
    (define t2 (reordena-tres-montones (junta-montones t1) second third first))
    ```

5. Visualizamos `t2` y determinamos la pareja según donde está el as de trébol:

    ```racket
    t2 ; ⇒ ((3♦ 3♥ 5♦ 5♠ 8♣ 2♣ Q♠ 9♦ 2♥ 7♦ 6♥ 4♣ 2♦ A♠ J♠ 4♦)
       ;    (6♠ K♣ 6♣ A♣ 9♠ 7♣ 7♥ J♥ K♠ J♣ 2♠ A♥ J♦ 5♥ A♦ Q♦)
       ;    (K♦ 6♦ 8♦ 8♥ 8♠ 7♠ K♥ Q♣ 4♠ Q♥ 9♣ 9♥ 5♣ 4♥ 3♠ 3♣))
       ;En este caso (2 . 3) (el montón 2 de 3)
    (define p2 '(2 . 3))
    p2
    ```

6. Repetimos una última vez el reparto y ordenación de montones, pero con 4. Hay
que hacer tres repartos, uno de 3 montones y los otros dos de 4, pero no
necesariamente en el orden en el que se ha hecho (4-3-4). Se podía haber hecho
primero el reparto en tres montones, o haberlo dejado para el final. 

    ```racket
    (define t3 (reordena-cuatro-montones (junta-montones t2) fourth second first third))
    ```
    
7. Visualizamos `t3` y definimos la pareja `p3` según el montón del as de trébol: 

    ```racket
    t3 ; ⇒ ((5♠ 9♦ 4♣ 4♦ A♣ J♥ A♥ Q♦ 8♥ Q♣ 9♥ 3♣)
       ;    (5♦ Q♠ 6♥ J♠ 6♣ 7♥ 2♠ A♦ 8♦ K♥ 9♣ 3♠)
       ;    (3♦ 8♣ 2♥ 2♦ 6♠ 9♠ K♠ J♦ K♦ 8♠ 4♠ 5♣)
       ;    (3♥ 2♣ 7♦ A♠ K♣ 7♣ J♣ 5♥ 6♦ 7♠ Q♥ 4♥))
       ;Esta vez es (1 . 4)
    (define p3 '(1 . 4))
    p3
    ```

8. Ya tenemos las tres parejas mágicas que nos adivian la carta:

    ```racket
    (adivina (junta-montones t3) p1 p2 p3) ; ⇒ A♣
    ```

----

Lenguajes y Paradigmas de Programación, curso 2024-25  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

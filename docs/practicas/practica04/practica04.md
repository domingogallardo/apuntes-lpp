# Práctica 4: Funciones recursivas que devuelven listas

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
recibe un dato, una posición y una lista y devuelve la lista
resultante de insertar el dato en la posición indicada de la lista. Si
la posición es 0, el dato se inserta en cabeza. Suponemos que la
posición siempre será positiva y menor o igual que la longitud de la
lista.

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
(mueve-al-principio '(a b c d e f g) 'a) ; ⇒ (a b c d e f g)
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
`expande-parejas` sea recursiva. Llámala `expande-parejas-2` y ten
cuidado de que la llamada recursiva sea también a la propia
`expande-parejas-2`.

!!! Hint "Pista"
    Repasa el apartado 5.3.1 de teoría.

c) Implementa la función recursiva `(expande lista)`. Recibe una
lista en la que hay intercalados algunos números enteros
positivos. Devuelve la lista original en la que se han expandido los
elementos siguientes a los números, tantas veces como indica el
número. La lista nunca va a contener dos números consecutivos y
siempre va a haber un elemento después de un número.

Debes usar también para su implementación la función `(expande-pareja
pareja)` definida en el apartado a).

Ejemplo:

```racket
(expande '(4 clase ua 3 lpp aulario)) 
; ⇒ (clase clase clase clase ua lpp lpp lpp aulario)
```

En el ejemplo, el 4 indica que el siguiente elemento
(`clase`) se debe repetir 4 veces en la lista expandida y el 3 indica
que el siguiente elemento (`lpp`) se va a repetir 3 veces.


### Ejercicio 5 ###

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

### Ejercicio 6 ###

Vamos a seguir jugando a las cartas con Scheme. Vas a tener que
implementar una serie de funciones auxiliares con las que vas a poder
hacer un truco de cartas al final del ejercicio.

Comienza por volver a descargar el [fichero
`lpp.rkt`](https://raw.githubusercontent.com/domingogallardo/apuntes-lpp/master/src/lpp.rkt). En
él hemos incluido una nueva función `(cartas n)` con las que
puedes generar una lista de _n_ cartas aleatorias de una baraja de hasta
48 cartas. Por ejemplo:

```racket
(cartas 10) ; ⇒ (9♣ 7♠ Q♠ 4♥ 8♠ 3♠ 7♦ A♠ A♥ K♠)
(cartas 5) ; ⇒ (7♣ 3♣ 6♣ 7♠ 5♣)
```

Como máximo puedes poner como parámetro 48 para generar aleatoriamente
las 48 cartas de una baraja francesa sin dieces.

!!! Note "La función `cartas` no cumple el paradigma funcional"
    La función `cartas` es una función que devuelve una lista
    aleatoria de cartas. No cumple el paradigma funcional porque
    devuelve valores distintos cuando se llama con los mismos
    parámetros.

a) Define una función `(coloca tres-listas un dos tres)` que recibe
una listas con tres listas y tres elementos y devuelva el resultado de
colocar los elementos en la cabeza de las tres listas.

Ejemplo:

```racket
(coloca '(() () ()) 'a 'b 'c) ; ⇒ '((a) (b) (c))
(coloca '((a) (a) (a)) 'b 'b 'b) ; ⇒ '((b a) (b a) (b a))
(coloca '((a) (b c) (d e f)) 'g 'h 'i) ; ⇒ '((g a) (h b c) (i d e f)))
```

b) Usando la función anterior como función auxiliar implementa una
función recursiva `(reparte-tres lista-cartas)` que recibe una lista de
cartas con un número de cartas múltiplo de 3 y devuelve el resultado
de repartir esas cartas una a una en tres montones. Las cartas en
las posiciones 0, 3, 6, etc. irán en un montón. Las cartas en las
posiciones 1, 4, 7, etc. irán en el segundo montón. Y las cartas en
las posiciones 2, 5, 8, etc. irán en el tercero.

El resultado será una lista con tres listas representando esos tres
montones de cartas.

Ejemplo:

```racket
(define doce-cartas '(A♣ 2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ J♣ Q♣ K♣))
(reparte-tres doce-cartas) ; ⇒ '((A♣ 4♣ 7♣ J♣) (2♣ 5♣ 8♣ Q♣) (3♣ 6♣ 9♣ K♣))
```

c) Implementa una función recursiva `(elemento-central lista)` que
reciba una lista con un número impar de elementos (mayor o igual que
uno) y devuelva su elemento central.

!!! Note "Pista"
    Supongamos que defines una función recursiva auxiliar
    `(quita-ultimo lista)` que devuelve una lista sin el último
    elemento.
    
    ¿Podrías usar esta función para pasarle un caso más sencillo a la
    llamada recursiva y que sea la llamada recursiva la que devuelva
    el elemento central? 
    

Ejemplo:

```racket
(elemento-central '(a b c d e f g)) ; ⇒ d
```

d) Una vez que has implementado las funciones anteriores ya solo te
queda copiar las siguientes definiciones para poder hacer el truco de
cartas. Son funciones que recomponen la baraja a partir de los tres
montones dependiendo de si la carta elegida está en el montón de la
izquierda, del centro o de la derecha.

Y la función `adivina` es la que devuelve la carta elegida en el truco.

```racket
(define (izquierda tres-listas)
  (append (third tres-listas)
          (first tres-listas)
          (second tres-listas)))

(define (centro tres-listas)
  (append (third tres-listas)
          (second tres-listas)
          (first tres-listas)))

(define (derecha tres-listas)
  (append (second tres-listas)
          (third tres-listas)
          (first tres-listas)))

(define (adivina lista)
  (elemento-central lista))
```

Por último, antes de empezar el truco, un par de consideraciones sobre
los programas con números aleatorios.

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

Y ahora ya podemos empezar el truco de cartas.

1. Repartimos una lista de cartas y las guardamos en la variable
`t1`. Podríamos jugar con 3, 9, 15, 21 o 27 cartas. Vamos a hacerlo
con 27:

    ```racket
    (define t1 (reparte (cartas 27)))
    ```

2. Visualizamos los montones y pedimos al espectador que piense en una
carta sin decirla. Por ejemplo el as de tréboles.

    ```racket
    t1 ; ⇒ ((J♣ 8♦ K♥ J♠ 2♠ 8♥ Q♣ 4♦ A♥) (5♥ 9♣ 5♦ Q♠ A♦ 9♥ 5♠ 9♦ Q♦) (7♣ 3♠ 6♥ 6♣ 7♥ 3♣ 4♣ A♣ J♥))
    ```

3. Preguntamos al espectador en qué montón está la carta
   pensada. Juntamos los montones usando la función correspondiente a
   lugar del montón (`izquierda`, `derecha` o `centro`). En este caso
   el as de tréboles está en el montón derecho, por lo que usamos la
   función `derecha`. Y volvemos a repartir en tres montones el mazo
   resultante. Los guardamos en la variable `t2`:
   
    ```racket
    (define t2 (reparte (derecha t1)))
    ```

4. Visualizamos de nuevo los montones y preguntamos dónde está la
   carta. En este caso se encuentra en el centro.
   
    ```racket
    t2 ; ⇒  ((5♥ Q♠ 5♠ 7♣ 6♣ 4♣ J♣ J♠ Q♣) (9♣ A♦ 9♦ 3♠ 7♥ A♣ 8♦ 2♠ 4♦) (5♦ 9♥ Q♦ 6♥ 3♣ J♥ K♥ 8♥ A♥))
    ```
   
    Juntamos usando la función `centro` y volvemos a repartir,
    guardando el resultado en la variable `t3`:
   
    ```racket
    (define t3 (reparte (centro t2)))
    ```
   
5. Visualizamos los montones:

    ```racket
    t3 ; ⇒  ((5♦ 6♥ K♥ 9♣ 3♠ 8♦ 5♥ 7♣ J♣) (9♥ 3♣ 8♥ A♦ 7♥ 2♠ Q♠ 6♣ J♠) (Q♦ J♥ A♥ 9♦ A♣ 4♦ 5♠ 4♣ Q♣))
    ```
    
    Y preguntamos dónde se encuentra la carta. En este caso el as de
    trébol se encuentra en el montón de la derecha. Volvemos a juntar
    los montones usando entonces la función `derecha` y ya podemos
    llamar a la función `adivina` con la baraja resultante. Esta
    función devolverá mágicamente la carta escogida:
    
    ```racket
    (adivina (derecha t3)) ; ⇒ A♣
    ```

----

Lenguajes y Paradigmas de Programación, curso 2023-24  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

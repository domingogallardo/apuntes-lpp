
# Práctica 2: Recursión, parejas y diagramas box-and-pointer

## Entrega de la práctica

Para entregar la práctica debes subir a Moodle el fichero
`practica02.rkt` con una cabecera inicial con tu nombre y apellidos, y
las soluciones de cada ejercicio separadas por comentarios. Cada
solución debe incluir:

- La **definición de las funciones** que resuelven el ejercicio.
- Un conjunto de **pruebas** que comprueben su funcionamiento
  utilizando la librería `schemeunit`. 

## Ejercicios


### Ejercicio 1 ###

a) Implementa la función recursiva `(mínimo lista)` que recibe una lista
con números como argumento y devuelve el mayor número de la
lista. Suponemos listas de 1 o más elementos.

Para la implementación debes usar la función `menor` definida en la
práctica anterior.

!!! Tip "Pista"

    Podemos expresar el caso general de la recursión de la
    siguiente forma:

    > El mínimo de los elementos de una lista es el mayor entre el
    > primer elemento de la lista y el mínimo del resto de la lista.

    Y el caso base:
    
    > El mínimo de una lista con un único número es ese número.
    
    
Ejemplos:

```scheme
(minimo '(1 8 6 4 3)) ; ⇒ 1
(minimo '(1 -1 3 -6 4)) ; ⇒ -6
```

b) Implementa la función recursiva `(concatena lista-chars)` que recibe
una lista de caracteres y devuelve la cadena resultante de
concatenarlos.

Ejemplos:

```scheme
(concatena '(#\H #\o #\l #\a)) ; ⇒ "Hola"
(concatena '(#\S #\c #\h #\e #\m #\e #\space #\m #\o #\l #\a))  ⇒ "Scheme mola"
```


### Ejercicio 2 ###

a) Dado el siguiente _box & pointer_, escribe las sentencias en Scheme
(usando el mínimo número de llamadas a `list` y `cons`) que definen a `p1`, `p2` y `p3`.

<img src="imagenes/box-and-pointer.png" width="400px"/>

b) Explica si `p1`, `p2` y `p3` son listas y cuántos elementos tienen
(en el caso en que lo sean).

c) Escribe las expresiones que:

   1. devuelve 3 utilizando `p3`
   2. devuelve 5 utilizando `p3` 

d) Dado el siguiente diagrama caja y punter, escribe las sentencias en
Scheme (usando llamadas a `list` y `cons`) que definen `p1`.

<img src="imagenes/box-and-pointer2.png" width="500px"/>

### Ejercicio 3 

a) Implementa la función `(binario-a-decimal lista-bits)` que reciba una lista de bits que representan
un número en binario (el primer elemento será el bit más significativo) y devuelva el número decimal
equivalente. 

!!! Hint "Pista"
    Puedes utilizar la función `length`.

```scheme
(binario-a-decimal '(1 1 1 1)) ; ⇒ 15
(binario-a-decimal '(1 1 0)) ; ⇒ 6
(binario-a-decimal '(1 0)) ; ⇒ 2
```

b) Implementa la función recursiva `(ordenada-decreciente? lista-nums)`
que recibe como argumento una lista de números y devuelve `#t` si los
números de la lista están ordenados de forma creciente o `#f` en
caso contrario. Suponemos listas de 1 o más elementos.

```scheme
(ordenada-decreciente? '(99 59 45 23 -1))  ; ⇒ #t
(ordenada-decreciente? '(12 50 -1 293 1000))  ; ⇒ #f
(ordenada-decreciente? '(3))  ; ⇒ #t
```


### Ejercicio 4 ###

Supongamos que queremos programar un juego de cartas. Lo primero que
debemos hacer es definir una forma de representar de las cartas y
funciones que trabajen con esa representación. En este ejercicio vamos
a implementar esas funciones.

Representaremos una carta por un símbolo con dos letras: la primera
indicará el palo de la carta y la segunda su número o figura.

Por ejemplo:

```scheme
(define tres-de-oros 'O3)
(define as-de-copas 'CA)
(define caballo-de-espadas 'EC)
(define rey-de-bastos 'BR)
```

Debemos definir la función `carta` que devuelve una pareja con el palo
de la carta (un símbolo) y el valor correspondiente a su orden en el
juego (una carta con mayor valor vencerá a otra con menor valor).

Por ejemplo:

```scheme
(carta 'CA) ; ⇒ {Copas . 10}
(carta 'O2) ; ⇒ {Oros . 1}
(carta 'BS) ; ⇒ {Bastos . 6} 
```

Para calcular el palo y el valor definimos las siguientes listas, que
dependen de la baraja y del juego.

```scheme
(define orden '(#\2 #\4 #\5 #\6 #\7 #\S #\C #\R #\3 #\A))
(define palos '((#\O . Oros) (#\C . Copas) (#\E . Espadas) (#\B . Bastos)))
```

La lista `orden` define el orden de las cartas, de menor a mayor. La
lista `palos` define una lista de parejas que asocia un carácter con
su correspondiente símbolo.

Estas dos listas nos permiten generalizar el juego de cartas. Si
cambiáramos de baraja sólo tendríamos que usar otro orden y otros
palos:

```scheme
;; Para baraja inglesa: (es un ejemplo, pero no se usa)
;; Picas #\♠   Corazones #\♥   Diamantes #\♦   Tréboles #\♣
;; Ace #\A     Jack #\J        Queen #\Q       King #\K      10 #\0
;;(define orden '(#\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\0 #\J #\Q #\K #\A))
;;(define palos '((#\♠ . Picas) (#\♥ . Corazones) (#\♦ . Diamantes) (#\♣ . Tréboles)))
```

Para realizar el ejercicio debes definir en primer lugar las funciones
recursivas `(obten-palo char lista-palos)` y `(valora char
lista-orden)` que devuelven el palo y el valor, dado un carácter y una
lista de palos y una lista de orden de cartas.

Deberán satisfacer, por ejemplo, las siguientes pruebas:

```scheme
(check-equal? (obten-palo #\O palos) 'Oros)
(check-equal? (obten-palo #\E palos) 'Espadas)
(check-equal? (valora #\3 orden) 9)
(check-equal? (valora #\S orden) 6)
```

Y una vez definidas las funciones anteriores, debes definir la función
`carta` que devuelve una pareja con el palo y el valor de una carta,
tal y como se muestra en los ejemplos del comienzo del ejercicio.

### Ejercicio 5 ###

a) Implementa las funciones `(suma-izq pareja n)` y `(suma-der pareja n)`
definidas de la siguiente forma:

- `(suma-izq pareja n)`: devuelve una nueva pareja con la parte izquierda
  incrementada en `n`.
- `(suma-der pareja n)`: devuelve una nueva pareja con la parte derecha
  incrementada en `n`.

Ejemplos:
```
(suma-izq (cons 10 20) 3)  ; ⇒ {13 . 20}
(suma-der (cons 10 20) 5)  ; ⇒ {10 . 25}
```

b) Implementa la función recursiva `(suma-impares-pares lista-num)`
que devuelva una pareja cuya parte izquierda sea la suma de los
números impares de la lista y la parte derecha la suma de los números
pares. Debes utilizar las funciones auxiliares definidas en el
apartado anterior. También puedes utilizar las funciones predefinidas
`even?` y `odd?`.

Ejemplos:

```scheme
(suma-impares-pares '(3 2 1 4 8 7 6 5)) ; ⇒ {16 . 20}
(suma-impares-pares '(3 1 5))           ; ⇒ {9 . 0}
```

### Ejercicio 6 ###

Implementa la función recursiva `(cadena-mayor lista)` que recibe un
lista de cadenas y devuelve una pareja con la cadena de mayor longitud
y dicha longitud.  En el caso de que haya más de una cadena con la
máxima longitud, se devolverá la última de ellas que aparezca en la
lista.

En el caso en que la lista sea vacía se devolverá la pareja con la
cadena vacía y un 0 (la longitud de la lista vacía).

**Pista**: puedes utilizar la función `string-length`

```scheme
(cadena-mayor '("vamos" "a" "obtener" "la" "cadena" "mayor")) ; ⇒  {"obtener" . 7}
(cadena-mayor '("prueba" "con" "maximo" "igual")) ; ⇒ {"maximo" . 6} 
(cadena-mayor '()) ; ⇒ {"" . 0} 
```


----

Lenguajes y Paradigmas de Programación, curso 2018-19  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

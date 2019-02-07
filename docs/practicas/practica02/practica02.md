
# Práctica 2: Programación funcional en Scheme

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

Implementa la función recursiva `(mínimo lista)` que recibe una lista
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

a) Implementa el predicado recursivo `(pertenece? elem lista)` que
reciba un dato y una lista y comprueba si el elemento pertenece a
la lista.

```scheme
(pertenece? 'a '(b c d e)) ; ⇒ #f
(pertenece? 10 '(1 20 10 40 10)) ; ⇒ #t
(pertenece? (cons 1 2) (list (cons 2 3) (cons 3 4) (cons 9 0))) ; ⇒ #f
```

b) Implementa el predicado recursivo `(repetidos? lista)` que recibe una lista y
devuelve `#t` si algún elemento está repetido en la lista, y `#f` en
caso contrario.

!!! Hint "Pista" 
    Puedes utilizar la función anterior `(pertenece? elem lista)`, que
    comprueba si un elemento está en la lista. 

```scheme
(repetidos? '(1 2 3 5 4 5 6)) ; ⇒ #t
(repetidos? '(adios hola que tal)) ; ⇒ #f
(repetidos? '(#t #f #t #t #t)) ; ⇒ #t
```


### Ejercicio 3 ###

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

### Ejercicio 4 

Implementa la función `(binario-a-decimal lista-bits)` que reciba una lista de bits que representan
un número en binario (el primer elemento será el bit más significativo) y devuelva el número decimal
equivalente. 

!!! Hint "Pista"
    Puedes utilizar la función `length`.

```scheme
(binario-a-decimal '(1 1 1 1)) ; ⇒ 15
(binario-a-decimal '(1 1 0)) ; ⇒ 6
(binario-a-decimal '(1 0)) ; ⇒ 2
```

### Ejercicio 5 ###

Implementa la función recursiva `(ordenada-decreciente? lista-nums)`
que recibe como argumento una lista de números y devuelve `#t` si los
números de la lista están ordenados de forma creciente o `#f` en
caso contrario. Suponemos listas de 1 o más elementos.

```scheme
(ordenada-decreciente? '(99 59 45 23 -1))  ; ⇒ #t
(ordenada-decreciente? '(12 50 -1 293 1000))  ; ⇒ #f
(ordenada-decreciente? '(3))  ; ⇒ #t
```


### Ejercicio 6 ###

a) Implementa las funciones `(inc-izq pareja)` y `(inc-der pareja)`
definidas de la siguiente forma:

- `(inc-izq pareja)`: devuelve una nueva pareja con la parte izquierda
  incrementada en 1.
- `(inc-der pareja)`: devuelve una nueva pareja con la parte derecha
  incrementada en 1.

Ejemplos:
```
(inc-izq (cons 10 20))  ; ⇒ {11 . 20}
(inc-der (cons 10 20))  ; ⇒ {10 . 21}
```

b) Implementa la función recursiva `(cuenta-impares-pares lista-num)`
que devuelva una pareja cuya parte izquierda sea la cantidad de
números impares de la lista y la parte derecha la cantidad de números
pares. Debes utilizar las funciones auxiliares definidas en el
apartado anterior. También puedes utilizar las funciones predefinidas
`even?` y `odd?`.

Ejemplos:

```scheme
(cuenta-impares-pares '(3 2 1 4 8 7 6 5)) ; ⇒ {4 . 4}
(cuenta-impares-pares '(3 1 5))           ; ⇒ {3 . 0}
```

### Ejercicio 7 ###

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

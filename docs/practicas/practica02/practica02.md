# Práctica 2: Programación funcional en Scheme


## Antes de la clase de prácticas ##

- Antes de empezar esta práctica es importante que revises la solución
  de la práctica 1. Puedes preguntar las dudas al profesor de prácticas.

- Los siguientes ejercicios están basados en los conceptos de teoría
vistos la semana pasada. Antes de la clase de prácticas debes repasar
todos los conceptos y **probar en el DrRacket** todos los ejemplos del
tema 2 [_Programación
Funcional_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md)
hasta el apartado 2.6 _Listas_ incluido.


## Ejercicios

Abre el DrRacket y crea el fichero `practica2.rkt` en el que deberás
escribir todos los ejemplos y soluciones de los ejercicios que
hagas. Escribe en comentarios tu nombre y apellidos. Usa también
comentarios para separar secciones y realizar anotaciones.  Incluye en
el fichero todo el código, ejemplos y resolución de ejercicios, que
hagas esta semana.

También debes añadir casos de prueba al código de todas las funciones
que implementes, tal y como vimos al final del seminario de
Scheme. Puedes usar algunos de los ejemplos de los enunciados, pero
debes también construir algunos casos nuevos, con ejemplos creados por
ti.
   
!!! Note "Siempre debes incluir casos de prueba"
    Los casos de prueba son un componente importante del código, ya
    que permiten guardar en el propio código una demostración de que
    éste funciona correctamente, así como unos ejemplos de cómo llamar
    a las funciones definidas.
   
### Ejercicio 1

a) Implementa la función `(binario-a-decimal b3 b2 b1 b0)` que reciba
4 bits que representan un número en binario y devuelva el número
decimal equivalente.

```racket
(binario-a-decimal 1 1 1 1) ; ⇒ 15
(binario-a-decimal 0 1 1 0) ; ⇒ 6
(binario-a-decimal 0 0 1 0) ; ⇒ 2
```

**Nota**: recuerda que para realizar esta conversión, se utiliza la siguiente fórmula:

```text
n = b3 * 2ˆ3 + b2 * 2ˆ2 + b1 * 2ˆ1 + b0 * 2ˆ0
```

Para la implementación de la expresión debes utilizar la función `expt`.


b) Implementa la función `(binario-a-hexadecimal b3 b2 b1 b0)` que
reciba 4 bits de un número representado en binario y devuelva el
carácter correspondiente a su representación en hexadecimal.

```racket
(binario-a-hexadecimal 1 1 1 1) ; ⇒ #\F
(binario-a-hexadecimal 0 1 1 0) ; ⇒ #\6
(binario-a-hexadecimal 1 0 1 0) ; ⇒ #\A
```

**Nota**: para realizar esta conversión, como paso intermedio debes
pasar primero el número binario a su representación decimal
(utilizando la función definida en el apartado anterior) y después a
su correspondiente hexadecimal. 

Recuerda que la representación hexadecimal de los números decimales
del 0 al 9 es el carácter correspondiente a ese número, y que el
número decimal 10 se representa con el carácter A, el 11 con el B, y
así sucesivamente hasta el 15 que es el F en hexadecimal.

Para la implementación de esta función auxiliar que pasa de decimal a
hexadecimal debes usar las funciones `integer->char` y
`char->integer`. En la función `char->integer` los caracteres
consecutivos están asociados con números consecutivos. Por ejemplo, el
entero correspondiente al carácter `#\A` es uno menos que el
correspondiente al carácter `#\B`. Los caracteres de números y los de
letras no son consecutivos.


### Ejercicio 2

El cifrado César es una técnica cifrado por sustitución en la que cada letra del
texto desplaza un cierto número de lugares. 

Vamos a cifrar y descifrar letras minúsculas y mayúsculas del alfabeto inglés
(26 caracteres: desde #\a hasta #\z).

Vamos a trabajar con un desplazamiento variable, positivo o negativo,
dependiendo en que sentido rotemos el alfabeto.

Define las funciones `(cifrar-caracter char desplazamiento)` y `(descifra char
despalzamiento)` utilizando las siguientes funciones auxiliares:
`(encuentra-indice char)`, `(encuentra-caracter indice)`, `(entre-az? char)` y
`(rota-indice indice desplazamiento)`.

**Consejo**: puedes usar la función [`modulo`](https://docs.racket-lang.org/reference/generic-numbers.html#(def._((quote._~23~25kernel)._modulo))).

Analiza los siguientes ejemplos para entender mejor el funcionamiento de las funciones auxiliares:

```racket
(encuentra-indice #\a) ; ⇒ 0
(encuentra-indice #\b) ; ⇒ 1
(encuentra-indice #\m) ; ⇒ 12
(encuentra-indice #\z) ; ⇒ 25


(encuentra-caracter 0) ; ⇒ #\a
(encuentra-caracter 1) ; ⇒ #\b
(encuentra-caracter 12) ; ⇒ #\m
(encuentra-caracter 25) ; ⇒ #\z

(entre-az? #\a) ; ⇒ #t
(entre-az? #\m) ; ⇒ #t
(entre-az? #\z) ; ⇒ #t
(entre-az? #\`) ; ⇒ #f
(entre-az? #\{) ; ⇒ #f

(rota-indice 4 24) ; ⇒ 2)
(rota-indice 4 -5) ; ⇒ 25)

(cifra-caracter #\a 3) ; ⇒ #\d)
(cifra-caracter #\z -1) ; ⇒ #\y)
(cifra-caracter #\j 40) ; ⇒ #\x)
(cifra-caracter #\D 3) ; ⇒ #\G)
(cifra-caracter #\ñ 3) ; ⇒ #\ñ)

(descifra-caracter #\d 3) ; ⇒ #\a)
(descifra-caracter #\y -1) ; ⇒ #\z)
(descifra-caracter #\x 40) ; ⇒ #\j)
(descifra-caracter #\G 3) ; ⇒ #\D)
(descifra-caracter #\tab 3) ; ⇒ #\tab)
```


### Ejercicio 3

Implementa la función `(menor-de-tres n1 n2 n3)` que reciba tres
números como argumento y devuelva el menor de los tres, intentando que
el número de condiciones sea mínima.

No debes utilizar la función `min`. 

Implementa dos versiones de la función: 

- versión 1: usando la forma especial `if` 
- versión 2 (llámala `menor-de-tres-v2`): sin usar la forma especial
  `if`, sino definiendo una función auxiliar `(menor x y)` que
  devuelva el menor de dos números (en esta sí que deberías usar `if`)
  y construyendo la función `menor-de-tres-v2` como una composición de
  llamadas a esta función  auxiliar. 

```racket
(menor-de-tres 2 8 1) ;; ⇒ 1
(menor-de-tres-v2 3 0 3) ;; ⇒ 0
```

### Ejercicio 4

a) Supongamos las definiciones

```racket
(define (f x)
    (cons x 2))

(define (g x y)
    (cons x y))
```

Realiza la evaluación paso a paso de la siguiente expresión 

```racket
(g (f (+ 2 1)) (+ 1 1))
```

mediante el **modelo de sustitución**, utilizando tanto el **orden
aplicativo** y como el **orden normal**.

Escribe la solución entre comentarios en el propio fichero `.rkt` de
la práctica.

b) Supongamos las definiciones

```racket
(define (func-1 x)
    (/ x 0))
    
(define (func-2 x y)
    (if (= x 0)
        0
        y))
```

Igual que en el apartado anterior, realiza la evaluación paso a paso
de la siguiente expresión

```racket
(func-2 0 (func-1 10))
```

mediante el **modelo de sustitución**, utilizando tanto el **orden
aplicativo** y como el **orden normal**. Y escribe la solución entre
comentarios en el propio fichero `.rkt` de la práctica.


### Ejercicio 5

Implementa la función `(cadenas-mayores lista1 lista2)` que recibe 2
listas con 3 cadenas y devuelve otra lista con las 3 cadenas de mayor
longitud, comparando las cadenas de cada posición de la
lista. En el caso en que las cadenas tengan la misma longitud, se
devuelve la cadena de la primera lista.

!!! Note "Pista"
    Puedes utilizar las funciones `second` y `third` que devuelven el
    segundo y el tercer elemento de una lista.
    
```racket
(cadenas-mayores '("hola" "que" "tal") '("meme" "y" "adios")) ; ⇒ ("hola" "que" "adios")
(cadenas-mayores '("esto" "es" "lpp") '("hoy" "hay" "clase")) ; ⇒ ("esto" "hay" "clase")
```


### Ejercicio 6

Supongamos que queremos programar un juego de cartas que usa la baraja
francesa. Lo primero que debemos hacer es definir una forma de
representar las cartas y funciones que trabajen con esa
representación. En este ejercicio vamos a implementar esas funciones.

Representaremos una carta por un símbolo con dos letras: la primera
indicará su número o figura y la segunda el palo de la carta,
representado con el símbolo UTF correspondiente.

!!! Nota "Símbolos UTF de los palos de la baraja francesa"
    Puedes copiar los siguientes símbolos UTF y pegarlos en el código
    fuente de la práctica: ♠, ♣, ♥ y ♦ (picas, tréboles, corazones y
    diamantes).

Por ejemplo:

```racket
(define tres-de-picas '3♠)
(define as-de-corazones 'A♥)
(define jota-de-diamantes 'J♦)
```

Debemos definir la función `carta` que devuelve una pareja con el
valor correspondiente a su orden en la baraja francesa (un número) y
el nombre del palo de la carta (como símbolo, no como cadena).

```racket
(carta tres-de-picas) ; ⇒ (3 . Picas)
(carta as-de-corazones) ; ⇒ (1 . Corazones)
(carta 'K♣) ; ⇒ (12 . Tréboles)
```

Los valores de las cartas de la baraja francesa son:

```text
A (As) ⇒ 1
J (Jota) ⇒ 10
Q (Reina) ⇒ 11
K (Rey) ⇒ 12
```

Para realizar el ejercicio debes definir en primer lugar las funciones
`(obten-palo char)` y `(obten-valor char)` que devuelven el palo y el
valor, dado un carácter. Y debes implementar la función `carta` usando
estas dos funciones.

```racket
(obten-palo #\♠) ; ⇒ Picas
(obten-palo #\♥) ; ⇒ Corazones
(obten-valor #\3) ; ⇒ 3
(obten-valor #\J) ; ⇒ 10
```

!!! Note "Pista"
    Puedes utilizar las funciones `(symbol->string simbolo)` que convierte un
    símbolo en una cadena y `(string-ref cadena pos)` que devuelve el
    carácter de una cadena situado en una determinada posición.


### Ejercicio 7

Implementa la función `(jugada-mano carta1 carta2 carta3)` que recibe 3 cartas de la
baraja francesa y devuelve una cadena indicando si la jugada de tres
cartas contiene una **pareja** (dos cartas con el mismo valor), un **trío**
(las tres cartas tienen el mismo valor) o **nada** (las tres cartas
son distintas) y también el valor de la pareja o del trío.

Para obtener los valores de las cartas debes usar las funciones
definidas en el ejercicio anterior.

Ejemplos:

```racket
(jugada-mano '3♥ '3♣ '3♥) ; ⇒ "trío de 3"
(jugada-mano 'K♦ '7♠ 'K♥) ; ⇒ "pareja de 12"
(jugada-mano '5♣ '4♣ '6♣) ; ⇒ "nada"
```

!!! Note "Números a cadenas"
    Puedes obtener una cadena correspondiente a un número usando la función
    `number->string`. Esta función solo la debes usar en este ejercicio.


## Entrega de la práctica

Sube la solución de los ejercicios al cuestionario de Moodle _Entrega
práctica 2_ hasta el domingo 11 de febrero a las 21:00 h.

Tal y como hemos comentado al comienzo de la práctica, debes incluir
casos de prueba en todo el código que escribas.

Una vez finalizado el plazo de entrega podrás revisar el cuestionario
y visualizar la solución. Corrige la entrega, comparando la solución
con la tuya. Puedes consultar cualquier duda con tu profesor en la
clase de prácticas de la semana que viene.

----
Lenguajes y Paradigmas de Programación, curso 2023-24  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

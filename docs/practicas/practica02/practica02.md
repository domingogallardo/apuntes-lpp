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

Implementa la función `(menor-de-tres n1 n2 n3)` que reciba tres
números como argumento y devuelva el menor de los tres, intentando que
el número de condiciones sea mínima.

No debes utilizar la función `min`. 

Implementa dos versiones de la función: 

- versión 1: usando la forma especial `if` 
- versión 2 (llámala `menor-de-tres-v2`): definiendo una función auxiliar `(menor x y)` que
  devuelva el menor de dos números (deberás usar también la forma
  especial `if` para implementarla) y construyendo la función
  `menor-de-tres-v2` como una composición de llamadas a esta función
  auxiliar.

```racket
(menor-de-tres 2 8 1) ;; ⇒ 1
(menor-de-tres-v2 3 0 3) ;; ⇒ 0
```


### Ejercicio 3

a) Supongamos las definiciones

```racket
(define (f x y)
    (cons x y))

(define (g x)
    (cons 2 x))
```

Realiza la evaluación paso a paso de la siguiente expresión 

```racket
(f (g (+ 2 1)) (+ 1 1))
```

mediante el **modelo de sustitución**, utilizando tanto el **orden
aplicativo** y como el **orden normal**.

Escribe la solución entre comentarios en el propio fichero `.rkt` de
la práctica.

b) Supongamos las definiciones

```racket
(define (f x)
    (/ x 0))
    
(define (g x y)
    (if (= x 0)
        0
        y))
```

Igual que en el apartado anterior, realiza la evaluación paso a paso
de la siguiente expresión

```racket
(g 0 (f 10))
```

mediante el **modelo de sustitución**, utilizando tanto el **orden
aplicativo** y como el **orden normal**. Y escribe la solución entre
comentarios en el propio fichero `.rkt` de la práctica.


### Ejercicio 4

Implementa la función `(cadenas-mayores lista1 lista2)` que recibe 2
listas con 3 cadenas y devuelve otra lista con las 3 cadenas de mayor
longitud, comparando las cadenas de cada de cada posición de la
lista. En el caso en que las cadenas tengan la misma longitud, se
devuelve la cadena de la primera lista.

```racket
(cadenas-mayores '("hola" "que" "tal") '("meme" "y" "adios")) ; ⇒ ("hola" "que" "adios")
(cadenas-mayores '("esto" "es" "lpp") '("hoy" "hay" "clase")) ; ⇒ ("esto" "hay" "clase")
```

### Ejercicio 5

Supongamos que queremos programar un juego de cartas. Lo primero que
debemos hacer es definir una forma de representar las cartas y
funciones que trabajen con esa representación. En este ejercicio vamos
a implementar esas funciones.

Representaremos una carta por un símbolo con dos letras: la primera
indicará su número o figura y la segunda el palo de la carta.

Por ejemplo:

```racket
(define tres-de-oros '3O)
(define as-de-copas 'AC)
(define caballo-de-espadas 'CE)
```

Debemos definir la función `carta` que devuelve una pareja con el
valor correspondiente a su orden en la baraja española (un número) y el palo
de la carta (un símbolo).

```racket
(carta tres-de-oros) ; ⇒ (3 . Oros)
(carta as-de-copas) ; ⇒ (1 . Copas)
(carta 'RB) ; ⇒ (12 . Bastos)
```

Los valores de las cartas de la baraja española son:

```text
A (As) ⇒ 1
S (Sota) ⇒ 10
C (Caballo) ⇒ 11
R (Rey) ⇒ 12
```

Para realizar el ejercicio debes definir en primer lugar las funciones
`(obten-palo char)` y `(obten-valor char)` que devuelven el palo y el
valor, dado un carácter. Y debes implementar la función `carta` usando
estas dos funciones.

```racket
(obten-palo #\O) ; ⇒ Oros
(obten-palo #\E) ; ⇒ Espadas
(obten-valor #\3) ; ⇒ 3
(obten-valor #\S) ; ⇒ 10
```

!!! Note "Pista"
    Puedes utilizar las funciones `(symbol->string simbolo)` que convierte un
    símbolo en una cadena y `(string-ref cadena pos)` que devuelve el
    carácter de una cadena situado en una determinada posición.


### Ejercicio 6

Implementa la función `(palos-mano-cartas carta1 carta2 carta3)` que recibe 3 cartas de la
baraja española y devuelve una cadena indicando la cantidad de palos repetidos:
"todas del mismo palo", "palos distintos" o "dos cartas con el mismo
palo".

Para obtener los palos de las cartas debes usar las funciones
definidas en el ejercicio anterior.

Ejemplos:

```racket
(palos-mano-cartas '3O '7O '2O) ; ⇒ "todas del mismo palo"
(palos-mano-cartas '3O '7C '2E) ; ⇒ "palos distintos"
(palos-mano-cartas '3O '7O '2E) ; ⇒ "dos cartas con el mismo palo"
```

## Entrega de la práctica

Sube la solución de los ejercicios al cuestionario de Moodle _Entrega
práctica 2_ hasta el domingo 13 de febrero a las 21:00 h.

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

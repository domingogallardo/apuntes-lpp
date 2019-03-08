# Práctica 5: Procedimientos recursivos

## Entrega de la práctica

Para entregar la práctica debes subir a Moodle el fichero
`practica05.rkt` con una cabecera inicial con tu nombre y apellidos, y
las soluciones de cada ejercicio separadas por comentarios. Cada
solución debe incluir:

- La **definición de las funciones** que resuelven el ejercicio.
- Un conjunto de **pruebas** que comprueben su funcionamiento
  utilizando la librería `schemeunit`.

## Ejercicios


### Ejercicio 1  ###

a) Implementa una versión recursiva iterativa de la función
`(concat lista)` que toma como argumento una lista de cadenas
y devuelve una cadena resultante de concatenar todas las palabras de
la lista.

La función `concat` deberá llamar a la función
`concat-iter` que es la que implementa propiamente la versión
iterativa usando recursión por la cola.

Ejemplo:

```scheme
(concat  '("hola" "y" "adiós")) ; ⇒ "holayadiós")
(concat-iter '("hola" "y" "adiós") "") ; ⇒ "holayadiós")
```


b) Define utilizando recursión por la cola la función `(min-max
lista)` que recibe una lista numérica y devuelve una pareja con el
mínimo y el máximo de sus elementos.

Ejemplo:

```scheme
(min-max '(2 5 9 12 5 0 4)) ; ⇒ (0 . 12)
(min-max-iter '(5 9 12 5 0 4) (cons 2 2)) ; ⇒ (0 . 12)
```


### Ejercicio 2 ###

a) Implementa utilizando recursión por la cola las funciones
`expande-pareja` y `expande` de la práctica 3.

Ejemplo:

```scheme
(expande-pareja (cons 'a 4) ; ⇒ {a a a a}
(expande '((#t . 3) ("LPP" . 2) (b . 4)))
⇒ {#t #t #t "LPP" "LPP" b b b b}
```


b) Implementa utilizando recursión por la cola la función `(rotar k
lista)` que mueve `k` elementos de la cabeza de la lista al
final. **No es necesario utilizar una función iterativa auxiliar**,
puedes hacer que la propia función `rotar` sea iterativa usando el
parámetro `lista` como el parámetro donde acumular el resultado.

Ejemplo:

```scheme
(rotar 4 '(a b c d e f g)) ; ⇒ '(e f g a b c d)
```


### Ejercicio 3

Implementa utilizando recursión por la cola la función `mi-fold-left`
que haga lo mismo que la función de orden superior `fold-left`.


```scheme
(mi-fold-left - 0 '(1 2 3)) ; ⇒ -6
(mi-fold-left (lambda (res dato)
                         (cons dato res)) '() '(1 2 3))
; ⇒ '(3 2 1)
```

### Ejercicio 4 ###

a) Implementa utilizando recursión por la cola la función
`binario-a-decimal` que reciba una cadena con un número arbitrario de
0s y 1s y devuelva el número decimal correspondiente a ese número
binario.

Ejemplos:

```scheme
(binario-a-decimal "101") ; ⇒ 5
(binario-a-decimal "101101") ; ⇒ 45
```

Ejemplos:

b) Implementa, utilizando recursión por la cola, la función
`decimal-a-hexadecimal` que recibe un número decimal y devuelve una
lista con el número hexadecimal correspondiente en forma de cadena:

```scheme
(decimal-a-hexadecimal 200) ; ⇒ "C8"
(decimal-a-hexadecimal 999) ; ⇒ "3E7"
```

### Ejercicio 5 ###

Realiza una implementación que utilice la [técnica de la
_memoization_](https://domingogallardo.github.io/apuntes-lpp/teoria/tema03-procedimientos-recursivos/tema03-procedimientos-recursivos.html#soluciones-al-coste-de-la-recursion-memoization)
del algoritmo que devuelve la [serie de
Pascal](https://domingogallardo.github.io/apuntes-lpp/teoria/tema03-procedimientos-recursivos/tema03-procedimientos-recursivos.html#triangulo-de-pascal).

```scheme
(pascal-memo 8 4 lista) ; ⇒ 70
(pascal-memo 40 20 lista) ; ⇒ 137846528820
```


### Ejercicio 6 ###

a) Usando gráficos de tortuga, implementa la función
`(piramide-hexagonal lado decremento)` que dibuje hexágonos
concéntricos con el lado inicial `lado` y que cada vez vaya
decrementando ese valor con el `decremento`.

Por ejemplo, la llamada a `(piramide-hexagonal 150 10)` debe dibujar
la siguiente figura:

<img src="imagenes/hexagono.png" width="300px"/>

**Pista**: el desplazamiento que debe realizar la tortuga antes de
dibujar cada hexágono es de `decremento`, en la dirección del ángulo
que va al centro del hexágono.

b) Define la función `(alfombra-sierpinski tam)` que construya la
Alfombra de Sierpinski (una variante del Triágulo de Sierpinski que
hemos visto en teoría) de lado `tam` píxeles utilizando gráficos de
tortuga. 

Por ejemplo, la llamada a `(alfombra-sierpinski 500)` debe dibujar la
siguiente figura:

<img src="imagenes/alfombra-sierpinski.png" width="400px"/>


----

Lenguajes y Paradigmas de Programación, curso 2018-19  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

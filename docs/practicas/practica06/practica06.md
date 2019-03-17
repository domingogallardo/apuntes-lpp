# Práctica 5: Listas estructuradas

## Entrega de la práctica

Para entregar la práctica debes subir a Moodle el fichero
`practica06.rkt` con una cabecera inicial con tu nombre y apellidos, y
las soluciones de cada ejercicio separadas por comentarios. Cada
solución debe incluir:

- La **definición de las funciones** que resuelven el ejercicio.
- Un conjunto de **pruebas** que comprueben su funcionamiento
  utilizando la librería `schemeunit`.

## Ejercicios


### Ejercicio 1 ###

a) Escribe la lista estructurada correspondiente a la siguiente
representación gráfica por niveles. Para comprobar si la has definido
correctamente puedes intentar obtener algunos de los elementos de la
lista, como mostramos en el `check-equal?` que hay a continuación.

```text
       *
     / |  \
    |  |    \
    *  d      *
   / \    / /  | \
  a  b   c *   *  h
           |  / \
           e f  g
```

```scheme
(define lista-a '(________))
(check-equal? (cadddr (caddr lista-a)) 'h)
```


b) Escribe la lista estructurada correspondiente a la siguiente
representación gráfica por niveles. Comprueba que está definida
correctamente haciendo algunos `check-equal?` que obtengan algunos de
sus elementos.

```text
      *
  /  / \   \
 1  *   *   8  
  / | \   \  
6   *  10  2
    |    
    3   
```

```scheme
(define lista-b '(________))
```


### Ejercicio 2  ###

Implementa la función recursiva `(cuenta-pares lista)` que recibe una
lista estructurada y cuenta la cantidad de números pares que
contiene. Implementa dos versiones de la función, una con
**recursión pura** y otra con **funciones de orden superior**.

Ejemplos:

```scheme
(cuenta-pares '(1 (2 3) 4 (5 6))) ; ⇒ 3
(cuenta-pares '(((1 2) 3 (4) 5) ((((6)))))) ; ⇒ 3
```

### Ejercicio 3 ###

a) Implementa la función `(cumplen-predicado pred lista)` que devuelva
una lista con todos los elementos de lista estructurada que cumplen un
predicado. Implementa dos versiones, una **recursiva pura** y otra usando
**funciones de orden superior**.

Ejemplo:

```scheme
(cumplen-predicado even? '(1 (2 (3 (4))) (5 6))) ; ⇒ {2 4 6}
(cumplen-predicado pair? '(((1 . 2) 3 (4 . 3) 5) 6)) ; ⇒ {{1 . 2} {4 . 3}
```

Utilizando la función anterior implementa las siguientes funciones:

- Función `(busca-mayores n lista-num)` que recibe una lista
  estructurada con números y un número `n` y devuelve una lista plana
  con los números de la lista original mayores que `n`.
  
  ```scheme
  (busca-mayores '(-1 (20 (10 12) (30 (25 (15))))) 10) ; ⇒ {20 12 30 25 15}
  ```

- Función `(empieza-por char lista-pal)` que recibe una lista
  estructurada con símbolos y un carácter `char` y devuelve una lista
  plana con los símbolos de la lista original que comienzan por el
  carácter `char`.
  
  ```scheme
  (empieza-por #\m '((hace (mucho tiempo)) (en) (una galaxia ((muy muy) lejana))) ; ⇒ {mucho muy muy}
  ```


b) Implementa la función recursiva `(mayor-plana lista)` que devuelve
la lista plana de mayor longitud de la lista estructurada `lista`. En
el caso en que haya más de una lista plana de igual longitud se
devolverá la que se encuentra situada más a la derecha.

Ejemplos:

```scheme
(mayor-plana '(a b c)) ; ⇒ '(a b c)
(mayor-plana '((a b) (a (b (c d))) g)) ; ⇒ '(c d)
(mayor-plana '((a b) (a (b (c d e f))) g)) ; ⇒ '(c d e f)
```


### Ejercicio 4 ###

a) Implementa la función recursiva `(sustituye-elem elem-old
elem-new lista)` que recibe como argumentos una lista estructurada y dos
elementos, y devuelve otra lista con la misma estructura, pero en la
que se ha sustituido las ocurrencias de `elem-old` por `elem-new`.

Ejemplo:

```scheme
(sustituye-elem  '(a b (c d (e c)) c (f (c) g))  'c  'h)
⇒ {a b {h d {e h}} h {f {h} g}}
```


b) Implementa la función recursiva `(diff-listas l1 l2)` que tome como
argumentos dos listas estructuradas con la misma estructura, pero con
diferentes elementos, y devuelva una lista de parejas que contenga los
elementos que son diferentes.

Ejemplos:

```scheme
(diff-listas '(a (b ((c)) d e) f) '(1 (b ((2)) 3 4) f))
⇒ {{a . 1} {c . 2} {d . 3} {e . 4}}

(diff-listas '((a b) c) '((a b) c))
⇒ ()
```


### Ejercicio 5 ###

Dos funciones sobre niveles:

a) Implementa la función `(cuenta-hojas-debajo-nivel lista n)` que recibe
una lista estructurada y un número que indica un nivel, y devuelve el
número de hojas que hay por debajo de ese nivel. Puedes hacerlo con
recursión o con funciones de orden superior.

```scheme
(cuenta-hojas-debajo-nivel '(10 2 (4 6 (9 3) (8 7) 12) 1) 2) ; ⇒ 4
(cuenta-hojas-debajo-nivel '(10 2 (4 6 (9 3) (8 7) 12) 1) 3) ; ⇒ 0
```

b) Implementa la función `(nivel-elemento lista)` que reciba una lista
estructurada y devuelva una pareja `(elem . nivel)`, donde la parte
izquierda es el elemento que se encuentra a mayor nivel y la parte
derecha el nivel en el que se encuentra. Puedes definir alguna
función auxiliar si lo necesitas. Puedes hacerlo con
recursión o con funciones de orden superior.

```scheme
(nivel-elemento '(2 (3))) ;⇒ (3 . 2)
(nivel-elemento '((2) (3 (4)((((((5))) 6)) 7)) 8)) ; ⇒ (5 . 8)
```

----

Lenguajes y Paradigmas de Programación, curso 2019-19  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

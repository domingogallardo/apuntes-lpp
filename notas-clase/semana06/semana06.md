## Semana 6

Notas de clase de la semana 6 de LPP. 


## Tema 4: Estructuras de datos recursivas

- **1 Listas estructuradas**
    - **1.1. Definición y ejemplos**
    - **1.2. Funciones recursivas sobre listas estructuradas**
- 2 Árboles
    - 2.1. Definición de árboles en Scheme
    - 2.2. Funciones recursivas sobre árboles
- 3 Árboles binarios
    - 3.1. Definición de árboles binarios en Scheme
    - 3.2. Funciones recursivas sobre árboles binarios
    
----


### Listas estructuradas

- Funciones para trabajar con listas:

    - `(car lista)` para obtener el primer elemento de una lista
    - `(cdr lista)` para obtener el resto de la lista
    - `(cons dato lista)` para construir una nueva lista con el dato
      como primer elemento

- En este apartado vamos a estudiar cómo trabajar con *listas que
  contienen otras listas*. Los elementos de las listas pueden ser
  elementos atómicos u otras listas.
  
- La función `(car lista)` puede devolver un elemento u otra lista.

----

### Definición y ejemplos

- Llamaremos **lista estructurada** a una lista que contiene otras
  sublistas. Lo contrario de lista estructurada es una **lista
  plana**, una lista formada por elementos que no son
  listas. Llamaremos **hojas** a los elementos de una lista que no son
  sublistas.

- A las listas estructuradas cuyas hojas son símbolos se les denomina
  en el contexto de la programación funcional _expresiones-S_
  ([S-expression](http://en.wikipedia.org/wiki/S-expression)).

- Por ejemplo, la lista estructurada:

    ```scheme
    '(a b (c d e) (f (g h)))
    ```

    es una lista estructurada con 4 elementos:

    - El elemento `'a`, una hoja
    - El elemento `'b`, otra hoja
    - La lista plana `'(c d e)`
    - La lista estructurada `'(f (g h))`

- Una lista formada por parejas la consideraremos una lista plana, ya
  que no contiene ninguna sublista. Por ejemplo, la lista

    ```scheme
    '((a . 3) (b . 5) (c . 12))
    ```

    es una lista plana de tres elementos (hojas) que son parejas.

----

### Función `(hoja? dato)`

- Un dato es una hoja si no es una lista:

    ```scheme
    (define (hoja? dato)
        (not (list? dato)))
    ```

- Por ejemplo, supongamos la siguiente lista:

    ```scheme
    '((1 2) 3 4 (5 6))
    ```

    Es una lista de 4 elementos, siendo el primero y el último otras
    sublistas y el segundo y el tercero hojas. Podemos comprobar si
    son o no hojas sus elementos:

    ```scheme
    (define lista '((1 2) 3 4 (5 6)))
    (hoja? (car lista)) ; ⇒ #f
    (hoja? (cadr lista)) ; ⇒ #t
    (hoja? (caddr lista)) ; ⇒ #t
    (hoja? (cadddr lista)) ; ⇒ #f
    ```

- La lista vacía no es una hoja

    ```scheme
    (hoja? '()) ; ⇒ #f
    ```

----

### Función `(plana? lista)`

- Una definición recursiva de lista plana:

> Una lista es plana si y solo si el primer elemento es una hoja y el
> resto es plana.

- Y el caso base:

> Una lista vacía es plana.

- Usando esta definición recursiva, podemos implementar en Scheme la
  función `(plana? lista)` que comprueba si una lista es plana:

```scheme
(define (plana? lista)
   (or (null? lista)
       (and (hoja? (car lista))
            (plana? (cdr lista)))))
```

- Ejemplos:

```scheme
(plana? '(a b c d e f)) ; ⇒ #t
(plana? (list (cons 'a 1) "Hola" #f)) ; ⇒ #t
(plana? '(a (b c) d)) ; ⇒ #f
(plana? '(a () b)) ; ⇒ #f
```

¿Cómo sería la definición de `plana?` utilizando funciones de orden superior?

<p style="margin-bottom:3cm;"/>

```scheme
(define (plana-fos? lista)
  (for-all hoja? lista))
```


----

### Función `(estructurada? lista)`

- Una lista es estructurada cuando alguno de sus elementos es otra
  lista:

```scheme
(define (estructurada? lista)
   (and (not (null? lista))
        (or (list? (car lista))
            (estructurada? (cdr lista)))))
```



- Ejemplos:

```scheme
(estructurada? '(1 2 3 4)) ; ⇒ #f
(estructurada? (list (cons 'a 1) (cons 'b 2) (cons 'c 3))) ; ⇒ #f
(estructurada? '(a () b)) ; ⇒ #t
(estructurada? '(a (b c) d)) ; ⇒ #t
```

¿Cómo sería la definición de `estructurada?` utilizando funciones de orden superior?

<p style="margin-bottom:3cm;"/>

```scheme
(define (estructurada-fos? lista)
  (exists list? lista))
```

Realmente bastaría con haber hecho una de las dos definiciones y
escribir la otra como la negación de la primera:

```scheme
(define (estructurada? lista)
   (not (plana? lista)))
```

----

### Ejemplos de listas estructuradas

- Las listas estructuradas son muy útiles para representar información
  jerárquica en donde queremos representar elementos que contienen
  otros elementos.

- Por ejemplo, las expresiones de Scheme son listas estructuradas:

    ```scheme
    '(= 4 (+ 2 2))
    '(if (= x y) (* x y) (+ (/ x y) 45))
    '(define (factorial x) (if (= x 0) 1 (* x (factorial (- x 1)))))
    ```

- El análisis sintáctico de una oración puede generar una lista
  estructurada de símbolos, en donde se agrupan los distintos
  elementos de la oración:

    ```scheme
    '((Juan) (compró) (la entrada (de los Miserables)) (el viernes por la tarde))
    ```

----

### *Pseudo árboles* con niveles

- Las listas estructuradas definen una estructura de niveles, donde la
  lista inicial representa el primer nivel, y cada sublista representa
  un nivel inferior. Los datos de las listas representan las hojas.

- Por ejemplo, la representación en forma de niveles de la lista `'((a
  b c) d e)` es la siguiente:

<img src="imagenes/expresion-e-1.png" width="350px"/>

Las hojas `d` y `e` están en el nivel 1 y en las posiciones 2 y 3 de
la lista y las hojas `a`, `b` y `c` en el nivel 2 y en la posición 1
de la lista.

> UNA LISTA ESTRUCTURADA NO ES UN ÁRBOL  
> Una lista estructurada no es un árbol propiamente dicho, porque
> todos los datos están en las hojas.

En un árbol, lo veremos más adelante, todos los nodos tienen
datos. Tanto los nodos padres como los hijos. Sin embargo en una lista
estructurada los nodos padres del árbol no tienen ningún dato, sino
que sirven para agrupar un conjunto de hijos.

- Otro ejemplo. ¿Cuál sería la representación en niveles de la
  siguiente lista estructurada?:

```scheme
'(map (lambda (x) (+ x 10)) (quote (1 2 3 4)))
```

<p style="margin-bottom:3cm;"/>

----

### Funciones recursivas sobre listas estructuradas

- `(num-hojas lista)`: número de hojas de una lista estructurada
- `(altura lista)`: nivel mayor de una lista estructurada

Como hemos dicho antes, la cuestión clave en este tipo de listas es
que el `car` puede ser a su vez otra lista.

----

### Número de hojas

```scheme
(num-hojas '((1 2) (3 4 (5) 6) (7))) ⇒ 7
```

<img src="imagenes/num-hojas-estructurada.png" width="400px"/>

- Podemos definir la función obteniendo el primer elemento y el resto
  de la lista, y contando recursivamente el número de hojas del primer
  elemento y del resto.
- Al ser una lista estructurada, **el primer elemento puede ser a su
  vez otra lista, por lo que llamamos a la recursión para contar sus
  hojas**.
- La definición de este caso general usando _pseudocódigo_ es:

> El número de hojas de una lista estructurada es la suma del número
> de hojas de su primer elemento (que puede ser otra lista) y del
> número de hojas del resto.


```scheme
(define (num-hojas x)
   (cond
      ((null? x) 0)
      ((hoja? x) 1)
      (else (+ (num-hojas (car x))
               (num-hojas (cdr x))))))
```

- Hay que hacer notar que el parámetro `x` puede ser tanto una
  lista como un dato atómico. Estamos aprovechándonos de la
  característica de Scheme de ser débilmente tipeado para hacer un
  código bastante conciso.

----

### Versión con funciones de orden superior

- Podemos usar también las funciones de orden superior `map` y
  `fold-right` para obtener una versión más concisa.
- Una lista estructurada tiene como elementos hojas o listas. 
- Podemos entonces mapear una expresión lambda con _la propia función
  que estamos definiendo_ sobre sus elementos, poniendo como caso
  especial el hecho de que la lista sea una hoja.
- El resultado será una lista de números (el número de hojas de cada
  componente), que podemos sumar haciendo un `fold-right` con la
n  función `+`:

```scheme
(define (num-hojas-fos lista)
    (fold-right + 0 (map (lambda (sublista)
                           (if (hoja? sublista)
                               1
                               (num-hojas-fos sublista))) lista)))
```

<img src="imagenes/map-lista.png" width="700px"/>

----

### Altura de una lista estructurada

- La *altura* de una lista estructurada viene dada por su número de
  niveles
- Una lista plana tiene una altura de 1, la lista `'((1 2 3) 4 5)`
  tiene una altura de 2.

```scheme
(altura '(1 (2 3) 4)) ⇒ 2
(altura '(1 (2 (3)) 3)) ⇒ 3
```

<img src="imagenes/altura-estructurada.png" width="300"/>

> Para calcular la altura de una lista estructurada tenemos que
> obtener (de forma recursiva) la altura de su primer elemento, y la
> altura del resto de la lista, sumarle 1 a la altura del primer
> elemento y devolver el máximo de los dos números.

En Scheme:

```scheme
(define (altura x)
   (cond 
      ((null? x) 0)
      ((hoja? x) 0)
      (else (max (+ 1 (altura (car x)))
                 (altura (cdr x))))))
```

----

### Versión con funciones de orden superior

Y la segunda versión, usando las funciones de orden superior `map`
para obtener la altura de las sublistas y `fold-right` para quedarse
con el máximo.

```scheme
(define (altura-fos lista)
   (+ 1 (fold-right max 0 (map (lambda (sublista)
                                 (if (hoja? sublista)
                                     0
                                     (altura-fos sublista))) lista))))
```

---

### Otras funciones recursivas

Vamos a diseñar otras funciones recursivas que trabajan con la
estructura jerárquica de las listas estructuradas.

- `(aplana lista)`: devuelve una lista plana con todas las hojas de la lista
- `(pertenece-lista? dato lista)`: busca una hoja en una lista
  estructurada
- `(nivel-lista dato lista)`: devuelve el nivel en el que se encuentra
  un dato en una lista
- `(cuadrado-lista lista)`: eleva todas las hojas al cuadrado
  (suponemos que la lista estructurada contiene números)
- `(map-lista f lista)`: similar a map, aplica una función a todas las
  hojas de la lista estructurada y devuelve el resultado (otra lista
  estructurada)

---

### `(aplana lista)`

Devuelve una lista plana con todas las hojas de la lista.

```scheme
(define (aplana x)
  (cond
    ((null? x) '())
    ((hoja? x) (list x))
    (else 
     (append (aplana (car x))
             (aplana (cdr x))))))
```

Por ejemplo:

```scheme
(aplana '(1 2 (3 (4 (5))) (((6)))))
; ⇒ {1 2 3 4 5 6}
```

Con funciones de orden superior:

```scheme
(define (aplana-fos lista)
  (fold-right append
              '()
              (map (lambda (x)
                     (if (hoja? x)
                         (list x)
                         (aplana-fos x))) lista)))
```


---

### `(pertenece-lista? dato lista)`

Comprueba si el dato `dato` aparece en la lista estructurada. 

```scheme
(define (pertenece? dato x)
  (cond 
    ((null? x) #f)
    ((hoja? x) (equal? dato x))
    (else (or (pertenece? dato (car x))
              (pertenece? dato (cdr x))))))
```

Ejemplos:

```scheme
(pertenece? 'a '(b c (d (a)))) ⇒ #t
(pertenece? 'a '(b c (d e (f)) g)) ⇒ #f
```

Con funciones de orden superior:

```scheme
(define (pertenece-fos? elem lista)
  (exists (lambda (x)
             (if (hoja? x)
                 (equal? elem x)
                 (pertenece-fos? elem x))) lista))
```

---

### `(nivel-hoja dato lista)`

Veamos la función `(nivel-hoja dato lista)` que recorre la lista
buscando el dato y devuelve el nivel en que se encuentra. Si el dato
no se encuentra en la lista, se devolverá -1. Si el dato se encuentra
en más de un lugar de la lista se devolverá el nivel mayor.

Ejemplos:

```scheme
(nivel-hoja 'b '(a b (c))) ; ⇒ 1
(nivel-hoja 'b '(a (b) c)) ; ⇒ 2
(nivel-hoja 'b '(a (b) d ((b)))) ; ⇒ 3
(nivel-hoja 'b '(a c d ((e)))) ; ⇒ -1
```


```scheme
(define (nivel-hoja dato x)
  (cond
    ((null? x) -1)
    ((hoja? x) (if (equal? x dato) 0 -1))
    (else (max (suma-1-si-mayor-igual-que-0 (nivel-hoja dato (car x)))
               (nivel-hoja dato (cdr x))))))
```

Las funciones auxiliares se definen de la siguiente forma:

```scheme
(define (suma-1-si-mayor-igual-que-0 x)
  (if (>= x 0)
      (+ x 1)
      x))
```

Con funciones de orden superior:

```scheme
(define (nivel-hoja-fos dato lista)
  (suma-1-si-mayor-igual-que-0
       (fold-right max -1
                   (map (lambda (sublista)
                          (if (hoja? sublista)
                              (if (equal? sublista dato) 0 -1)
                              (nivel-hoja-fos dato sublista)))  lista))))

```
                             
----

### `(cuadrado-lista lista)`

Devuelve una lista estructurada con la misma estructura y sus
números elevados al cuadrado.

```scheme
(define (cuadrado-lista x)
  (cond ((null? x) '())
        ((hoja? x) (* x x))
        (else (cons (cuadrado-lista (car x))
                    (cuadrado-lista (cdr x))))))
```

Por ejemplo:

```scheme
(cuadrado-lista '(2 3 (4 (5)))) ⇒ (4 9 (16 (25))
```

Versión con `map`:

```scheme
(define (cuadrado-lista-fos lista)
    (map (lambda (sublista)
           (if (hoja? sublista)
               (* sublista sublista)
               (cuadrado-lista-fos sublista))) lista))
```

----

### `(map-lista f lista)`

Devuelve una lista estructurada igual que la original con el
resultado de aplicar a cada uno de sus hojas la función f
 
```scheme
(define (map-lista f lista)
  (cond ((null? lista) '())
        ((hoja? lista) (f lista))
        (else (cons (map-lista f (car lista))
                    (map-lista f (cdr lista))))))
```
	
Por ejemplo:

```scheme
(map-lista (lambda (x) (* x x)) '(2 3 (4 (5)))) ⇒ (4 9 (16 (25))
```

----


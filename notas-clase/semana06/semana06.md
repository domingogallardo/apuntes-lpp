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

    ```racket
    (a b (c d e) (f (g h)))
    ```

    es una lista estructurada con 4 elementos:

    - El elemento `'a`, una hoja
    - El elemento `'b`, otra hoja
    - La lista plana `'(c d e)`
    - La lista estructurada `'(f (g h))`

- Una lista formada por parejas la consideraremos una lista plana, ya
  que no contiene ninguna sublista. Por ejemplo, la lista

    ```racket
    ((a . 3) (b . 5) (c . 12))
    ```

    es una lista plana de tres elementos (hojas) que son parejas.

----

### Función `(hoja? dato)`

- Un dato es una hoja si no es una lista:

    ```racket
    (define (hoja? dato)
        (not (list? dato)))
    ```

- Por ejemplo, supongamos la siguiente lista:

    ```racket
    ((1 2) 3 4 (5 6))
    ```

    Es una lista de 4 elementos, siendo el primero y el último otras
    sublistas y el segundo y el tercero hojas. Podemos comprobar si
    son o no hojas sus elementos:

    ```racket
    (define lista '((1 2) 3 4 (5 6)))
    (hoja? (car lista)) ; ⇒ #f
    (hoja? (cadr lista)) ; ⇒ #t
    (hoja? (caddr lista)) ; ⇒ #t
    (hoja? (cadddr lista)) ; ⇒ #f
    ```

- La lista vacía no es una hoja

    ```racket
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

    ```racket
    (define (plana? lista)
       (or (null? lista)
           (and (hoja? (car lista))
                (plana? (cdr lista)))))
    ```

- Ejemplos:

    ```racket
    (plana? '(a b c d e f)) ; ⇒ #t
    (plana? (list (cons 'a 1) "Hola" #f)) ; ⇒ #t
    (plana? '(a (b c) d)) ; ⇒ #f
    (plana? '(a () b)) ; ⇒ #f
    ```

¿Cómo sería la definición de `plana?` utilizando funciones de orden superior?

<p style="margin-bottom:3cm;"></p>


```racket
(define (plana-fos? lista)
  (for-all? hoja? lista))
```

```racket
(define (for-all? predicado lista)
  (or (null? lista)
      (and (predicado (car lista))
           (for-all? predicado (cdr lista)))))
```

----

### Función `(estructurada? lista)`

- Una lista es estructurada cuando alguno de sus elementos es otra
  lista:

    ```racket
    (define (estructurada? lista)
       (and (not (null? lista))
            (or (list? (car lista))
                (estructurada? (cdr lista)))))
    ```



- Ejemplos:

    ```racket
    (estructurada? '(1 2 3 4)) ; ⇒ #f
    (estructurada? (list (cons 'a 1) (cons 'b 2) (cons 'c 3))) ; ⇒ #f
    (estructurada? '(a () b)) ; ⇒ #t
    (estructurada? '(a (b c) d)) ; ⇒ #t
    ```

¿Cómo sería la definición de `estructurada?` utilizando funciones de orden superior?

<p style="margin-bottom:3cm;"></p>

```racket
(define (estructurada-fos? lista)
  (exists? list? lista))
```

```racket
(define (exists? predicado lista)
  (if (null? lista)
      #f
      (or (predicado (car lista))
          (exists? predicado (cdr lista)))))
```

- Realmente bastaría con haber hecho una de las dos definiciones y
escribir la otra como la negación de la primera:

    ```racket
    (define (estructurada? lista)
       (not (plana? lista)))
    ```

----

### Ejemplos de listas estructuradas

- Las listas estructuradas son muy útiles para representar información
  jerárquica en donde queremos representar elementos que contienen
  otros elementos.

- Por ejemplo, las expresiones de Scheme son listas estructuradas:

    ```racket
    (= 4 (+ 2 2))
    (if (= x y) (* x y) (+ (/ x y) 45))
    (define (factorial x) (if (= x 0) 1 (* x (factorial (- x 1)))))
    ```

- El análisis sintáctico de una oración puede generar una lista
  estructurada de símbolos, en donde se agrupan los distintos
  elementos de la oración:

    ```racket
    ((Juan) (compró) (la entrada (de los Miserables)) (el viernes por la tarde))
    ```

----

### *Pseudo árboles* con niveles

- Las listas estructuradas definen una estructura de niveles, donde la
  lista inicial representa el primer nivel, y cada sublista representa
  un nivel inferior. Los datos de las listas representan las hojas.

- Por ejemplo, la representación en forma de niveles de la lista `((a
  b c) d e)` es la siguiente:

    <img src="imagenes/expresion-e-1.png" width="350px"/>

    Las hojas `d` y `e` están en el nivel 1 y en las posiciones 2 y 3 de
    la lista y las hojas `a`, `b` y `c` en el nivel 2 y en la posición 1
    de la lista.

!!! Warning "Una lista estructurada no es un árbol"
    Una lista estructurada no es un árbol propiamente dicho, porque
    un árbol tiene datos en todos los nodos, mientras que en la lista 
    estructurada los datos están sólo en las hojas.

- Las listas estructuradas sirven para agrupar de forma jerárquica
  conjunto de hijos en distintos niveles. 

- A pesar de ser distintas de los árboles, ambas son estructuras de
  datos jerárquicas (con niveles) que se pueden definir de forma
  recursiva y sobre las que se pueden definir algoritmos recursivos.
  
- Veremos los árboles en la próxima clase.

Otro ejemplo. ¿Cuál sería la representación en niveles de la
siguiente lista estructurada?:

```racket
(map (lambda (x) (+ x 10)) (quote (1 2 3 4)))
```

<p style="margin-bottom:3cm;"></p>

----

### Funciones recursivas sobre listas estructuradas

- `(num-hojas lista)`: número de hojas de una lista estructurada
- `(altura lista)`: nivel mayor de una lista estructurada

- Como hemos dicho antes, la cuestión clave en este tipo de listas es
  que el `car` puede ser a su vez otra lista.

----

### Número de hojas

```racket
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

!!! Hint "Caso general de num-hojas"
    El número de hojas de una lista estructurada es: 
    la suma del número de hojas de su primer elemento (que puede ser otra lista) y del
    número de hojas del resto.

- La recursión tiene dos llamadas recursivas. Una que recibe el
  elemento de la cabeza de la lista y otra que recibe el resto de la
  lista. 

    ```racket
    ;Caso general num-hojas
    (define (num-hojas lista)
      ; Falta caso base
      (+ (num-hojas (car lista))
         (num-hojas (cdr lista))))
    ```

!!! Warning "No hay coste exponencial"
    - A pesar de haber dos llamadas recursivas, no pasa lo mismo que en
    Fibonacci o Pascal. 
    - No se van a repetir llamadas a la recursión
    con los mismos datos. 
    - La recursión recorre lista estructurada y su coste será el número de
    elementos de la lista.

- Para considerar el **caso base**, veamos cómo las llamadas recursivas
  reciben cada vez un problema más pequeño. 

- La llamada recursiva sobre el resto de la lista recibe cada vez una
  lista con 1 elemento menos. Al final se llamará a la función con una
  lista vacía. Ese será un caso base. El número de elementos de una
  lista vacía es 0.

- La llamada recursiva sobre la cabeza de la lista es algo
  distinta. Recibe una lista en la que se ha descendido un nivel y
  tiene, por tanto, un nivel menos. Al final se llamará a la función
  con una hoja (un dato). Ese será el otro caso base y habrá que
  devolver 1.

- Definición completa de la función:

    ```racket
    (define (num-hojas x)
       (cond
          ((null? x) 0)
          ((hoja? x) 1)
          (else (+ (num-hojas (car x))
                   (num-hojas (cdr x))))))
    ```

- Hay que hacer notar que el parámetro `x` puede ser tanto una
  lista como un dato atómico. Estamos aprovechándonos de la
  característica de Scheme de ser débilmente tipado para hacer un
  código bastante conciso.

----

### Versión con funciones de orden superior

- Podemos usar también las funciones de orden superior `map` y
  `foldr` para obtener una versión más concisa.
- Una lista estructurada tiene como elementos hojas o listas. 
- Podemos entonces mapear una expresión lambda con _la propia función
  que estamos definiendo_ sobre sus elementos, poniendo como caso
  especial el hecho de que la lista sea una hoja.
- El resultado será una lista de números (el número de hojas de cada
  componente), que podemos sumar haciendo un `foldr` con la
  función `+`:

```racket
(define (num-hojas-fos lista)
    (foldr + 0 (map (lambda (sublista)
                       (if (hoja? sublista)
                           1
                           (num-hojas-fos sublista))) lista)))
```

<img src="imagenes/map-lista.png" width="600px"/>

----

### Altura de una lista estructurada

- La *altura* de una lista estructurada viene dada por su número de
  niveles
- Una lista plana tiene una altura de 1, la lista `((1 2 3) 4 5)`
  tiene una altura de 2.

    ```racket
    (altura '(1 (2 3) 4)) ⇒ 2
    (altura '(((1)) (2 3) 4)) ⇒ 3
    ```

<img src="imagenes/altura-estructurada.png" width="300"/>


!!! Hint "Caso general altura"
    Para calcular la altura de una lista estructurada tenemos que
    obtener (de forma recursiva) la altura de su primer elemento, y la
    altura del resto de la lista, sumarle 1 a la altura del primer
    elemento y devolver el máximo de los dos números.

- Caso base: la altura de una lista vacía y de una hoja es 0.

- En Scheme:

    ```racket
    (define (altura x)
       (cond 
          ((null? x) 0)
          ((hoja? x) 0)
          (else (max (+ 1 (altura (car x)))
                     (altura (cdr x))))))
    ```

----

### Versión con funciones de orden superior

- La segunda versión, usando las funciones de orden superior `map`
para obtener la altura de las sublistas y `foldr` para quedarse
con el máximo.

    ```racket
    (define (altura-fos lista)
       (+ 1 (foldr max 
                   0 
                   (map (lambda (sublista)
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

- Devuelve una lista plana con todas las hojas de la lista.

    ```racket
    (aplana '(1 2 (3 (4 (5))) (((6)))))
    ; ⇒ (1 2 3 4 5 6)
    ```

- Solución recursiva:

    ```racket
    (define (aplana x)
      (cond
        ((null? x) '())
        ((hoja? x) (list x))
        (else 
         (append (aplana (car x))
                 (aplana (cdr x))))))
    ```

- Solución con funciones de orden superior:

    ```racket
    (define (aplana-fos lista)
      (foldr append 
             '()
             (map (lambda (x)
                     (if (hoja? x)
                         (list x)
                         (aplana-fos x))) lista)))
    ```


---

### `(pertenece-lista? dato lista)`

- Comprueba si el dato `dato` aparece en la lista estructurada. 

    ```racket
    (pertenece? 'a '(b c (d (a)))) ⇒ #t
    (pertenece? 'a '(b c (d e (f)) g)) ⇒ #f
    ```

- Solución recursiva:

    ```racket
    (define (pertenece? dato x)
      (cond 
        ((null? x) #f)
        ((hoja? x) (equal? dato x))
        (else (or (pertenece? dato (car x))
                  (pertenece? dato (cdr x))))))
    ```


- Solución con funciones de orden superior:

    ```racket
    (define (pertenece-fos? elem lista)
      (exists? (lambda (x)
                  (if (hoja? x)
                      (equal? elem x)
                      (pertenece-fos? elem x))) lista))
    ```

---

### `(nivel-hoja dato lista)`

- Recorre la lista buscando el dato y devuelve el nivel en que se
encuentra. Si el dato no se encuentra en la lista, se devolverá -1. Si
el dato se encuentra en más de un lugar de la lista se devolverá el
nivel mayor.

    ```racket
    (nivel-hoja 'b '(a b (c))) ; ⇒ 1
    (nivel-hoja 'b '(a (b) c)) ; ⇒ 2
    (nivel-hoja 'b '(a (b) d ((b)))) ; ⇒ 3
    (nivel-hoja 'b '(a c d ((e)))) ; ⇒ -1
    ```

- Solución recursiva:

    ```racket
    (define (nivel-hoja dato x)
      (cond
        ((null? x) -1)
        ((hoja? x) (if (equal? x dato) 0 -1))
        (else (max (suma-1-si-mayor-igual-que-0 
                        (nivel-hoja dato (car x)))
                   (nivel-hoja dato (cdr x))))))
    ```

- La función auxiliar se define de la siguiente forma:

    ```racket
    (define (suma-1-si-mayor-igual-que-0 x)
      (if (>= x 0)
          (+ x 1)
          x))
    ```

- Solución con funciones de orden superior:

    ```racket
    (define (nivel-hoja-fos dato lista)
      (suma-1-si-mayor-igual-que-0
           (foldr max 
                  -1
                  (map (lambda (sublista)
                           (if (hoja? sublista)
                               (if (equal? sublista dato) 0 -1)
                               (nivel-hoja-fos dato sublista)))  
                       lista))))

    ```
                             
----

### `(cuadrado-lista lista)`

- Devuelve una lista estructurada con la misma estructura y sus
números elevados al cuadrado.

    ```racket
    (cuadrado-lista '(2 3 (4 (5)))) ⇒ (4 9 (16 (25))
    ```

- Solución recursiva:

    ```racket
    (define (cuadrado-lista x)
      (cond ((null? x) '())
            ((hoja? x) (* x x))
            (else (cons (cuadrado-lista (car x))
                        (cuadrado-lista (cdr x))))))
    ```


- Solución con `map`:

    ```racket
    (define (cuadrado-lista-fos lista)
        (map (lambda (sublista)
               (if (hoja? sublista)
                   (* sublista sublista)
                   (cuadrado-lista-fos sublista))) lista))
    ```

----

### `(map-lista f lista)`

- Devuelve una lista estructurada igual que la original con el
resultado de aplicar a cada uno de sus hojas la función `f`

    ```racket
    (map-lista (lambda (x) (* x x)) '(2 3 (4 (5)))) 
    ; ⇒ (4 9 (16 (25))
    ```

- Solución recursiva:

    ```racket
    (define (map-lista f lista)
      (cond ((null? lista) '())
            ((hoja? lista) (f lista))
            (else (cons (map-lista f (car lista))
                        (map-lista f (cdr lista))))))
    ```
	

----


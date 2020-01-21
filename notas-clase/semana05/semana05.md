
## Semana 5

Notas de clase de la semana 5 de LPP.

## Tema 3: Procedimientos recursivos

- 1 Procedimientos recursivos
    - 1.1 Pensando recursivamente
	- 1.2 El coste de la recursión
	- 1.3 Soluciones al coste de la recursión: procesos iterativos
	- 1.4 Soluciones al coste de la recursión: memoization
    - 1.5 Recursión y gráficos de tortuga

----

### 1 Procedimientos recursivos

- La formulación recursiva pura de una función es natural y muy fácil
  de entender (una vez aprendida)
- A veces la función resultante no es eficiente
- Veremos dos posibles soluciones: procesos iterativos y *memoization*
- La semana que viene veremos algoritmos recursivos para dibujar
  curvas fractales

----

### 1.1 Pensando recursivamente

- Hemos diseñado muchas funciones recursivas sobre listas.
- Ya hemos usado estos consejos:
    - Para diseñar procedimientos recursivos no funciona el método de
      _prueba y error_. Hay que diseñar la solución recursiva desde el
      principio.
    - Debemos fijarnos en *lo que devuelve la función*. Supondremos
      que la llamada recursiva funciona correctamente y devuelve el
      resultado correcto. Y después debemos transformar este resultado
      correcto en el resultado de la solución completa.
    - Debemos **confiar en que la llamada recursiva va a hacer su
      trabajo y devolver el resultado correcto**, sin preocuparte de
      cómo lo va a hacer.

----

### Un último ejemplo de diseño recursivo: `(palindroma? lista)`

- ¿cómo definimos una lista palíndroma de forma recursiva?. Por
  ejemplo, las siguientes listas son palíndromas:

```
{1 2 3 3 2 1}
{1 2 1}
{1}
'()
```

- Comenzamos con una definición **no recursiva**:

> Una lista es palíndroma cuando es igual a su inversa. 

- Esta definición no es recursiva porque no llamamos a la recursión
  con un caso más sencillo.

- La definición **recursiva** del caso general es la siguiente:

> Una lista es palíndroma cuando su primer elemento es igual que el
> último y la lista resultante de quitar el primer y el último
> elemento también es palíndroma

Y las siguientes dos definiciones de los casos más sencillas completan
esta definición general:

> Una lista es palíndroma cuando tiene un elemento o cuando es vacía.

Podemos definir la función recursiva usando un `or` que indique que
una lista es palíndroma cuando se cumple alguna de las tres
condiciones:

```scheme
(define (palindroma? lista)
    (or (null? lista)
        (null? (cdr lista))
        (and (equal? (car lista) (ultimo lista))
             (palindroma? (quitar-primero-ultimo lista)))))
```

La función auxiliar `quitar-primero-ultimo` la podemos definir así:

```scheme
(define (quitar-ultimo lista)
    (if (null? (cdr lista))
        '()
        (cons (car lista)
              (quitar-ultimo (cdr lista)))))

(define (quitar-primero-ultimo lista)
    (cdr (quitar-ultimo lista)))
```

----

### 1.2 El coste de la recursión

- Vamos a analizar el coste de la recursión de una forma empírica, sin
  realizar una análisis matemático riguroso.
- Veremos que el coste se dispara cuando tenemos dos llamadas
  recursivas.
- Veremos dos formas de conseguir que el coste sea menor.

----

### 1.2.1 La pila de la recursión

- Para analizar una función vamos por primera vez a *entrar en la
  recursión* y hacer una traza de las llamadas recursivas del
  siguiente:

```scheme
(define (mi-length items)
    (if (null? items)
        0
        (+ 1 (mi-length (cdr items)))))
```

- ¿Cómo podemos representar las llamadas y el resultado de `(mi-length
  '(a b c d))`

<p style="margin-bottom:2cm;"/>

```
(mi-length '(a b c d))
(+ 1 (mi-length '(b c d)))
(+ 1 (+ 1 (mi-length '(c d))))
(+ 1 (+ 1 (+ 1 (mi-length '(d)))))
(+ 1 (+ 1 (+ 1 (+ 1 (mi-length '())))))
(+ 1 (+ 1 (+ 1 (+ 1 0))))
(+ 1 (+ 1 (+ 1 1)))
(+ 1 (+ 1 2))
(+ 1 3)
4
```

- Cada llamada a la recursión **deja una función en espera de ser
  evaluada cuando la recursión devuelva un valor** (en el caso
  anterior el +). Esta función, junto con sus argumentos, se almacenan
  en la **pila de la recursión**.
- Cuando la recursión devuelve un valor, los valores se recuperan de
  la pila, se realiza la llamada y se devuelve el valor a la anterior
  llamada en espera.
- Si la recursión está mal hecha y nunca termina se genera un *stack
  overflow* porque la memoria que se almacena en la pila sobrepasa la
  memoria reservada para el intérprete DrRacket.

----

### Coste espacial de la recursión

- El coste espacial de un programa es una función que relaciona la
  memoria consumida por una llamada para resolver un problema con
  alguna variable que determina el tamaño del problema a resolver.

- En el caso de la función `mi-length` el tamaño del problema viene
  dado por la longitud de la lista. El coste espacial de `mi-lenght`
  es *O(n)*, siendo *n* la longitud de la lista.

----

### 1.2.3 El coste depende del número de llamadas a la recursión

- Veamos con un ejemplo que el coste de las llamadas recursivas puede
  dispararse. Supongamos la famosa [secuencia de Fibonacci]:
  0,1,1,2,3,5,8,13,...

- Secuencia de Fibonacci en la [Wikipedia](http://en.wikipedia.org/wiki/Fibonacci_number)

- Formulación matemática de la secuencia de Fibonacci:

```
Fibonacci(n) = Fibonacci(n-1) + Fibonacci(n-2)  
Fibonacci(0) = 0  
Fibonacci(1) = 1
```

- Formulación recursiva en Scheme:

```
(define (fib n)
    (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

- Evaluación de una llamada a Fibonacci:

<img src="./imagenes/fibonacci.png"/>

- Cada llamada a la recursión produce otras dos llamadas, por lo que
  el número de llamadas finales es 2^n siendo n el número que se pasa
  a la función.

- El coste espacial y temporal es exponencial, O(2^n).

- ¿Qué pasa si intentamos evaluar `(fibonaci 40)`?

----

### 1.3 Soluciones al coste de la recursión: procesos iterativos

- Diferenciamos entre procedimientos y procesos: un procedimiento es
  un algoritmo y un proceso es la ejecución de ese algoritmo.
- Es posible definir _procedimientos recursivos_ que generen _procesos
  iterativos_ en los que no se dejen llamadas recursivas en espera ni
  se incremente la pila de la recursión.
- **Solución**: Construimos la recursión de forma que en cada llamada
  se haga un cálculo parcial y en el caso base se pueda devolver
  directamente el resultado obtenido.

- Este estilo de recursión se denomina *recursión por la cola*
  ([tail recursion](http://en.wikipedia.org/wiki/Tail_call), en
  inglés).

----

### 1.3.1 Factorial iterativo

- Definimos la función `(fact-iter n result)` que es la que
  define el proceso iterativo
- Tiene un parámetro adicional (`result`) que es el parámetro en el
  que se irán guardando los cálculos intermedios
- Al final de la recursión el factorial debe estar calculado en
  `result` y se devuelve

```
(define (factorial n)
   (fact-iter n n))

(define (fact-iter n result)
   (if (= n 1)
      result
      (fact-iter (- n 1) (* result (- n 1)))))
```

Secuencia de llamadas:

```
(factorial 4)
(factorial-iter 4 4)
(factorial-iter 3 4*3=12)
(factorial-iter 2 12*2=24)
(factorial-iter 1 24*1=24)
24
```

----

### Versión iterativa de mi-length

¿Cómo sería la versión iterativa de mi-length?

<p style="margin-bottom:2cm;"/>

Solución:

```scheme
(define (mi-length lista)
   (mi-length-iter lista 0))

(define (mi-length-iter lista result)
   (if (null? lista)
      result
      (mi-length-iter (cdr lista) (+ result 1))))
```

----

### Procesos iterativos

- La recursión resultante es menos elegante
- Se necesita una parámetro adicional en el que se van acumulando los
  resultados parciales
- La última llamada a la recursión devuelve el valor acumulado
- El proceso resultante de la recursión es iterativo en el sentido de
  que no deja llamadas en espera ni incurre en coste espacial

---

### Fibonacci iterativo

- Cualquier programa recursivo se puede transformar en otro que genera
  un proceso iterativo.
- En general, las versiones iterativas son menos intuitivas y más
  difíciles de entender y depurar.
- Ejemplo: Fibonacci iterativo

```scheme
(define (fib n)
    (fib-iter 1 0 n))

(define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
```

----

### Triángulo de Pascal

```
1
1   1
1   2   1
1   3   3   1
1   4   6   4   1
1   5  10   10  5   1
1   6  15  20   15  6   1
1   7  21  35   35  21  7   1
             ...
```

-- Formulación matemática:

```
Pascal(n, 0) = 1  
Pascal(n, n) = 1  
Pascal(fila, columna) = Pascal(fila-1,columna-1) + Pascal(fila-1, columna)
```

La versión recursiva pura:

```scheme
(define (pascal row col)
    (cond ((= col 0) 1)
          ((= col row) 1)
          (else (+ (pascal (- row 1) (- col 1))
                   (pascal (- row 1) col) ))))
(pascal 4 2)
⇒ ?
(pascal 8 4)
⇒ ?
(pascal 27 13)
⇒ ?
```

----

### Triángulo de Pascal versión iterativa

Utilizamos enfoque iterativo: cada fila se genera a partir de la
anterior (lo hace la función `pascal-sig-fila` que recibe
como parámetro la fila anterior).

Por ejemplo:

```scheme
(pascal-sig-fila '(1 3 3 1))
; ⇒ {1 4 6 4 1}
```

Usando la función anterior definimos la función `pascal-fila` a la que
le pasamos el número de fila `n` y nos devuelve la lista de `n+1`
números que constituyen la fila `n` del triángulo de Pascal:

```
fila 0 = {1}
fila 1 = {1 1}
fila 2 = {1 2 1}
fila 3 = {1 3 3 1}
fila 4 = {1 4 6 4 1}
...
```

El código completo:

```scheme
define (pascal fila col)
   (list-ref (pascal-fila '(1) fila) col))

(define (pascal-fila lista-fila n)
   (if (= 0 n)
      lista-fila
      (pascal-fila (pascal-sig-fila lista-fila) (- n 1))))

(define (pascal-sig-fila lista-fila)
   (append '(1)
           (pascal-suma-dos-a-dos lista-fila)
           '(1)))

(define (pascal-suma-dos-a-dos lista-fila)
   (if (null? (cdr lista-fila))
      '()
      (cons (+ (car lista-fila) (car (cdr lista-fila)))
            (pascal-suma-dos-a-dos (cdr lista-fila)))))
```

----

### 1.4 Soluciones al coste de la recursión: memoization

- Una alternativa que mantiene la elegancia de los procesos recursivos
  y la eficiencia de los iterativos es la
  [memoization](http://en.wikipedia.org/wiki/Memoization). Si miramos
  la traza de `(fibonacci 4)` podemos ver que el coste está producido
  por la repetición de llamadas; por ejemplo `(fibonacci 3)` se evalúa
  2 veces.

- En programación funcional la llamada a `(fibonacci 3)` siempre va a
  devolver el mismo valor.

- Podemos guardar el valor devuelto por la primera llamada en alguna
  estructura (una lista de asociación, por ejemplo) y no volver a
  realizar la llamada a la recursión las siguientes veces.

----

### 1.4.1 Fibonacci con memoization

- Usamos los métodos procedurales `put` y `get` que implementan un
  diccionario *clave-valor*.
- No te preocupes de cómo se implementa el siguiente código, es un
  código no funcional en el que se define una estructura de datos
  mutable (un diccionario). Para que funcione
  hay que importar una librería de Scheme que permite mutar las
  parejas:

```scheme
(import (rnrs)
      (rnrs mutable-pairs))

(define lista (list 'lista-asoc))

(define (get key lista)
  (define record (assq key (cdr lista)))
  (if (not record)
      '()
      (cdr record)))

(define (put key value lista)
  (define record (assq key (cdr lista)))
  (if (not record)
      (set-cdr! lista
                (cons (cons key value)
                      (cdr lista)))
      (set-cdr! record value))
  value)
```

- La función `(put key value lista)` asocia un valor a una clave, la
 guarda en la lista (con mutación) y devuelve el valor.
 
- La función `(get key lista)` devuelve el valor de la lista asociado
  a una clave.

Ejemplos:

```scheme
(define mi-lista (list 'lista-asoc))
(put 1 10 mi-lista) ; ⇒ 10
(get 1 mi-lista) ; ⇒ 10
(get 2 mi-lista) ; ⇒ '()
```

- La función `fib-memo` realiza el cálculo de la serie de Fibonacci
  utilizando el proceso recursivo visto anteriormente y la técnica de
  memoización, en la que se consulta el valor de Fibonacci de la lista
  antes de realizar la llamada recursiva:

```scheme
(define (fib-memo n lista)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        ((not (null? (get n lista)))
         (get n lista))
        (else (put n (+ (fib-memo (- n 1) lista)
                        (fib-memo (- n 2) lista)) lista))))
```

- Podemos comprobar la diferencia de tiempos de ejecución entre esta
  versión y la anterior. El coste de la función *memoizada* es
  O(n). Frente al coste O(2^n) de la versión inicial que la hacía
  imposible de utilizar.

```scheme
(define lista (list 'lista-asoc))
(fib-memo 200 lista)
⇒ 280571172992510140037611932413038677189525
```

----

### 1.5 Recursión y gráficos de tortuga

- Último ejemplo algo distinto de los vistos hasta ahora
- Usaremos la recursión para dibujar figuras fractales usando los
  denominados *gráficos de tortuga*
- Estilo de programación **no funcional**, dibujando los distintos
  trazos de las figuras con pasos de ejecución secuenciales con la
  primitiva imperativa `begin`

> Ten cuidado con la forma especial `begin`, es una forma especial
> imperativa. No debes usarla en la implementación de ninguna función
> cuando estemos usando el paradigma funcional.

----

### 1.5.1 Gráficos de tortuga en Racket

- Los
  [gráficos de tortuga](http://en.wikipedia.org/wiki/Turtle_graphics)
  se crearon en el lenguaje de programación Logo, para enseñar a
  programar a niños y jóvenes, en los años 80.
- Se pueden utilizar los  en Racket cargando la librería `(graphics turtles)`: 

```scheme
#lang r6rs
(import (rnrs)
      (graphics turtles))
```

- Los comandos más importantes de esta librería son:
    - `(turtles #t)`: abre una ventana y coloca la tortuga en el
      centro, mirando hacia el eje X (derecha)
    - `(clear)`: borra la ventana y coloca la tortuga en el centro
    - `(draw d)`: avanza la tortuga dibujando *d* píxeles 
    - `(move d)`: mueve la tortuga *d* píxeles hacia adelante (sin dibujar)
    - `(turn g)`: gira la tortuga *g* grados (positivos: en el sentido
      contrario a las agujas del reloj)

-----

### Ejemplo `(triangulo-rectangulo)`


```scheme
(define (hipot x)
	(* x (sqrt 2)))

(define (triangulo-rectangulo x)
   (begin
      (draw x)
      (turn 90)
      (draw x)
      (turn 135)
      (draw (hipot x))
      (turn 135)))

(triangulo-rectangulo 100)
```

La función `(hipot x)` devuelve la longitud de la hipotenusa de un
triángulo rectángulo con dos lados de longitud `x`. O sea, la
expresión:

$$hipot(x) = \sqrt{x^2+x^2} = x \sqrt{2}$$

----

### Triángulo de base `w` y lados `w/2`

- El siguiente código es una variante del anterior que dibuja un
  triángulo rectángulo de base `w` y lados `w/2`.
- va a ser la figura base del triángulo de Sierpinski.

```scheme
(define (triangle w)
   (begin
      (draw w)
      (turn 135)
      (draw (hipot (/ w 2)))
      (turn 90)
      (draw (hipot (/ w 2)))
      (turn 135)))
```

----

### 1.5.2. Triángulo de Sierpinski

<img src="imagenes/sierpinski.png" style="width:400px"/>

*Triángulo de Sierpinski*

- ¿Ves alguna recursión en la figura? 
- ¿Cuál podría ser el parámetro de la función que la dibujara? 
- ¿Se te ocurre un algoritmo recursivo que la dibuje?

----

### Primera idea del algoritmo recursivo

- Podríamos construir un triángulo de Sierpinski más grande dibujando
  3 veces el mismo triángulo, pero en distintas posiciones:
    - Triángulo 1 en la posición (0,0)
    - Triángulo 2 en la posición (h/2,h/2)
    - Triángulo 3 en la posición (h,0)
- El algoritmo recursivo se basa en la misma idea, pero *hacia
  atrás*. Debemos intentar dibujar un triángulo de altura *h* situado
  en la posición *x*, *y* basándonos en 3 llamadas recursivas a
  triángulos más pequeños. En el caso base, cuando *h* sea menor que
  un umbral, dibujaremos un triángulo de lado *h* y altura *h/2*:

----

### Algoritmo recursivo 

- Para dibujar un triángulo de Sierpinski de base *h* y altura *h/2*
  debemos:
    - Dibujar tres triángulos de Sierpinsky de la mitad del tamaño del
      original (*h/2*) situadas en las posiciones *(x,y)*, *(x+h/4,
      y+h/4)* y *(x+h/2,y)*
    - En el caso base de la recursión, en el que *h* es menor que una
      constante, se dibuja un triángulo de base *h* y altura *h/2*.

Una versión del algoritmo en *pseudocódigo*:

```
Sierpinsky (x, y, h):
   if (h > MIN) {
      Sierpinsky (x, y, h/2)
      Sierpinsky (x+h/4, y+h/4, h/2)
      Sierpinsky (x+h/2, y, h/2)
   } else dibujaTriangulo (x, y, h)
```		

----

### 1.5.3 Sierpinski en Racket

```scheme
#lang r6rs
(import (rnrs)
        (graphics turtles))

(turtles #t)

(define (hipot x)
	(* x (sqrt 2)))

(define (triangle w)
   (begin
      (draw w)
      (turn 135)
      (draw (hipot (/ w 2)))
      (turn 90)
      (draw (hipot (/ w 2)))
      (turn 135)))
      
(define (sierpinski w)
   (if (> w 20)
      (begin
         (sierpinski (/ w 2))
         (move (/ w 4)) (turn 90) (move (/ w 4)) (turn -90)
         (sierpinski (/ w 2))
         (turn -90) (move (/ w 4)) (turn 90) (move (/ w 4))
         (sierpinski (/ w 2))
         (turn 180) (move (/ w 2)) (turn -180)) ;; volvemos a la posición original
      (triangle w)))
```

```scheme
(sierpinski 40)
```

```scheme
(clear)
(move -350)
(sierpinski 700)
```

----

### 1.5.4 Recursión mutua

- En la recursión mutua definimos una función en base a una segunda,
  que a su vez se define en base a la primera.
- También debe haber un caso base que termine la recursión
- Por ejemplo:
    - x es par si x-1 es impar
    - x es impar si x-1 es par
    - 0 es par

Programas en Scheme:

```scheme
(define (par? x)
   (if (= 0 x)
      #t
      (impar? (- x 1))))

(define (impar? x)
   (if (= 0 x)
      #f
      (par? (- x 1))))
```

----

### 1.5.5. Otra figura recursiva: curvas de Hilbert

- La curva de Hilbert es una curva fractal que tiene la propiedad de
  rellenar completamente el espacio

- Su dibujo tiene una formulación recursiva:

<img src="imagenes/hilbert.png" style="width:600px;"/>

La curva H3 se puede construir a partir de la curva H2. El algoritmo
recursivo se formula dibujando la curva i-ésima a partir de la curva
i-1.

----

### Algoritmo recursivo

- El algoritmo para dibujar una curva de Hilbert de orden 3 a la
  *izquierda* de la tortuga sería el siguiente (seguir los pasos con
  el dibujo):

	1. Gira la tortuga 90
	2. Dibuja una curva de orden 2 a la derecha
	3. Avanza w dibujando
	4. Gira -90
	5. Dibuja una curva de orden 2 a la izquierda
	6. Avanza w dibujando
	7. Dibuja una curva de orden 2 a la izquierda
	8. Gira -90
	9. Avanza w dibujando
	10. Dibuja una curva de orden 2 a la derecha
	11. Gira 90

- El algoritmo para dibujar a la izquierda es simétrico.

----

### Algoritmo en Scheme

```scheme
#lang r6rs
(import (rnrs)
      (graphics turtles))

(define (h-izq i long)
   (if (> i 0)
     (begin
      (turn 90)
      (h-der (- i 1) long)
      (draw  long)
      (turn -90)
      (h-izq (- i 1) long)
      (draw long)
      (h-izq (- i 1) long)
      (turn -90)
      (draw long)
      (h-der (- i 1) long)
      (turn 90))))

(define (h-der i long)
   (if (> i 0)
      (begin
        (turn -90)
        (h-izq (- i 1) long)
        (draw  long)
        (turn 90)
        (h-der (- i 1) long)
        (draw long)
        (h-der (- i 1) long)
        (turn 90)
        (draw long)
        (h-izq (- i 1) long)
        (turn -90))))
```


Podemos probarlo con distintos parámetros de grado de curva y longitud
de trazo.

Curva de Hilbert de nivel 3 con trazo de longitud 20:

```scheme
(h-izq 3 20)
```

Curva de Hilbert de nivel 6 con trazo de longitud 10:

```scheme
(clear)
(move -350)
(turn -90)
(move 350)
(turn 90)
(h-izq 6 10)
```

Curva de Hilbert de nivel 7 con trazo de longitud 5:

```scheme
(clear)
(move -350)
(turn -90)
(move 350)
(turn 90)
(h-izq 7 5))
```


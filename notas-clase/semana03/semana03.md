## Semana 3

Notas de clase de la semana 3 de LPP.


## Tema 2: Programación funcional

### Veremos hoy


- 1. El paradigma de Programación Funcional
- 2. Scheme como lenguaje de programación funcional
- 3. Tipos de datos compuestos en Scheme
- 4. Listas en Scheme
    - 4.1 Implementación de listas en Scheme
    - 4.2 Listas con elementos compuestos
    - **4.3. Funciones recursivas para construir listas**
    - **4.4. Funciones con número variable de argumentos**
- **5. Funciones como tipos de datos de primera clase**
    - **5.1. Forma especial `lambda`**
    - **5.2. Funciones como argumentos de otras funciones**
    - 5.3. Funciones que devuelven otras funciones
    - 5.4. Funciones en estructuras de datos
    - 5.5. Generalización
    - 5.6. Funciones de orden superior

----
### 2.4.3. Funciones recursivas para construir listas
----

Vamos a ver cómo se implementan de forma recursiva:

- Funciones de Scheme que trabajan con listas (para no solapar con las
  definiciones de Scheme pondremos el prefijo `mi-` en todas ellas):
    - Función `mi-list-ref`
    - Función `mi-list-tail`
    - Función `mi-append`
    - Función `mi-reverse`
- Otras funciones recursivas
    - Función `cuadrados-hasta`
    - Función `filtra-pares`
- Ejemplo completo: usamos las funciones anteriores para comprobar si
  un número es primo
    - Función `primo?`

----

### Recordatorio: Diseño de funciones recursivas

¿Cómo diseñamos una *definición recursiva* de una función? 

- Es recomendable comenzar por el **caso general**.
- Debemos buscar una forma de resolver el problema principal haciendo
  una llamada a la recursión con una versión más pequeña del problema,
  **confiar en que la recursión funciona correctamente** devolviendo
  lo que tiene que devolver y obtener con este valor devuelto la
  solución al problema principal. Es recomendable probar con un
  ejemplo concreto.
- Una vez formulado el caso general, buscamos el **caso base de la
  recursión**: el caso más sencillo posible en el que no es necesario
  hacer una llamada recursiva para devolver la solución.

----

### Función `mi-list-ref`

- La función `(mi-list-ref n lista)` devuelve el elemento `n` de una
  lista (empezando a contar por 0). Un ejemplo concreto:

```scheme
(mi-list-ref '(a b c d e f g) 4) ; ⇒ c
```

- ¿Podemos formular `(mi-list-ref '(a b c d e f g) 4)` de forma
  recursiva?:

> Para devolver el elemento 4 de lista `{a b c d e f g}`, podemos
> quitar el primer elemento de la lista (obtendremos `{b c d e f g}`)
> y devolver su elemento 3.

- En general, para cualquier `n` y cualquier lista:

> Para devolver el elemento `n` de una lista, hacemos el cdr de la
> lista y devolvemos su elemento n-1.

- Por último, formulamos el caso base de la recursión, el problema más
  sencillo que se puede resolver directamente, sin hacer una llamada
  recursiva:

> Para devolver el elemento que está en la posición 0 de una lista,
> devuelvo el `car` de la lista

- Implementación en Scheme (incluimos un segundo caso base en el que
  se intenta obtener la posición de una lista vacía; se llegaría a
  este caso si la posición que pedimos es mayor que el número de
  elementos de la lista):

```scheme
(define (mi-list-ref lista n)
    (if (= n 0) 
        (car lista)
        (mi-list-ref (cdr lista) (- n 1))))
```

----

### Función `mi-list-tail`

- La función `(mi-list-tail lista n)` devuelve la lista resultante de
  quitar n elementos de la lista original:

```scheme
(mi-list-tail '(1 2 3 4 5 6 7) 2) ; ⇒ {3 4 5 6 7}
```

- ¿Cómo se implementaría de forma recursiva?

<p style="margin-bottom:2cm;"/>

- Solución en Scheme

```scheme
(define (mi-list-tail lista n)
    (if (= n 0) 
        lista
        (mi-list-tail (cdr lista) (- n 1))))
```

----

### Función `mi-append` 

- Por ejemplo

```scheme
(mi-append '(a b c) '(d e f)) ; ⇒ {a b c d e f}
```

- Formulación recursiva del ejemplo:

```scheme
(mi-append '(a b c) '(d e f)) = (cons 'a (mi-append '(b c) '(d e f))) = 
(cons 'a {b c d e f}) = {a b c d e f}
```

- En general:

```scheme
(mi-append lista1 lista2) = (cons (car lista1) (mi-append (cdr lista1) lista2))
```

- El caso base es aquel en el que `lista1` es `null?`. En ese caso
  devolvemos `lista2`:

```scheme
(mi-append '() '(a b c)) ;⇒ '{a b c}
```

- La formulación recursiva completa queda como sigue:

```scheme
(define (mi-append l1 l2)
    (if (null? l1)
        l2
        (cons (car l1)
              (mi-append (cdr l1) l2))))
```

----

### Función `mi-reverse`

- Ejemplo

```scheme
(mi-reverse '(1 2 3 4 5 6)) ; ⇒ {6 5 4 3 2 1}
```

- La idea es sencilla: llamamos a la recursión para hacer la inversa
  del `cdr` de la lista y añadimos el primer elemento a la lista
  resultante.

- Podemos definir una función auxiliar `(añade-al-final dato lista)`
  que añade un dato al final de una lista usando `append`:

```scheme
(define (añade-al-final dato lista)
    (append lista (list dato)))
```

- La función `mi-reverse` quedaría entonces como sigue:

```scheme
(define (mi-reverse lista)
    (if (null? lista) '()
        (añade-al-final (car lista) (mi-reverse (cdr lista)))))
```

----

### Función `cuadrados-hasta`

- La función `(cuadrados-hasta x)` devuelve una lista con los
  cuadrados de los números hasta x:

```scheme
(cuadrados-hasta 5) ; ⇒ {25 16 9 4 1}
```

¿Cómo formulamos el ejemplo de forma recursiva?

<p style="margin-bottom: 3cm;"/>

```txt
(cuadrados-hasta 5) = (cons (cuadrado 5) (cuadrados-hasta 4) =
(cons 25 {16 9 4 1}) = {25 16 9 4 1}
```

- En general:

> Para construir una lista de los cuadrados hasta x, añado el cuadrado
> de x a la lista de los cuadrados hasta x-1

- El caso base de la recursión es el caso en el que x es 1, entonces
  devolvemos `{1}

- Ya podemos realizar la definición Scheme:

```scheme
(define (cuadrados-hasta x)
    (if (= x 1)
        '(1)
        (cons (cuadrado x)
              (cuadrados-hasta (- x 1)))))
```

----

### Función `filtra-pares`

- Es muy habitual recorrer una lista y comprobar condiciones de sus
  elementos, construyendo una lista con los que cumplan una
  determinada condición.

- La función `filtra-pares` construye una lista con los números pares
  de la lista que le pasamos como parámetro:

```scheme
(filtra-pares '(1 2 3 4 5 6)) ;⇒ {2 4 6}
```

¿Cómo la definimos de forma recursiva?

<p style="margin-bottom:3cm;"/>


- Solución en Scheme

```scheme
(define (filtra-pares lista)
    (cond
        ((null? lista) '())
        ((even? (car lista))
        (cons (car lista) (filtra-pares (cdr lista))))
        (else (filtra-pares (cdr lista)))))
```

----

### Ejemplo final: Función `primo?`

- El uso de listas es uno de los elementos fundamentales de la
  programación funcional.

- Veamos un algoritmo sencillo que permite calcular si un número es
  primo, usando alguna de las funciones anteriores sobre
  listas. Calcularemos la lista de divisores del número y
  comprobaremos si su longitud es dos:

```scheme
(divisores 8) ;⇒ {1 2 4 8} longitud = 4, no primo
(divisores 9) ;⇒ {1 3 9} longitud = 3, no primo
(divisores 11) ;⇒ {1 11} longitud = 2, primo
```

- En Scheme:

```scheme
(define (primo? x)
    (=  2 
    (length (divisores x))))
```

----

### Función recursiva `(lista-hasta x)`


- La función `(lista-hasta x)` devuelve una lista de números 1..x:

```scheme
(lista-hasta 2) ;⇒ {1 2}
(lista-hasta 10) ;⇒ {1 2 3 4 5 6 7 8 9 10}
```

- Implementación recursiva:


```scheme
(define (lista-hasta x)
    (if (= x 0)
        '()
        (cons x (lista-hasta (- x 1)))))
```


----

### Función `(divisor? x y)`

```scheme
(define (divisor? x y)
      (= 0 (mod y x)))
```

----

### Función recursiva `(filtra-divisores lista x)`

- Función que filtra aquellos números `lista` que son divisores del número `x`

```scheme
(define (filtra-divisores lista x)
   (cond
      ((null? lista) '())
      ((divisor? (car lista) x) (cons (car lista)
                                      (filtra-divisores (cdr lista) x)))
      (else (filtra-divisores (cdr lista) x))))
```


----


### Función `(divisores x)` 


- Se puede implementar de una forma muy sencilla:

```scheme
(define (divisores x)
    (filtra-divisores (lista-hasta x) x))
```

- Por ejemplo, para calcular los divisores de 10:

```scheme
(filtra-divisores '(1 2 3 4 5 6 7 8 9 10) 10) ;⇒ {1 2 5 10}
```

- Una vez definida esta función, ya puede funcionar correctamente la función `primo?`

----
### 2.4.4. Funciones con número variable de argumentos
----

- Definición de número variable de argumentos con la notación de
  punto:

```scheme
(define (funcion-dos-o-mas-args x y . lista-args) 
    <cuerpo>)
```

- Podemos llamar a la función anterior con dos o más argumentos:

```scheme
(funcion-dos-o-mas-args 1 2 3 4 5 6)
```
	
- En la llamada, los parámetros `x` e `y` tomarán los valores 1 y 2.
- El parámetro `lista-args` tomará como valor una lista con los
  argumentos restantes `(3 4 5 6)`.

<p style="margin-bottom:2cm;"/>

- También es posible permitir que todos los argumentos sean opcionales
  no poniendo ningún argumento antes del punto::

```scheme
(define (funcion-cualquier-numero-args . lista-args) 
    <cuerpo>)
```
	
- Ejemplo:

```scheme
(define (mi-suma x y . lista-nums)
    (if (null? lista-nums)
        (+ x y)
        (+ x (+ y (suma-lista lista-nums)))))
```

<p style="margin-bottom:2cm;"/>

----

### 5. Funciones como tipos de datos de primera clase

----

### Una función es un bloque de código con varias entradas y una salida

Función que eleva al cuadrado un número:

<img src="./imagenes/funcion-cuadrado.png" style="width: 80px;"/>

Función que suma dos parejas:

<img src="./imagenes/esquema-suma-parejas.png" style="width: 200px;"/>


----

### Las funciones son objetos de primera clase de un lenguaje

Recordemos que un tipo de primera clase es aquel que:

1. Puede ser asignado a una variable
2. Puede ser pasado como argumento a una función
3. Puede ser devuelto como resultado de una invocación a una función
4. Puede ser parte de un tipo mayor

Con funciones:

1. Una función se puede asignar a una variable
2. Una función se puede pasar como parámetro de otras funciones 
3. Una función se puede devolver como resultado de una invocación a otra función
4. Una función se puede guardar en tipos de datos compuestos como listas

Es una característica de muchos lenguajes multi-paradigma con
características funcionales como
[JavaScript](http://helephant.com/2008/08/19/functions-are-first-class-objects-in-javascript/),
[Python](https://thenewcircle.com/static/bookshelf/python_fundamentals_tutorial/functional_programming.html),
[Swift](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html)
o incluso en la última versión de Java,
[Java 8](http://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html),
(donde se denominan *expresiones lambda*).

----

### 5.1 Forma especial `lambda`

----

### Sintaxis de la forma especial `lambda`

La sintaxis de la forma especial `lambda` es:

```
(lambda (<arg1> ... <argn>) 
    <cuerpo>)
```

El cuerpo del lambda define un *bloque de código* y sus argumentos son
los parámetros necesarios para ejecutar ese bloque de código. Llamamos
a la función resultante una *función anónima*.

Una función anónima que suma dos parejas:

```scheme
(lambda (p1 p2)
    (cons (+ (car p1) (car p2))
          (+ (cdr p1) (cdr p2))))
```

Una función anónima que devuelve el mayor de dos números:

```scheme
(lambda (a b)
    (if (> a b)
        a
        b))
```

----

### Semántica de la forma especial `lambda`

- La invocación a la forma especial `lambda` construye una función
  anónima en tiempo de ejecución.

```scheme
(lambda (x) (* x x))
; ⇒ #<procedure>
```

- El procedimiento construido es un bloque de código que devuelve el
  cuadrado de un número.

- ¿Qué podemos hacer con este procedimiento? 

----

### Podemos asignar el procedimiento a un identificador (símbolo)

```scheme
(define f (lambda (x) (* x x)))
```

- Se evalúa la expresión lambda y el resultado (un procedimiento) se
  guarda en `f`
- Si escribimos `f` en el intérprete, Scheme lo evalúa y muestra el
  procedimiento:

```scheme
f ; ⇒ #<procedure:f>
```

Podemos usar el identificador `f` de la forma que habitualmente
invocamos a una función:

```scheme
(cuadrado 3) ; ⇒ 9
```

----

### Podemos invocar a la función anónima directamente


```scheme
((lambda (x) (* x x)) 3) ; ⇒ 9
```

La llamada a `lambda` crea un procedimiento y el paréntesis a su
izquierda lo invoca con el parámetro 3:

```scheme
((lambda (x) (* x x)) 3) => (#<procedure> 3) ; ⇒ 9
```

- Es importante remarcar que con `lambda` estamos creando una función
  en *tiempo de ejecución*.

----

### Expresiones lambda en distintos lenguajes de programación


**Java 8**

```java
Integer x -> {x*x}
```

**Scala**

```scala
(x:Int) => {x*x}
```

**Objective C**

```objetive-c
^int (int x)
{
   x*x
};
```

**Swift**

```swift
{ (x: Int) -> Int in return x*x }
```

----

### Identificadores y funciones

- En Scheme una función está ligada al símbolo que define su nombre:

```scheme
+ ; ⇒ <procedure:+>
```

- Podemos asignar funciones ya existentes a nuevos identificadores
  usando `define`, como en el ejemplo siguiente:

```scheme
+ ;⇒ <procedure:+>
(define suma +)
(suma 1 2 3 4) ; ⇒ 10
```

<img src="./imagenes/suma.png" style="width:100px;"/>

----

### La forma especial `define` para definir una función no es más que azucar sintáctico

La forma especial `define`:

```
(define (<nombre> <args>)
    <cuerpo>)
```

siempre se convierte internamente en:

```
(define <nombre> 
    (lambda (<args>)
        <cuerpo>))
```

Por ejemplo

```scheme
(define (cuadrado x)
    (* x x))
```

es equivalente a:

```scheme
(define cuadrado 
    (lambda (x) (* x x)))
```

----

### Predicado `procedure?`

- Podemos comprobar si algo es una función utilizando el predicado de
  Scheme `procedure?`.

Por ejemplo:

```scheme
(procedure? (lambda (x) (* x x)))
; ⇒ #t
(define suma +)
(procedure? suma)
; ⇒ #t
(procedure? '+)
; ⇒ #f
```

----

### 5.2 Funciones argumentos de otras funciones 

Veamos más ejemplos de funciones que reciben otras funciones.

----

### Función `aplica-2` 

- La función `aplica-2` que toma dos funciones `f` y `g` y un
  argumento `x` y devuelve el resultado de aplicar `f` a lo que
  devuelve la invocación de `g` con `x`:

```scheme
(define (aplica-2 f g x)
   (f (g x)))
```

¿Ejemplos de invocación?

<p style="margin-bottom:3cm;"/>

```schem
(define (suma-5 x)
   (+ x 5))
(define (doble x)
   (+ x x))
(aplica-2 suma-5 doble 3)
; ⇒ 11
```

----

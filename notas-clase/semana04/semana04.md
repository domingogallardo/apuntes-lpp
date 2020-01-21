
## Semana 4

Notas de clase de la semana 4 de LPP.


## Tema 2: Programación funcional 

### Veremos hoy

- 1 El paradigma de Programación Funcional
- 2 Scheme como lenguaje de programación funcional
- 3 Tipos de datos compuestos en Scheme
- 4 Listas en Scheme
- 5 **Funciones como tipos de datos de primera clase**
    - 5.1 Forma especial `lambda`
    - 5.2 **Funciones como argumentos de otras funciones**
	- 5.3 **Funciones que devuelven funciones**
    - 5.4 **Funciones en estructuras de datos**
    - 5.5 **Funciones de orden superior**

----

### Ejemplo de uso de parámetros de tipo función para generalizar

- La posibilidad de pasar funciones como parámetros de otras es una
  poderosa herramienta de abstracción. Veamos un ejemplo.

- Supongamos que queremos calcular el sumatorio de `a` hasta
  `b`. ¿Cómo lo haríamos de forma recursiva?

<p style="margin-bottom:3cm;"/>

```scheme
(define (sum-x a b)
    (if (> a b)
        0
        (+ a (sum-x (+ a 1) b))))

(sum-x 1 10) ; ⇒ 55
```

- Supongamos ahora que queremos calcular el sumatorio de `a` hasta `b`
  **sumando los números al cuadrado**. ¿Cómo lo haríamos?


<p style="margin-bottom:3cm;"/>

```scheme
(define (sum-cuadrado-x a b)
    (if (> a b)
        0
        (+ (* a a) (sum-cuadrado-x (+ a 1) b))))

(sum-cuadrado-x 1 10) ; ⇒ 385
```

- ¿Y el sumatorio de `a` hasta `b` **sumando los cubos**?

<p style="margin-bottom:3cm;"/>

```schehem
(define (sum-cubo-x a b)
    (if (> a b)
        0
        (+ (* a a a) (sum-cubo-x (+ a 1) b))))

(sum-cubo-x 1 10) ; ⇒ 3025
```

- El código de las tres funciones anteriores es muy similar.
- Podemos generalizarlo definiendo una función que haga la recursión y
  que reciba como parámetro otra función que se aplica a los números.
- Podemos definir una función genérica `sum-f-x` que generaliza las
  tres funciones anteriores: el sumatorio desde `a` hasta `b` de
  `f(x)`:

```scheme
(define (sum-f-x f a b)
    (if (> a b)
        0
        (+ (f a) (sum-f-x f (+ a 1) b))))
```

Las funciones anteriores son casos particulares de esta función que
las generaliza. Por ejemplo, para calcular el sumatorio desde 1 hasta
10 de `x` al cubo:

```scheme
(define (cubo x)
    (* x x x))

(sum-f-x cubo 1 10) ; ⇒ 3025
```

- O podemos sumar la expresión (n/(n-1)) para todos los números del 2
  al 100. Usamos una expresión lambda:
  
```scheme
(sum-f-x (lambda (n) (/ n (- n 1))) 2 100)
```

----

### 5.4. Funciones que devuelven funciones

- Un objeto de primera clase puede ser devuelto por una función: es
  posible definir funciones que devuelvan otras funciones.
- Característica fundamental del paradigma funcional, no presente en
  lenguajes que no son funcionales (como C, C++ o Java (antes de Java
  8)).
- La función devuelta se crea en tiempo de ejecución, durante la
  invocación a la función principal.
- La función devuelta se denomina **clausura** (_closure_ en inglés).

----

### Ejemplo 1: función `sumador`

- Definimos una función constructora `(construye-sumador k)` que crea
  en su ejecución una función sumadora:


```scheme
(define (construye-sumador k)
   (lambda (x)
       (+ x k)))
```

- La función constructora `construye-sumador` devuelve un procedimiento: 

```scheme
(construye-sumador 10) ; => #<procedure>
```

- Por ejemplo, si le pasamos 10, como parámetro devolverá una función
de un argumento que sumará 10 a ese argumento:


```scheme
(define f (construye-sumador 10))
(f 3) ; => 13
```

También:

```scheme
((construye-sumador 10) 3) ; => 13
```

- Dependiendo del parámetro que le pasemos a la función constructora
  obtendremos una función sumadora que sume un número u otro. Por
  ejemplo para obtener una función sumadora que suma 100:
  
```scheme
(define g (construye-sumador 100))
(g 3) ; => 103
```

- ¿Cómo funciona la clausura?

```scheme
(define (construye-sumador k)
   (lambda (x)
       (+ x k)))
(define g (construye-sumador 100))
(g 3) ; => 103
```

- Cuando invocamos a `construye-sumador` con un valor concreto para
  `k` (por  ejemplo 100), queda vinculado el valor de 100 al parámetro
  `k` en el ámbito local de la función.
- En este ámbito local la expresión lambda crea una función. Esta
  función creada en el ámbito local **captura** este ámbito local, con
  sus variables y sus valores (en este caso la variable `k` y su valor
  100).
- Cuando se invoca a la función desde fuera (cuando llamamos a `g` en
  el ejemplo) se ejecuta el cuerpo de la función `(+ x k)` con `x`
  valiendo el parámetro (3) y el valor de `k` se obtiene del ámbito
  capturado (100).

----

### Ejemplo 2: función `componedor`

Una función que recibe otras dos funciones de un argumento y devuelve
otra función que realiza la composición de ambas:

```scheme
(define (componedor f g)
    (lambda (x)
	    (f (g x))))
```

Un ejemplo de su uso:

```scheme
(define h (componendor doble cuadrado))
(h 4) ; => 32
```

----

### Usos reales de las funciones constructoras ###

- Las funciones que construyen otras funciones permiten un alto nivel de
configuración y de generalización en la programación. 
- Un par de ejemplos de uso en problemas reales:

1. Posibilidad de definir funciones configurables sin tener que
  depender de variables globales o parámetros adicionales.
2. Posibilidad de modificar funciones ya construidas, añadiéndoles condiciones
  a comprobar antes o cálculos a realizar después.


-----

### Ejemplo de funciones constructoras para definir funciones configurables ###

- Supongamos que queremos definir una función `logger` a la que le
llamemos con una cadena para que imprima un mensaje de log.

- Queremos poder configurar el prefijo del mensaje de log, de forma
  que sólo tengamos que definirlo una vez, al crear la función
  `logger`. Después llamaremos a la función `logger` pasándole
  únicamente el mensaje de log.

- Lo podemos hacer con la siguiente función constructora:

```scheme
(define (construye-logger str-prefijo)
  (lambda (x)
    (display (string-append str-prefijo x "\n"))))
```

- Por ejemplo, definimos distintos loggers y los probamos:

```scheme
(define logger (construye-logger "Módulo acceso red: "))

(logger "Error en el acceso a BD")
(logger "Intentando conexión a red")
; Módulo acceso red: Error en el acceso a BD
; Módulo acceso red: Intentando conexión a red

(define logger2 (construye-logger "Módulo correo electrónico: "))

(logger2 "Enviando e-mail")
(logger2 "Problemas al recibir mensaje")
; Módulo correo electrónico: Enviando e-mail
; Módulo correo electrónico: Problemas al recibir mensaje

(define logger3 (construye-logger "Módulo acceso a SO: "))

(logger3 "Intentando abrir fichero")
(logger3 "Sin espacio de memoria")
; Módulo acceso a SO: Intentando abrir fichero
; Módulo acceso a SO: Sin espacio de memoria
```


---

### Ejemplo de funciones constructoras para modificar funciones ya construidas ###

- Recordemos la función `divisores`:

```scheme
(define (lista-hasta x)
   (if (= x 0)
      '()
      (cons x (lista-hasta (- x 1)))))

(define (divisor? x y)
      (= 0 (mod y x)))

(define (filtra-divisores lista x)
   (cond
      ((null? lista) '())
      ((divisor? (car lista) x) (cons (car lista)
                                      (filtra-divisores (cdr lista) x)))
      (else (filtra-divisores (cdr lista) x))))

(define (divisores x)
   (filtra-divisores (lista-hasta x) x))
```

- Un problema de la función anterior `divisores` es que si le pasamos un
número negativo entra en un bucle infinito.

- Podemos definir la siguiente función general a la que le pasamos una
  función de un argumento `f` y devuelve la función f "segura" a la que sólo
  se va a invocar si el parámetro es mayor o igual que 0:


```scheme
(define (construye-segura-menor-cero f)
  (lambda (x)
    (if (>= x 0)
        (f x)
        'error)))
```

- Podemos entonces "segurizar" la función `divisores` 

```scheme
(define divisores-segura (construye-segura-menor-cero divisores))
(divisores-segura 10) ; => {10 5 2 1}
(divisores-segura -10) ; => error
```

- La función `(construye-segura-menor-cero f)` se puede aplicar para
  "segurizar" cualquier función, no sólo `divisores`:

```scheme
(define sqrt-segura (construye-segura-menor-cero sqrt))
(sqrt-segura 100) ; => 10
(sqrt-segura -100) ; => error
```

- Se podría generalizar aún más la función "segurizadora"  haciendo
  que la condición a cumplir por el número sea otra función que
  también pasamos:
  
```scheme
(define (construye-segura condicion f)
  (lambda (x)
    (if (condicion x)
        (f x)
        'error)))
```

- La forma de definir una función `divisores` segura con esta nueva
  función sería:
  
```scheme
(define divisores-segura2 (construye-segura (lambda (x) (>= x 0)) divisores))
```

### 5.4 Funciones en estructuras de datos

----

### Construcción de listas de funciones

Para construir una lista de funciones debemos llamar a `list` con las
funciones como parámetros

```scheme
(define lista (list cuadrado suma-1 doble))
lista
; ⇒ {#<procedure:cuadrado>  #<procedure:suma-1>  #<procedure:doble>}
```

También podemos evaluar una expresión lambda y añadir el procedimiento
resultante:

```scheme
(define lista2 (cons (lambda (x) (+ x 5)) lista))
lista2
; ⇒ {#<procedure> #<procedure:cuadrado> #<procedure:suma-1> #<procedure:doble>}
```

----

### Invocación a funciones de una lista

- Una vez creada una lista con funciones, ¿cómo podemos invocar a
  alguna de ellas?.
- Debemos tratarlas de la misma forma que tratamos cualquier otro dato
  guardado en la lista, las recuperamos con las funciones `car` o
  `list-ref` y las invocamos.

- Por ejemplo, para invocar a la primera función de `lista2`:

```
((car lista2) 10) ; ⇒ 15
```

----

### Ejemplo de función que trabaja con listas de funciones: `aplica-funcs`

- Veamos un ejemplo de una función `(aplica-funcs lista-funcs x)` que
  recibe una lista de funciones en el parámetro `lista-funcs` y las
  aplica todas al número que pasamos en el parámetro `x`.

- Por ejemplo, si construimos una lista con las funciones `cuadrado`,
  `cubo` y `suma-1`:

```scheme
(define lista (list cuadrado cubo suma-1))
```

la llamada a `(aplica-funcs lista 5)` devolverá :

```scheme
(cuadrado (cubo (suma-1 5)) ; ⇒ 46656
```

- ¿Cómo implementamos `aplica-funcs` de forma recursiva?

<p style="margin-bottom:3cm;"/>


Ejemplo de recursión:

```
(aplica-funcs (cuadrado cubo suma-1) 5) => (cuadrado (aplica-funcs (cubo suma-1) 5))
=> (cuadrado 216) => 46656
```

Caso general de la recursión:

```scheme
(aplica-funcs lista-funcs x) => ((car lista-funcs) (aplica-funcs (cdr lista-funcs) x))
```

Caso base:

```scheme
(if (null? (cdr lista-funcs)) ; la lista de funciones solo tiene una función
    ((car lista-funcs) x) ; invocamos a la función con el parámetro x
    ...
```

Implementación completa:

```scheme
(define (aplica-funcs lista-funcs x)
    (if (null? lista-funcs)
        x
        ((car lista-funcs)
            (aplica-funcs (cdr lista-funcs) x))))
```

Un ejemplo de uso:

```scheme
(define lista-funcs (list (lambda (x) (* x x))
                          (lambda (x) (* x x x))
                          (lambda (x) (+ x 1))))
(aplica-funcs lista-funcs 5)
⇒ 46656
```

----

### 5.5. Funciones de orden superior

> Las funciones de orden superior (*higher order functions* en inglés)
> son funciones que reciben como parámetro otras funciones.

----


### ¿Qué es una función de orden superior?

- Llamamos funciones de orden superior (*higher order functions* en
  inglés) a las funciones que toman otras como parámetro o devuelven
  otra función. Permiten generalizar soluciones con un alto grado de
  abstracción.

- Los lenguajes de programación funcional como Scheme, Scala o Java 8
  tienen ya predefinidas algunas funciones de orden superior que
  permiten tratar listas o *streams* de una forma muy concisa y
  compacta.

Veremos:

- `map`
- `filter`
- `exists`
- `for-all`
- `fold-right` y `fold-left`

De alguna de las funciones veremos también su implementación
recursiva.

Terminaremos viendo cómo la utilización de funciones de orden
superior es una excelente herramienta de la programación funcional
que permite hacer código muy conciso y expresivo.

> La combinación de funciones de nivel superior con listas es una de
> las características más potentes de la programación funcional.


----

### Función `map`

- La función `(map funcion lista)` recibe otra función y una lista. Devuelve la lista
  resultante de aplicar la función a todos los elementos de la lista.

- Ejemplos:

```scheme
(map cuadrado '(1 2 3 4 5))
; ⇒ (1 4 9 25)

(map (lambda (str) (string-append "Hola-" str)) '("me" "llamo" "Ana"))
; => {"Hola-me" "Hola-llamo" "Hola-Ana"}

(map (lambda (s) 
        (string-length (symbol->string s))) '(Esta es una lista de símbolos))
; => {4 2 3 5 2 8}
```

> CONSEJO DE USO  
> La función `map` recibe una lista de *n* elementos y devuelve otra
> de *n* elementos transformados.


- ¿Cómo se podría implementar `map` de forma recursiva?

<p style="margin-bottom:3cm;"/>

----

### Implementación de `map`

Llamamos a la función `mi-map`. La implementación es la siguiente:

```
(define (mi-map f lista)
    (if (null? lista)
        '()
        (cons (f (car lista))
              (mi-map f (cdr lista)))))
```

----

### Función `filter`

- La función `(filter predicado lista)` toma como parámetro un
  predicado y una lista y devuelve como resultado los elementos de la
  lista que cumplen el predicado.

- Ejemplos:

```scheme
(filter even? '(1 2 3 4 5 6 7 8))
; ⇒ (2 4 6 8)

(filter (lambda (s) 
           (>= (string-length (symbol->string s)) 4))
           '(Esta es una lista de símbolos))
; => {Esta lista símbolos}

(filter (lambda (pareja)
            (>= (car pareja) (cdr pareja))) '((10 . 4) (2 . 4) (8 . 8) (10 . 20)))
; ⇒ {{10 . 4} {8 . 8}}
```


> CONSEJO DE USO  
> La función `filter` recibe una lista de *n* elementos y devuelve
> otra de con *n* o menos elementos originales filtrados por una
> condición.


- ¿Cómo se podría implementar `mi-filter` de forma recursiva?

<p style="margin-bottom:3cm;"/>

```scheme
(define (mi-filter pred lista)
  (cond
    ((null? lista) '())
    ((pred (car lista)) (cons (car lista)
                              (mi-filter pred (cdr lista))))
    (else (mi-filter pred (cdr lista)))))
```

----

### Función `exists`

La función de orden superior `exists` recibe un predicado y una lista
y comprueba si algún elemento de la lista cumple ese predicado.

Ejemplos:

```scheme
(exists even? '(1 2 3 4 5 6)) ; ⇒ #t

(exists (lambda (x)
             (> x 10)) '(1 3 5 8)) ; ⇒ #f
```

----

### Función `for-all`

La función de orden superior `for-all` recibe un predicado y una lista
y comprueba que todos los elementos de la lista cumplen ese predicado.

Ejemplos:

```scheme
(for-all even? '(2 4 6)) ; ⇒ #t

(for-all (lambda (x)
             (> x 10)) '(12 30 50 80)) ; ⇒ #t
```


----

### Función `fold-right`

- La función `(fold-right func base lista)` permite recorrer una lista
  aplicando una función binaria de forma acumulativa de derecha a
  izquierda a sus elementos.
- El nombre `fold` significa *plegado*.
- En Scheme existe también la función `fold-left` que aplica la
  función de izquierda a derecha. Utilizaremos `fold-right` para
  explicar este tipo de funciones y después veremos rápidamente algún
  ejemplo con `fold-right`.

Veamos cómo funciona.

- Suponemos una función `f` de dos argumentos: 

```scheme
(f dato resultado)
```

- Llamamos a esta función **función de plegado**.
 
- La función `(fold-right f base lista)` aplica la función de plegado
  **de derecha a izquierda**, empezando por el último elemento de la lista
  y aplicando sucesivamente la función `f` a los resultados que se van
  obteniendo.

- Por ejemplo, supongamos que la función de plegado se una función que
  suma dos valores.

```scheme
(define (suma dato resultado)
    (+ dato resultado))
```

- Llamamos a los parámetros `dato` y `resultado` para remarcar que el
  primer parámetro se va a coger de la lista y el segundo del
  resultado calculado.

- Veamos qué pasa cuando hacemos un `fold-right` con esta función
  suma y la lista '(1 2 3) y con el número 0 como base:
  
```scheme
(fold-right suma 0 '(1 2 3)) ; => 6
```

- La función `suma` se va a ir aplicando a todos los elementos de la
  lista de derecha a izquierda, empezando por el valor base (0) y el
  último elemento de la lista (3) y cogiendo el resultado obtenido y
  utilizándolo como nuevo parámetro `resultado` en
  la siguiente llamada.

- En concreto, la secuencia de llamadas a la función `suma` serán las siguientes:

```scheme
(suma 3 0) ; => 3
(suma 2 3) ; => 5
(suma 1 5) ; => 6
```

Otro ejemplo de uso:

```scheme
(fold-right string-append "****" '("hola" "que" "tal")) ; ⇒ "holaquetal****"
```

- En este caso la secuencia de llamadas a `string-append` que se van a
  producir son:
  
```scheme
(string-append "tal" "****") ; => "tal****"
(string-append "que" "tal****") ; => "quetal****"
(string-append "hola" "quetal****") ; => "holaquetal****"
```

Otros ejemplos:

```scheme
(fold-right (lambda (x y) (* x y)) 1 '(1 2 3 4 5 6 7 8)) ; ⇒ 40320
(fold-right cons '() '(1 2 3 4)) ; ⇒ {1 2 3 4}
```

Un último ejemplo:

```scheme
(define (suma-parejas lista-parejas)
    (fold-right (lambda (pareja resultado)
                   (+ (car pareja) (cdr pareja) resultado)) 0 lista-parejas))

(suma-parejas (list (cons 3 6) (cons 2 9) (cons -1 8) (cons 9 3))) ; ⇒ 39
```

### Función `fold-left` ###

La función `fold-left` es similar a `fold-right` con la diferencia de
que la secuencia de aplicaciones de la función de plegado se hace de
izquierda a derecha en lugar de derecha a izquierda.

La función de plegado también cambia, porque tiene invertidos sus
argumentos:

```scheme
(f resultado dato)
```

Por ejemplo:

```scheme
(fold-left - 0 '(1 2 3)) ; =>
```

La secuencia de llamadas a `-` son:

```scheme
(- 0 1) ; => -1
(- -1 2) ; => -3
(- -3 3) ; => -6
```


> CONSEJO DE USO  
> Las funciones `fold-right` o `fold-left` reciben una lista de datos y devuelven un único resultado


----

### Implementación recursiva

La implementación recursiva en Scheme de la función `fold-right` es la siguiente:

```scheme
(define (mi-fold-right func base lista)
  (if (null? lista)
      base
      (func (car lista) (mi-fold-right func base (cdr lista)))))
```

Y la de la función `fold-left`:

```scheme
(define (mi-fold-left func base lista)
  (if (null? lista)
      base
      (func (mi-fold-left func base (cdr lista)) (car lista))))
```


----

### Uso de funciones de orden superior y expresiones lambda

----

### Función `(suma-n n lista)`

- Supongamos que queremos definir una función `(suma-n n lista)` que
  devuelve la lista resultante el resultado de sumar un número `n` a
  todos los elementos de una lista.

- Podemos hacerlo de forma recursiva:

```scheme
(define (suma-n n lista)
    (if (null? lista)
        '()
        (cons (+ (car lista) n)
              (suma-n n (cdr lista)))))
```

Funciona de la siguiente manera:

```scheme
(suma-n '(1 2 3 4) 10)
; ⇒ (11 12 13 14)
```

¿Podemos implementar `suma-n` usando una llamada a `map`?

- Sí, pasándole a map una función construida con una expresión lambda
  en la que se usa el parámetro `n`:

```scheme
(define (suma-n n lista)
    (map (lambda (x) (+ x n)) lista))
```

¿Cómo funciona?:

```
(suma-n 10 '(1 2 3 4)) => (map #<prodedure-que-suma-10-a-x> (1 2 3 4)) =>  (11 12 13 14)
```

----


### Composición de funciones de orden superior

- En la composición de funciones de orden superior, la lista 
resultante de la salida de una función se utiliza como entrada de la
siguiente. 


- Supongamos que queremos implementar una función que sume un número
`n` a todos los elementos de una lista (igual que la anterior) y
después que sume todos los elementos resultantes.

¿Cómo lo haríamos? (podemos reutilizar el código del ejemplo anterior)

<p style="margin-bottom:3cm;"/>

```scheme
(define (suma-n-total n lista)
   (fold-right + 0
       (map (lambda (x) (+ x n)) lista)))
```

```scheme
(suma-n-total 100 '(1 2 3 4))  => 410
```

- Otro ejemplo: queremos contar aquellas parejas cuya suma de ambos números
es mayor que un umbral (por ejemplo, 10).

```scheme
(define lista-parejas (list (cons 1 2) 
                            (cons 3 8) 
                            (cons 2 3) 
                            (cons 9 6)))
(cuenta-mayores-que 10 lista-parejas) ; => 2
```

- ¿Cómo se implementaría componiendo funciones de orden superior?:


```scheme
(define (cuenta-mayores-que n lista-parejas)
  (length
   (filter (lambda (x)
             (> x n)) (map (lambda (pareja)
                             (+ (car pareja) (cdr pareja))) lista-parejas))))
```								 

----

### Función `(contienen-letra? caracter lista-pal)`

- Queremos definir la función `(contienen-letra
  caracter lista-pal)` que devuelve las palabras de una lista que
  contienen un determinado carácter, usando la función `filter` y
  alguna función auxiliar

Por ejemplo:

```scheme
(contienen-letra #\a '("En" "un" "lugar" "de" "la" "Mancha")) ⇒ ("lugar" "la" "Mancha")
```
- Necesitamos el predicado auxiliar `(letra-en-pal? caracter pal)` que
  comprueba si una cadena contiene un carácter. Por ejemplo:

```
(letra-en-pal? #\a "Hola") ⇒ #t
(letra-en-pal? #\a "Pepe") ⇒ #f
```

- ¿Lo podemos implementar obteniendo una lista de caracteres a partir
  de la cadena y usando la función `exists`?

<p style="margin-bottom:3cm;"/>

```scheme
(define (letra-en-pal? caracter palabra)
    (exists (lambda (c) 
                (equal? c caracter)) (string->list palabra)))
```

- Ahora ya podemos implementar `contienen-letra` usando otra vez la
  función de orden superior `filter` y la función anterior en la
  expresión lambda que hace el filtrado:

```scheme
(define (contienen-letra caracter lista-pal)
   (filter (lambda (pal)
              (letra-en-pal? caracter pal)) lista-pal))
```


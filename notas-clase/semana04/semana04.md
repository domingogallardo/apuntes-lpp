
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

<p style="margin-bottom:3cm;"></p>

- Solución:

    ```racket
    (define (sum-x a b)
        (if (> a b)
            0
            (+ a (sum-x (+ a 1) b))))

    (sum-x 1 10) ; ⇒ 55
    ```

- Supongamos ahora que queremos calcular el sumatorio de `a` hasta `b`
  **sumando los números al cuadrado**. ¿Cómo lo haríamos?


<p style="margin-bottom:3cm;"></p>

- Solución:

    ```racket
    (define (sum-cuadrado-x a b)
        (if (> a b)
            0
            (+ (* a a) (sum-cuadrado-x (+ a 1) b))))

    (sum-cuadrado-x 1 10) ; ⇒ 385
    ```

- ¿Y el sumatorio de `a` hasta `b` **sumando los cubos**?

<p style="margin-bottom:3cm;"></p>

- Solución:

    ```racket
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

    ```racket
    (define (sum-f-x f a b)
        (if (> a b)
            0
            (+ (f a) (sum-f-x f (+ a 1) b))))
    ```

- Las funciones anteriores son casos particulares de esta función que
  las generaliza. Por ejemplo, para calcular el sumatorio desde 1
  hasta 10 de `x` al cubo:

    ```racket
    (define (cubo x)
        (* x x x))

    (sum-f-x cubo 1 10) ; ⇒ 3025
    ```

- O podemos sumar la expresión (n/(n-1)) para todos los números del 2
  al 100. Usamos una expresión lambda:
  
    ```racket
    (sum-f-x (lambda (n) (/ n (- n 1))) 2 100)
    ```

----

### Funciones que devuelven funciones

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


    ```racket
    (define (construye-sumador k)
       (lambda (x)
           (+ x k)))
    ```

- La función constructora `construye-sumador` devuelve un procedimiento: 

    ```racket
    (construye-sumador 10) ; ⇒ #<procedure>
    ```

- Por ejemplo, si le pasamos 10, como parámetro devolverá una función
de un argumento que sumará 10 a ese argumento:


    ```racket
    (define f (construye-sumador 10))
    (f 3) ; ⇒ 13
    ```

- También:

    ```racket
    ((construye-sumador 10) 3) ; ⇒ 13
    ```

- Dependiendo del parámetro que le pasemos a la función constructora
  obtendremos una función sumadora que sume un número u otro. Por
  ejemplo para obtener una función sumadora que suma 100:
  
    ```racket
    (define g (construye-sumador 100))
    (g 3) ; ⇒ 103
    ```

- ¿Cómo funciona la clausura?

    ```racket
    (define (construye-sumador k)
       (lambda (x)
           (+ x k)))
    (define g (construye-sumador 100))
    (define f (construye-sumador 50))
    (g 3) ; ⇒ 103
    (f 3) ; ⇒ 50
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

### Ejemplo 2: función `composicion`

- Una función que recibe otras dos funciones de un argumento y
  devuelve otra función que realiza la composición de ambas:

    ```racket
    (define (composicion f g)
        (lambda (x)
            (f (g x))))
    ```

- Un ejemplo de su uso:

    ```racket
    (define (doble x) (+ x x))
    (define (cuadrado x) (* x x))
    
    (define h (composicion doble cuadrado))
    (h 4) ; ⇒ 32
    ```

----


### Ejemplo 3: función `construye-segura`

- Recordemos la función `lista-hasta`:

    ```racket
    (define (lista-hasta x)
       (if (= x 0)
          '()
          (cons x (lista-hasta (- x 1)))))
    ```

- Si le pasamos un número negativo entra en un bucle infinito.

- Definimos la función `(construye-segura condicion f) ` que recibe
  dos funciones: un predicado y otra función, ambos de 1
  argumento. Devuelve otra función en la que sólo se llamará a `f` si
  el argumento cumple la `condicion`.

    ```racket
    (define (construye-segura condicion f)
      (lambda (x)
        (if (condicion x)
            (f x)
            'error)))
    ```

- Podemos entonces construir una función segura a partir de la función
  `lista-hasta` en la que se devuelva `error` si el argumento es un
  número negativo:
  
    ```racket
    (define lista-hasta-segura
       (construye-segura (lambda (x) (>= x 0)) lista-hasta))
    (lista-hasta-segura 8) ; ⇒ (8 7 6 5 4 3 2 1)
    (lista-hasta-segura -1) ; ⇒ error
    ```

----

### Funciones en estructuras de datos

- Vamos a ver ejemplos que muestran que las funciones cumplen la
última condición de los objetos de primera clase: podemos incluirlas
en estructuras de datos.

----

### Construcción de listas de funciones

- Para construir una lista de funciones debemos llamar a `list` con
las funciones como parámetros

    ```racket
    (define (doble x) (+ x x))
    (define (cuadrado x) (* x x))
    (define (suma-1 x) (+ x 1))
    
    (define lista (list cuadrado suma-1 doble))
    lista
    ; ⇒ (#<procedure:cuadrado>  #<procedure:suma-1>  #<procedure:doble>)
    ```

- También podemos usar expresiones `lambda` para crear la función que
  se incluye en la lista. Por ejemplo, podemos añadir una función que
  suma 5 a un número:

    ```racket
    (define lista2 (cons (lambda (x) (+ x 5)) lista))
    lista2
    ; ⇒ (#<procedure> #<procedure:cuadrado> #<procedure:suma-1> #<procedure:doble>)
    ```

----

### Invocación a funciones de una lista

- Una vez creada una lista con funciones, ¿cómo podemos invocar a
  alguna de ellas?.
- Debemos tratarlas de la misma forma que tratamos cualquier otro dato
  guardado en la lista, las recuperamos con las funciones `car` o
  `list-ref` y las invocamos.

- Por ejemplo, para invocar a la primera función de `lista2`:

    ```racket
    ((car lista2) 10) ; ⇒ 15
    ```

----

### Ejemplo de función que trabaja con listas de funciones: `aplica-funcs`

- Veamos un ejemplo de una función `(aplica-funcs lista-funcs x)` que
  recibe una lista de funciones en el parámetro `lista-funcs` y las
  aplica todas **de derecha a izquierda** al número que pasamos en el
  parámetro `x`.

- Por ejemplo, la lista anterior con las funciones `cuadrado`, `cubo`
  y `suma-1`:

    ```racket
    (define lista (list cuadrado cubo suma-1))
    ```

    la llamada a `(aplica-funcs lista 5)` devolverá :

    ```racket
    (cuadrado (cubo (suma-1 5)) ; ⇒ 46656
    ```

- Implementación:

    ```racket
    (define (aplica-funcs lista-funcs x)
        (if (null? lista-funcs)
            x
            ((car lista-funcs)
                (aplica-funcs (cdr lista-funcs) x))))
    ```

- Un ejemplo de uso:

    ```racket
    (define lista-funcs (list (lambda (x) (* x x))
                              (lambda (x) (* x x x))
                              (lambda (x) (+ x 1))))
    (aplica-funcs lista-funcs 5)
    ⇒ 46656
    ```

----

### Funciones de orden superior

!!! Hint "Definición"
    Las funciones de orden superior (*higher order functions* en inglés)
    son funciones que reciben como parámetro otras funciones.


- Llamamos funciones de orden superior (*higher order functions* en
  inglés) a las funciones que toman otras como parámetro o devuelven
  otra función. Permiten generalizar soluciones con un alto grado de
  abstracción.

- Los lenguajes de programación funcional como Scheme, Scala o Java 8
  tienen ya predefinidas algunas funciones de orden superior que
  permiten tratar listas o *streams* de una forma muy concisa y
  compacta. 
  
- Si alguna función no existe en el lenguaje, es posible
  implementarlas nosotros mismos

- Veremos:
    - `map`
    - `filter`
    - `exists?` (implementada por nosotros)
    - `for-all?` (implementada por nosotros)
    - `foldr` y `foldl`

- De alguna de las funciones veremos también su implementación
recursiva.

- Terminaremos viendo cómo la utilización de funciones de orden
superior es una excelente herramienta de la programación funcional
que permite hacer código muy conciso y expresivo.


----

### Función `map`

- La función `map` recibe otra función y una
  lista. Devuelve la lista resultante de aplicar la función
  `transforma` a todos los elementos de la lista.

    ```text
    (map transforma lista) -> lista
    ```

- La función `(transforma dato)` que usa `map` recibe como argumento
  elementos de la lista y devuelve el resultado de transformar ese
  elemento.

    ```text
    (transforma elemento) -> elemento
    ```

- Ejemplos:

    ```racket
    (map cuadrado '(1 2 3 4 5))
    ; ⇒ (1 4 9 16 25)

    (map (lambda (str) (string-append "Hola-" str)) '("me" "llamo" "Ana"))
    ; ⇒ ("Hola-me" "Hola-llamo" "Hola-Ana")

    (map (lambda (s) 
            (string-length (symbol->string s))) '(Esta es una lista de símbolos))
    ; ⇒ (4 2 3 5 2 8)
    ```

- Veamos cómo se implementa `map` de forma recursiva. Llamamos a la
  función `mi-map`.

    ```racket
    (define (mi-map f lista)
        (if (null? lista)
            '()
            (cons (f (car lista))
                  (mi-map f (cdr lista)))))
    ```

- La función `map` puede recibir un número variable de listas, todas
  ellas de la misma longitud:

    ```text
    (map transforma lista_1 ... lista_n) -> lista
    ```

- En este caso la función de transforma debe recibir tantos argumentos
  como listas recibe `map`:
  
    ```text
    (transforma dato_1 ... dato_n) -> dato
    ```

- La función `map` aplica `transforma` a los elementos cogidos de las
  n listas y construye así la lista resultante:
  
    ```racket
    (map + '(1 2 3) '(10 20 30)) ; ⇒ (11 22 33)
    (map cons '(1 2 3) '(10 20 30)) ; ⇒ ((1 . 10) (2 . 20) (3 . 30))
    (map > '(12 3 40) '(20 0 10)) ; ⇒ (#f #t #t)
  
    (define (mayor a b) (if (> a b) a b))
    (define (mayor-de-tres a b c)
        (mayor a (mayor b c)))

    (map mayor-de-tres '(10 2 20 -1 34) 
                       '(2 3 12 89 0) 
                       '(100 -10 23 45 8))
    ; ⇒ (100 3 23 89 34)
    ```

!!! Hint "Consejo"
    La función `map` recibe una o más listas de *n* elementos y devuelve otra
    de *n* elementos transformados.

----

### Función `filter`

- La función `(filter predicado lista)` toma como parámetro un
  predicado y una lista y devuelve como resultado los elementos de la
  lista que cumplen el `predicado`.
  
  ```text
  (filter predicado lista) -> lista
  ```

- La función `(predicado elem)` que usa `filter` recibe elementos de
  la lista y devuelve `#t` o `#f`.

    ```text
    (predicado elem) -> boolean
    ```

- Ejemplos:

    ```racket
    (filter even? '(1 2 3 4 5 6 7 8))
    ; ⇒ (2 4 6 8)

    (filter (lambda (s) 
               (>= (string-length (symbol->string s)) 4))
               '(Esta es una lista de símbolos))
    ; ⇒ (Esta lista símbolos)

    (filter (lambda (pareja)
                (>= (car pareja) (cdr pareja))) 
                '((10 . 4) (2 . 4) (8 . 8) (10 . 20)))
    ; ⇒ ((10 . 4) (8 . 8))
    ```

- Podemos implementar `filter` de forma recursiva. Llamamos a la
  función `mi-filter`.

    ```racket
    (define (mi-filter pred lista)
      (cond
        ((null? lista) '())
        ((pred (car lista)) (cons (car lista)
                                  (mi-filter pred (cdr lista))))
        (else (mi-filter pred (cdr lista)))))
    ```


!!! Hint "Consejo" 
    La función `filter` recibe una lista de *n*
    elementos y una condición y devuelve otra de de *n* o menos
    elementos originales filtrados por la condición.

----

### Función `exists?` (implementada por nosotros)

- La función de orden superior `(exists? predicado lista)` recibe un
  predicado y una lista y comprueba si algún elemento de la lista
  cumple ese predicado.
  
    ```text
    (exists? predicado lista) -> boolean
    ```
  
- Igual que en `filter` el `predicado` recibe elementos de la lista y
  devuelve `#t` o `#f`.

    ```text
    (predicado elem) -> boolean
    ```

- Implementación:

    ```racket
    (define (exists? predicado lista)
      (if (null? lista)
          #f
          (or (predicado (car lista))
              (exists? predicado (cdr lista)))))
    ```

- Ejemplos:

    ```racket
    (exists? even? '(1 2 3 4 5 6)) ; ⇒ #t

    (exists? (lambda (x)
                 (> x 10)) '(1 3 5 8)) ; ⇒ #f
    ```

----

### Función `for-all?` (implementada por nosotros)

- La función de orden superior `(for-all? predicado lista)` recibe un
  predicado y una lista y comprueba que todos los elementos de la
  lista cumplen ese predicado.

- Implementación:

    ```racket
    (define (for-all? predicado lista)
      (or (null? lista)
          (and (predicado (car lista))
               (for-all? predicado (cdr lista)))))
    ```

- Ejemplos:

    ```racket
    (for-all? even? '(2 4 6)) ; ⇒ #t

    (for-all? (lambda (x)
                 (> x 10)) '(12 30 50 80)) ; ⇒ #t
    ```

----

### Función `foldr`

- El nombre `fold` significa *plegado*. La función `foldr`
  recorre una lista y la va "plegando", devolviendo un único valor
  como resultado.
  
    ```text
    (foldr combina base lista) -> valor
    ```
  
- El plegado lo realiza la **función de plegado** `(combina dato
  resultado)`, que recibe un dato de la lista y lo acumula con el otro
  parámetro `resultado` (al que debemos dar un valor inicial y es el
  parámetro `base` de la función `foldr`).
  
    ```text
    (combina dato resultado) -> resultado
    ```

- La función `combina` se aplica a los elementos de la lista **de
  derecha a izquierda**, empezando por el último elemento de la lista
  y el valor inicial `base` y aplicándose sucesivamente a los
  resultados que se van obteniendo.

- Veamos un ejemplo. Supongamos que la función de plegado es una
  función que suma el dato que viene de la lista con el valor
  acumulado:

    ```racket
    (define (suma dato resultado)
        (+ dato resultado))
    ```

- Llamamos a los parámetros `dato` y `resultado` para remarcar que el
  primer parámetro se va a coger de la lista y el segundo del
  resultado calculado.

- Veamos qué pasa cuando hacemos un `foldr` con esta función
  `suma` y la lista `(1 2 3)` y con el número 0 como base:
  
    ```racket
    (foldr suma 0 '(1 2 3)) ; ⇒ 6
    ```

- La función `suma` se va a ir aplicando a todos los elementos de la
  lista de **derecha a izquierda**, empezando por el valor base (0) y
  el último elemento de la lista (3) y cogiendo el resultado obtenido
  y utilizándolo como nuevo parámetro `resultado` en la siguiente
  llamada.

- En concreto, la secuencia de llamadas a la función `suma` serán las
  siguientes:

    ```racket
    (suma 3 0) ; ⇒ 3
    (suma 2 3) ; ⇒ 5
    (suma 1 5) ; ⇒ 6
    ```

- Otro ejemplo de uso:

    ```racket
    (foldr string-append "****" '("hola" "que" "tal")) 
    ; ⇒ "holaquetal****"
    ```

- En este caso la secuencia de llamadas a `string-append` que se van a
  producir son:
  
    ```racket
    (string-append "tal" "****") ; ⇒ "tal****"
    (string-append "que" "tal****") ; ⇒ "quetal****"
    (string-append "hola" "quetal****") ; ⇒ "holaquetal****"
    ```

- Otros ejemplos:

    ```racket
    (foldr (lambda (x y) (* x y)) 1 '(1 2 3 4 5 6 7 8)) ; ⇒ 40320
    (foldr cons '() '(1 2 3 4)) ; ⇒ (1 2 3 4)
    ```

- La **implementación recursiva** en Scheme de la función `foldr` es
  la siguiente:

    ```racket
    (define (mi-foldr combina base lista)
      (if (null? lista)
          base
          (combina (car lista) (mi-foldr combina base (cdr lista)))))
    ```


### Función `foldl` ###

- La función `(foldl combina base lista)` (_fold left_) es similar a
`foldr` con la diferencia de que la secuencia de aplicaciones de la
función de plegado se hace **de izquierda a derecha** en lugar de
derecha a izquierda.

- El perfil de la función de plegado es el mismo que en `foldr`:

    ```text
    (combina dato resultado) -> resultado
    ```

- Por ejemplo, si la función de combinación es `string-append`:

    ```racket
    (foldl string-append "****" '("hola" "que" "tal")) 
    ; ⇒ "talquehola****"
    ```

- La secuencia de llamadas a `string-append` es:

    ```racket
    (string-append "hola" "****") ; ⇒ "hola****"
    (string-append "que" "hola****") ; ⇒ "quehola****"
    (string-append "tal" "quehola****") ; ⇒ "talquehola****"
    ```

- Otro ejemplo:

    ```racket
    (foldl cons '() '(1 2 3 4)) ; ⇒ (4 3 2 1)
    ```


- La implementación de `foldl` la veremos cuando hablemos de
  recursión por la cola (_tail recursion_) en el próximo tema.

!!! Hint "Consejo"
    Las funciones `foldr` o `foldl` reciben una lista de
    datos y devuelven un único resultado 

----

### Funciones recursivas con FOS y expresiones lambda

- Veamos por último unos ejemplos en los que definimos funciones
  recursivas usando funciones de orden superior (FOS) y expresiones
  lambda.
  
- La recursividad no se hará de forma explícita, sino que serán las
  FOS las que la implementen.

!!! Hint "Combinación de funciones de orden superior"
    La combinación de funciones de orden superior y expresiones lamba
    para definir funciones recursivas sobre listas es una de
    las características más potentes de la programación funcional.

----

### Función `(suma-n n lista)`

- Supongamos que queremos definir una función `(suma-n n lista)` que
  devuelve la lista resultante el resultado de sumar un número `n` a
  todos los elementos de una lista.

- Podemos hacerlo de forma recursiva:

    ```racket
    (define (suma-n n lista)
        (if (null? lista)
            '()
            (cons (+ (car lista) n)
                  (suma-n n (cdr lista)))))
    ```

- Funciona de la siguiente manera:

    ```racket
    (suma-n 10 '(1 2 3 4))
    ; ⇒ (11 12 13 14)
    ```

- ¿Podemos implementar `suma-n` usando una llamada a `map`?

<p style="margin-bottom:3cm;"></p>

- Sí, pasándole a map una función construida con una expresión lambda
  en la que se usa el parámetro `n`:

    ```racket
    (define (suma-n n lista)
        (map (lambda (x) (+ x n)) lista))
    ```

- Otro ejemplo: Función `suma-parejas`

    ```racket
    (define (suma-parejas lista-parejas)
        (foldr (lambda (pareja resultado)
                   (+ (car pareja) (cdr pareja) resultado)) 0 lista-parejas))

    (suma-parejas (list (cons 3 6) (cons 2 9) (cons -1 8) (cons 9 3))) ; ⇒ 39
    ``` 
----


### Composición de funciones de orden superior

- En la composición de funciones de orden superior, la lista 
resultante de la salida de una función se utiliza como entrada de la
siguiente. 


- Supongamos que queremos implementar una función que sume un número
`n` a todos los elementos de una lista (igual que la anterior) y
después que sume todos los elementos resultantes.

- ¿Cómo lo haríamos? (podemos reutilizar el código del ejemplo anterior)

<p style="margin-bottom:3cm;"></p>

- Solución:

    ```racket
    (define (suma-n-total n lista)
       (foldr + 0
           (map (lambda (x) (+ x n)) lista)))
    ```

    ```racket
    (suma-n-total 100 '(1 2 3 4)) ; ⇒ 410
    ```

- Otro ejemplo: queremos contar aquellas parejas cuya suma de ambos números
es mayor que un umbral (por ejemplo, 10).

    ```racket
    (define lista-parejas (list (cons 1 2) 
                                (cons 3 8) 
                                (cons 2 3) 
                                (cons 9 6)))
    (cuenta-mayores-que 10 lista-parejas) ; ⇒ 2
    ```

- ¿Cómo se implementaría componiendo funciones de orden superior?:

<p style="margin-bottom:3cm;"></p>

- Solución:

    ```racket
    (define (cuenta-mayores-que n lista-parejas)
      (length
       (filter (lambda (x)
                 (> x n)) (map (lambda (pareja)
                                 (+ (car pareja) (cdr pareja))) lista-parejas))))
    ```								 

----

### Función `(contienen-letra caracter lista-pal)`

- Queremos definir la función `(contienen-letra
  caracter lista-pal)` que devuelve las palabras de una lista que
  contienen un determinado carácter, usando la función `filter` y
  alguna función auxiliar

- Por ejemplo:

    ```racket
    (contienen-letra #\a '("En" "un" "lugar" "de" "la" "Mancha"))
    ; ⇒ ("lugar" "la" "Mancha")
    ```

- Necesitamos el predicado auxiliar `(letra-en-pal? caracter pal)` que
  comprueba si una cadena contiene un carácter. Por ejemplo:

    ```racket
    (letra-en-pal? #\a "Hola") ; ⇒ #t
    (letra-en-pal? #\a "Pepe") ; ⇒ #f
    ```

- ¿Lo podemos implementar obteniendo una lista de caracteres a partir
  de la cadena y usando la función `exists?`?

<p style="margin-bottom:3cm;"></p>

- Solución:

    ```racket
    (define (letra-en-pal? caracter palabra)
        (exists? (lambda (c) 
                    (equal? c caracter)) (string->list palabra)))
    ```

- Ahora ya podemos implementar `contienen-letra` usando otra vez la
  función de orden superior `filter` y la función anterior en la
  expresión lambda que hace el filtrado:

    ```racket
    (define (contienen-letra caracter lista-pal)
       (filter (lambda (pal)
                  (letra-en-pal? caracter pal)) lista-pal))
    ```


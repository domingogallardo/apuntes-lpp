# Buenas prácticas de programación funcional #

En este documento listamos consejos que te ayudarán a escribir programas legibles,
concisos y abstractos en el paradigma de programación funcional usando el
lenguaje de programación Scheme/Racket.

Estos consejos se usan en todos los ejemplos de código de la asignatura,
tanto en los ejemplos de teoría como en las soluciones de las prácticas. Es muy
importante que cuando estudies esos ejemplos reflexiones sobre la forma en la
que está escrita el código. Aquí extraemos algunas de esas buenas prácticas para
hacerlas más explícitas.

### Nombres de funciones y variables ###

- Los nombres de funciones y variables deben ser descriptivos y tener un
  significado que ayude a explicar qué hace la función que estamos
  definiendo. Al ser Scheme un lenguaje débilmente tipado, nombres de parámetros
  como `car`, `palabra`, `lista-numeros` nos ayudan a entender cuál debe ser el
  tipo del parámetro y cómo debemos llamar a la función.
  
    **Buenos ejemplos**: `(entre-dos-puntos? p1 p2 p3)`, `(distancia punto1 punto2)`,
    `(veces car palabra)`

    **Malos ejemplos**: `(aux1 x1 x2)`, `(mi-func x y z)`

- Los nombres de las funciones y parámetros siempre empiezan en
  minúscula. Cuando el nombre de una función o un parámetro sea compuesto,
  usaremos un guión para dividir las palabras.
  
    **Buenos ejemplos**: `suma-cuadrados`, `tiempo-impacto`, `conduce-vehiculo`.
    
    **Malos ejemplos**: `sumaCuadrados`, `Tiempo-Impacto`, `conduce_vehiculo`.
  
- Los nombres de los predicados (funciones que devuelven `#t` o `#f`) siempre
  terminan con el símbolo `?`.
  
    **Buenos ejemplos**: `equal?`, `number?`, `(entre? p1 p2 p3)`

### Espacio, indentación y paréntesis ###

- En las expresiones no habrá espacio entre el primer paréntesis y el operador o
  la forma especial. Siempre debe haber un espacio precediendo cada argumento.
  
    **Buen ejemplo**: `(+ (* 2 3) (* 10 3))`
    
    **Mal ejemplo**: `(+(* 2 3)(* 10 3))`

- El código tendrá una indentación correcta, que muestre correctamente la estructura de
  las formas especiales, expresiones y los parámetros de las llamadas a
  funciones. Se evitarán líneas largas, introduciendo nuevas líneas y ajustando
  la indentación de las nuevas líneas para mejorar la legibilidad del código.
  
    **Mal ejemplo**
    
    ```racket
    (if (and (<= x n) (>= y n)) "n entre x e y" "n menor que x o mayor que y")
    ```

    **Buen ejemplo**
    
    ```racket
    (if (and (<= x n)
             (>= y n))
        "n entre x e y"
        "n menor que x o mayor que y")
    ```

- Las paréntesis de cierre deben estar todos en la misma línea, al final de la
  expresión. No deben escribirse como llaves de cierre en líneas separadas.
  
    **Buen ejemplo**
    
    ```racket
    (define (suma-si-positivo x y)
        (if (> 0 x)
            (+ x y)
            y))
    ```
    
    **Mal ejemplo**
    
    ```racket
    (define (suma-si-positivo x y)
        (if (> 0 x)
            (+ x y)
            y
        )
    )
    ```

### Estructuras de control y formas especiales ###

- Las únicas estructuras de control, formas especiales y funciones de Scheme que
  se deben usar son: `define`, `if`, `cond`, `quote` (`'`), `and`, `or`, `not` y
  `eval`.
  
- Se usará la sintaxis tradicional de la forma especial `cond`, y siempre
  se incluirá una expresión `else` al final:
  
    **Buen ejemplo**
    
    ```racket
    (cond
        ((> 3 4) "3 es mayor que 4")
        ((< 2 1) "2 es menor que 1")
        ((= 3 1) "3 es igual que 1")
        ((> 3 5) "3 es mayor que 2")
        (else "ninguna condición es cierta"))
    ```

### No usar variables locales, funciones locales ni pasos de ejecución ###

- No se usará `define` para definir funciones locales. Todas las funciones,
  incluyendo las funciones auxiliares, se definirán en el ámbito
  global.
  
    **Mal ejemplo**
    
    ```racket
    (define (longitud-palabra-entre? a b palabra)
        (define (entre? a b n)
            (and (<= a n)
                 (>= b n)))
        (entre? a b (string-length palabra)))
    ```

    **Buen ejemplo**
    
    ```racket
    (define (entre? a b n)
        (and (<= a n)
             (>= b n)))

    (define (longitud-palabra-entre? a b palabra)
        (entre? a b (string-length palabra)))
    ```

- No se usarán variables locales, ni usando  `define` ni otras formas especiales
  de `scheme`. En lugar de ello, se usarán directamente las expresiones que
  definen las variables. 
  
    **Mal ejemplo**
    
    ```racket
    (define (suma-cuadrados x y)
        (define x-cuadrado (cuadrado x))
        (define y-cuadrado (cuadrado y))
        
        (+ x-cuadrado y-cuadrado))
    ```

    **Buen ejemplo**
    
    ```
    (define (suma-cuadrados x y)
        (+ (cuadrado x) (cuadrado y)))
    ```

### No usar "números mágicos" ###

- Debemos dar un nombre a todos los elementos que aparezcan en nuestro código,
  para aclarar su significado. Por ejemplo, debemos dar nombre a las constantes
  numéricas, definiendo su significado o, en el caso en que sea una constante
  que depende de otros valores,  definir una expresión para calcular su valor.
  
    **Mal ejemplo**
    
    ```racket
    (define (encuentra-indice char)
        (- (char->integer char) 97))
    ```
    
    **Buen ejemplo**
    
    ```racket
    (define (encuentra-indice char)
        (- (char->integer char)
           (char->integer #\a)))
    ```
    
    O también:
    
    ```racket
    (define indice-char-a (char->integer #\a))
    
    (define (encuentra-indice char)
        (- (char->integer char) indice-char-a))
    ```

### Listas ###

- Para devolver el primer elemento de la lista y el resto se usarán las funciones
  `first` y `rest`.
  
- Las funciones `cons` y `append` se usan para añadir un elemento a una lista y
  para unir dos listas. No usaremos `append` para añadir un elemento en cabeza
  de una lista.
  
    **Mal ejemplo**: `(append (list 1) '(2 3 4 5))`
    
    **Buen ejemplo**: `(cons 1 '(2 3 4 5))`

- Para comprobar si una lista tiene un único elemento es preferible, por
  motivos de eficiencia, comprobar si su resto es `null?`, en lugar de usar la función
  `length`. La función `length` tiene un coste lineal mientras que las funciones
  `rest` y `null?` tienen coste unitario.
  
    **Buen ejemplo**: `(null? (rest lista))`
    
    **Mal ejemplo**: `(= 1 (length lista))`

### Pruebas unitarias ###

- Para comprobar el correcto funcionamiento de las funciones implementadas
  usaremos pruebas unitarias con la librería `rackunit`, en lugar de mostrar los
  resultados por pantalla con `display`.
  
    **Buen ejemplo**
    
    ```racket
    (require rackunit)
    (define (suma-parejas p1 p2)
        (cons (+ (car p1) (car p2))
              (+ (cdr p1) (cdr p2))))
              
    (check-equal? (suma-parejas '(2 . 3) '(1 . 4)) '(3 . 7))
    ```

    **Mal ejemplo**
    
    ```racket
    (define (suma-parejas p1 p2)
        (cons (+ (car p1) (car p2))
              (+ (cdr p1) (cdr p2))))
              
    (display (suma-parejas '(2 . 3) '(1 . 4))) ;=>  (3 . 7)
    ```
    
### Estilo funcional ###

- Siempre que la expresión resultante sea legible, es preferible construir una
  expresión que devuelve un booleano utilizando una composición de operadores
  lógicos `and`, `or`, `not`, en lugar de utilizar un `if` que devuelva
  directamente un `#t` o un `#f`.
  
    **Buen ejemplo**
    
    ```racket
    (define (numero-entre? a b n)
        (and (<= a n)
             (>= b n)))
    ```
        
    **Mal ejemplo**
    
    ```racket
    (define (numero-entre? a b n)
        (if (> a n)
            #f
            (if (< b n)
                #f
                #t)))
    ```


- Es recomendable el uso de composición de funciones y la creación de funciones
  de ayuda que proporcionen más abstracción, legibilidad y simplicidad al
  código. Es preferible código corto y expresivo, evitando la repetición de
  llamadas repetidas a la misma función con los mismos parámetros.
  
    **Mal ejemplo**
    
    ```racket
    (define (longitud-palabra-entre? a b palabra)
        (and (<= a (string-length palabra))
             (>= b (string-length palabra))))
    ```
    
    No cumple la recomendación porque el código es complicando, con una
    expresión en donde hay varias llamadas acumuladas. Además se repiten
    dos veces la llamada a `(string-length palabra)`. 
    
    Es mucho mejor la siguiente versión, en la que simplificamos la expresión
    obteniendo la longitud de la palabra y comprobando si esa longitud está entre `a` y `b`:

    **Buen ejemplo**
    
    ```racket
    (define (entre? a b n)
        (and (<= a n)
             (>= b n)))

    (define (longitud-palabra-entre? a b palabra)
        (entre? a b (string-length palabra)))
    ```

- Las funciones auxiliares definidas deben ser lo más flexibles y genéricas
  posibles, facilitando la reutilización del código y su uso en la construcción
  de otras funciones.
  
    **Mal ejemplo**
    
    ```racket
    (define (longitud-aux? a b n)
        (and (<= a n)
             (>= b n)))

    (define (longitud-palabra-entre? a b palabra)
        (longitud-aux? a b (string-length palabra)))
    ```
    
    El nombre `longitud-aux` no es correcto, porque no explica lo que hace la
    función y no permite darnos cuenta de que podemos reusarla en otros
    contexto. Es mucho más adecuado el nombre `(entre? a b n)` o `(numero-entre?
    a b n)`.


----
Lenguajes y Paradigmas de Programación, curso 2025-26  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

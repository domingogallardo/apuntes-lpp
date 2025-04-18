# Práctica 1: Seminario de Scheme

## Realización de la práctica ##

1. Instala en tu ordenador el DrRacket, tal y como se comenta al
   comienzo del [seminario de
   Scheme](../../seminarios/seminario1-scheme/seminario1-scheme.md)
   y crea un fichero `practica1.rkt`. Incluye en el fichero todo el código que
   escribas esta semana. Usa comentarios (líneas que comienzan con `;`) para separar secciones y
   realizar anotaciones. 

   Este fichero te servirá guardar tu práctica. Para realizar la entrega deberás
   copiar las soluciones de cada ejercicio en el cuestionario que habilitaremos en Moodle.

2. Lee el seminario de Scheme hasta el apartado 2.4. (_Tipos de datos
   simples_) incluido. Puedes ver el **vídeo 1** en la página con los
   vídeos del seminario (en la semana 1 en Moodle).
   
    A la vez que lees el texto o ves el vídeo debes probar en el
    intérprete de Racket todos los ejemplos que aparecen. Pruébalos de
    forma interactiva en el panel de interpretación del DrRacket y
    guarda las definiciones en el panel de edición del fichero `practica1.rkt`.

3. Haz el siguiente ejercicio.

    **Ejercicio 1**. Lanza DrRacket y escribe cada una de las siguientes instrucciones
    en el intérprete, intentado adivinar el resultado que va
    devolver. Están ordenadas por dificultad de arriba abajo y de
    izquierda a derecha. ¡¡Piensa en los resultados!!. Intenta
    entender cómo interpreta Scheme lo que escribes.


    |Instrucción      | Instrucción                                    |
    |---------------- | -----------------------------------------------|
    |`3`              | `(+ (- 4 (* 3 (/ 4 2) 4)) 3)`                  |
    |`(+ 1 2 )`       | `(* (+ (+ 2 3) 4) (* (* 3 3) 2))`              |
    |`(+ 1 2 3 4)`    | `(* (+ 2 3 4 5) 3 (- 5 2 1))`                  |
    |`(+)`            | `(+ (- (+ (- (+ 2 3) 5) 1) 2) 3)`              |
    |`(sqrt 25)`      | `(- (sqrt (* 5 ( + 3 2))) (+ 1 1 1 1))`        |
    |`(* (+ 2 3) 5)`  | `(> (* 3 (+ 2 (+ 3 1)) (+ 1 1)) (+ (* 2 2) 3))`|
    |`+`              | `(= (* 3 2) (+ 1 (+ 2 2) 1))`                  |
    |`#\+`            | `(not (> (+ 3 2) 5))`                          |
    |`"+"`            | `(and (even? 2) (odd? (+ 3 2)))`               |
    |`"hola"`         | `(remainder (+ 6 2) (+ 1 1))`                  |


4. Lee el apartado 2.5. (_Tipos de datos compuestos_) del seminario de
   Scheme, en el que se explica cómo se trabaja con cadenas, parejas y
   listas en Racket. Puedes ver el **vídeo 2** en la página con los
   vídeos del seminario en Moodle.
   
    Prueba en el intérprete de Racket todos los ejemplos que aparecen
    en el seminario.

5. Haz los siguientes ejercicios. 

    **Ejercicio 2** sobre parejas. Predice lo que hace Scheme cuando
    escribas las siguientes expresiones. Están ordenadas por
    dificultad de arriba abajo y de izquierda a derecha. Después,
    pruébalas y comprueba si tu predicción era correcta. Si no lo era,
    intenta comprender por qué.

    | Instrucción                           | Instrucción                       |
    |---------------------------------------|-----------------------------------|
    | `(cons 1 2)`                          | `(car (car (cons (cons 1 2) 3)))` |
    | `(car (cons 1 2))`                    | `(car (cons (cons 3 4) 2))`       |
    | `(cdr (cons 1 2))`                    | `(cdr (cons (cons 3 4) 2))`       |
    | `(cons (* 2 3) (/ 4 2))`              | `(cdr (cons 1 (cons 2 3)))`       |
    | `(cons (+ 2 1) (if (> 2 3) "2" "3"))` | `(cdr (car (cons (cons 1 2) 3)))` |


    **Ejercicio 3** sobre listas. Predice lo que hace Scheme cuando escribas las
    siguientes expresiones. Después, pruébalas y comprueba si tu
    predicción era correcta. Si no lo era, intenta comprender por qué.

    | Instrucción                                    | Instrucción                              |
    |------------------------------------------------|------------------------------------------|
    | `(list 1 2 3 4)`                               | `(cons 3 '(1 2 3))`                      |
    | `(rest (list 1 2 3 4))`                         | `(rest (cons #t (cons "Hola" (list 1))))` |
    | `(first '(1 2 3 4))`                             | `(first (list (list 1 2) 1 2 3 4))`        |
    | `(first (list #t 1 "Hola"))`                     | `(first (rest '((1 2) 1 2)))`               |
    | `(first (rest (list 1 2 3 4)))`                   | `(cons '(1 2 3) '(4 5 6))`               |
    | `(rest (rest '(1 2 3 4)))`                       | `(first (rest (list 1 2 3 4)))`             |
    | `(first (rest (rest (list 1 2 3 4))))`             | `(rest (rest (list 1 2 3 4)))`             |
    | `(list (* 2 2) (+ 1 2) (/ 4 2))`               | `(first (rest (rest (rest '(1 2 3 4)))))`     |
    | `(list (+ 2 3) (- 3 4) (string-ref "hola" 3))` |                                          |


    **Ejercicio 4** sobre listas. Intenta hacer los siguientes apartados
    sin utilizar el intérprete de Scheme. Después comprueba si has acertado.

    a) Dada la siguiente lista, indica la expresión correcta para que
    Scheme devuelva 3:

    ```racket
    (list 1 2 3 4 5)
    ```

    b) Dada la siguiente lista, indica la expresión correcta para que
    Scheme devuelva (5).

    ```racket
    (list 1 2 3 4 5)
    ```

    c) Dada la siguiente lista, indica la expresión correcta para que
    Scheme devuelva 5.

    ```racket
    (list 1 2 3 4 5)
    ```

    d) Dada la siguiente expresión, ¿qué devuelve Scheme?

    ```racket
    (first (rest (rest (list 1 (list 2 3) (list 4 5) 6))))
    ```

    e) Dada la siguiente expresión, ¿qué devuelve Scheme?

    ```racket
    (rest (rest '(1 (2 3) 4 5)))
    ```

6. Lee el apartado 3 (_Estructuras de
   control_) del seminario de Scheme. Puedes ver el
   **vídeo 3** hasta el minuto 7:00 en la página con los vídeos del
   seminario en Moodle.

7. Haz el siguiente ejercicio.

    **Ejercicio 5**. Predice lo que devolverá Scheme cuando escribas
    las siguientes expresiones. Están ordenadas por dificultad de
    arriba abajo y de izquierda a derecha. Después, pruébalas y
    comprueba si tu predicción era correcta. Si no lo era, intenta
    comprender por qué.

    | Instrucción                                    | Instrucción                                                               |
    |------------------------------------------------|---------------------------------------------------------------------------|
    | `(equal? "hola" "hola")`                       | `(+ (char->integer(integer->char 1200)) (char->integer #\A))`             |
    | `(string-ref "pepe" 1)`                        | `(string-length (make-string 7 #\E))`                                     |
    | `(substring "buenos dias" 1 4)`                | `(define a 3)` <br/> `(define b (+ a 1))`                                 |
    | `(= "hola" "hola")`                            | `(+ a b (* a b))`                                                         |
    | `(string-ref (substring "buenos dias" 2 5) 1)` | `(= a b)`                                                                 |
    | `(define pi 3.14159)`                          | `(if (and (> a b) (< b (* a b))) b a)`                                    |
    | `pi`                                           | `(cond ((= a 4) 6)`<br/>`((= b 4) (+ 6 7 a))`<br/>`(else 25))`            |
    | `"pi"`                                         | `(+ 2 (if (> b a) b a))`                                                  |
    | `(+ pi (+ pi pi))`                             | `(* (cond ((> a b) a)` <br/>`((< a b) b)`<br/>`(else -1))`<br/>`(+ a 1))` |
    | `(+ (* pi pi) (- 2 pi pi pi pi))`              | `((if (< a b) + -) a b)`                                                  |

8. Lee el resto del seminario, desde el apartado 4 hasta el
   final. Puedes ver el **vídeo 3** desde el minuto 7:00 hasta el
   final en la página con los vídeos del seminario en Moodle.

    - Prueba las funciones `ecuacion` y `convertir-temperatura` y
      reflexiona sobre cómo se implementan.
      
    - Prueba las pruebas unitarias de la función `ecuacion`. Cambia la
      definición de la función para introducir un error y provocar un
      fallo en las pruebas unitarias. Arregla la definición de la
      función para que vuelva a funcionar.

9. Haz el siguiente ejercicio.

    **Ejercicio 6**
    
    a) Define una función que calcule la distancia entre
    dos puntos, definidos por parejas de números enteros. Añade los
    siguientes tests para comprobar que funciona correctamente:
    
    
    | Entrada               | Salida   |
    |-----------------------|----------|
    | `p1:(0, 0) p2:(0, 10)`  | `10`     |
    | `p1:(0, 0) p2:(10, 0)`  | `10`     |
    | `p1:(0, 0) p2:(10, 10)` | `14.142135623730951`     |


    b) Usando la función `distancia` definida anteriormente,
    implementa la función `isosceles?` que recibe las tres
    coordenadas de los vértices de un triángulo y debe devolver si la
    figura es un triángulo isósceles.  Para ello, debes comprobar que
    los tres lados no son iguales (sería equilátero) y que sucede
    alguna de las tres siguientes condiciones: o bien el primer
    lado es igual que el segundo, o el primer lado es igual que el
    tercero, o el segundo lado es igual que el tercero.
    
    Fíjate en que las funciones booleanas `and`, `or` y
    `not` devuelven ya un valor booleano y que en programación
    funcional se usa la composición de funciones.
    
    Debes implementar la función usando una única expresión en la que
    no uses `if`, sino una composición de expresiones booleanas.
    
    !!! Hint "Pista"
        Recuerda del seminario que la función `=` puede tener más de dos
        argumentos. 

    Añade los tests correspondientes a los siguientes ejemplos:

    ```racket
    ; Ejemplos de triángulos isósceles:
    
    ; p1: (0, 0) p2: (3, 3) p3: (6, 0)
    ; p1: (2, 2) p2: (4, 0) p3: (0, 0)

    ; No isósceles:

    ; p1: (0, 0) p2: (0, 0) p3: (0, 0) (igual la distancia entre los tres puntos)
    ; p1: (0, 0) p2: (1, 1) p3: (3, 2) (ningún lado igual)
    
    (isosceles? '(0 . 0) '(3 . 0) '(6 . 0)) ; ⇒ #t
    (isosceles? '(2 . 2) '(4 . 0) '(0 . 0)) ; ⇒ #t
    (isosceles? '(0 . 0) '(0 . 0) '(0 . 0)) ; ⇒ #f
    (isosceles? '(0 . 0) '(1 . 1) '(3 . 2)) ; ⇒ #f
    ```


## Entrega de la práctica

Copia los ejercicios de la práctica en el cuestionario
_Entrega práctica 1_. Tienes de plazo hasta el próximo domingo a las 21:00h. Una vez finalizado el plazo de entrega podrás revisar el cuestionario y
visualizar la solución. En este caso el único ejercicio con solución es el
ejercicio 6. 

Una vez esté disponible la solución debes compararla con la
tuya. Puedes consultar cualquier duda con tu profesor de prácticas en
la clase de prácticas de la semana que viene.

----
Lenguajes y Paradigmas de Programación, curso 2024-25  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

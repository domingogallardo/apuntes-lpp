# Semana 2

En este enunciado encontrarás una planificación de todo lo que
tienes que hacer durante la semana 2 de LPP para llevar al día la
asignatura.


!!! Importante "Trabajo en clase y en casa"
    Deberás hacer todas estas actividades en clase de prácticas y en casa. El
    tiempo estimado de trabajo semanal es de unas 5 horas: 2 horas en
    clase y alrededor de 3 horas en casa.

Durante la sesión de prácticas el profesor estará disponible para
resolver dudas y dar pistas sobre cómo enfrentarse a los ejercicios.

Si te surge alguna duda mientras trabajas en casa puedes enviarla al
foro de la asignatura (en Moodle) o a tu profesor de prácticas o de
teoría mediante una tutoría en UACloud. 


## Repaso de teoría y ejercicios ##

1. Abre el DrRacket y crea el fichero `semana2.rkt` en el que deberás
   escribir todos los ejemplos y soluciones de los ejercicios que
   hagas. Escribe en comentarios tu nombre y apellidos. Usa también
   comentarios para separar secciones y realizar anotaciones.  Incluye
   en el fichero todo el código, ejemplos y resolución de ejercicios,
   que hagas esta semana.
   
2. Repasa la sección [1.1. _Pasado y presente del paradigma
   funcional_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#11-pasado-y-presente-del-paradigma-funcional)
   de teoría para tener una idea de los orígenes de la programación
   funcional y de su uso en la actualidad. Puedes pinchar en algún
   enlace que te resulte interesante para tener más información.

3. Repasa el apartado [1.2. _Evaluación de expresiones y definición de
   funciones_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#12-evaluacion-de-expresiones-y-definicion-de-funciones). Se
   introducen algunos conceptos que te sonarán del seminario de
   Scheme. Prueba el ejemplo `tiempo-impacto` para entender cómo
   definir e invocar a funciones auxiliares.
   
    Una característica fundamental de la PF es la **transformación**
    de datos de entrada en resultados. En la imagen del algoritmo que
    conduce un vehículo autónomo explicamos un ejemplo de
    transformación de datos usando una composición de funciones. Es
    fundamental entender que la evaluación de las expresiones se hace
    de dentro a afuera.

4. Resuelve los siguientes ejercicios:

    ----

    **Ejercicio 1**

    a) Implementa la función `(binario-a-decimal b3 b2 b1 b0)` que reciba
    4 bits que representan un número en binario y devuelva el número
    decimal equivalente.

    ```racket
    (binario-a-decimal 1 1 1 1) ; ⇒ 15
    (binario-a-decimal 0 1 1 0) ; ⇒ 6
    (binario-a-decimal 0 0 1 0) ; ⇒ 2
    ```

    **Nota**: recuerda que para realizar esta conversión, se utiliza la siguiente fórmula:

    ```text
    n = b3 * 2ˆ3 + b2 * 2ˆ2 + b1 * 2ˆ1 + b0 * 2ˆ0
    ```

    Para la implementación de la expresión debes utilizar la función `expt`.


    b) Implementa la función `(binario-a-hexadecimal b3 b2 b1 b0)` que
    reciba 4 bits de un número representado en binario y devuelva el
    carácter correspondiente a su representación en hexadecimal.

    ```racket
    (binario-a-hexadecimal 1 1 1 1) ; ⇒ #\F
    (binario-a-hexadecimal 0 1 1 0) ; ⇒ #\6
    (binario-a-hexadecimal 1 0 1 0) ; ⇒ #\A
    ```

    !!! Note "Pista"
        Para realizar esta conversión, como paso intermedio debes
        pasar primero el número binario a su representación decimal
        (utilizando la función definida en el apartado anterior) y después a
        su correspondiente hexadecimal. 

    Recuerda que la representación hexadecimal de los números
    decimales del 0 al 9 es el carácter correspondiente a ese número,
    y que el número decimal 10 se representa con el carácter A, el 11
    con el B, y así sucesivamente hasta el 15 que es el F en
    hexadecimal.

    Para la implementación de esta función auxiliar que pasa de
    decimal a hexadecimal debes usar las funciones `integer->char` y
    `char->integer`. En la función `char->integer` los caracteres
    consecutivos están asociados con números consecutivos. Por
    ejemplo, el entero correspondiente al carácter `#\A` es uno menos
    que el correspondiente al carácter `#\B`. Los caracteres de
    números y los de letras no son consecutivos.

    ----
    
    **Ejercicio 2**

    Implementa la función `(menor-de-tres n1 n2 n3)` que reciba tres
    números como argumento y devuelva el menor de los tres, intentando
    que el número de condiciones sea mínima.

    No debes utilizar la función `min`. 

    Implementa dos versiones de la función: 

      - versión 1: usando la forma especial `if` 
      - versión 2 (llámala `menor-de-tres-v2`): definiendo una función
        auxiliar `(menor x y)` que devuelva el menor de dos números
        (deberás usar también la forma especial `if` para
        implementarla) y construyendo la función `menor-de-tres-v2`
        como una composición de llamadas a esta función auxiliar.

    ```racket
    (menor-de-tres 2 8 1) ;; ⇒ 1
    (menor-de-tres-v2 3 0 3) ;; ⇒ 0
    ```

    ----

5. Añade casos de prueba al código de los dos ejercicios anteriores,
   tal y como vimos al final del seminario de Scheme. Puedes usar
   algunos de los ejemplos de los enunciados, pero debes también
   construir algunos casos nuevos, con ejemplos creados por ti.
   
    Los casos de prueba son un componente importante del código, ya
    que permiten guardar en el propio código una demostración de que
    éste funciona correctamente, así como unos ejemplos de cómo llamar
    a las funciones definidas.
   
    !!! Note "Siempre debes incluir casos de prueba"
        A partir de ahora, deberás incluir casos de prueba en todas las
        funciones definidas.

6. Repasa el apartado [1.3. _Programación declarativa
   vs. imperativa_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#13-programacion-declarativa-vs-imperativa)
   en el que se explica qué es la **programación declarativa** frente
   al estilo de programación al que estás acostumbrado que es la
   **programación imperativa**. 
   
    Estudia con detalle todos los ejemplos de código para entender los
    conceptos teóricos.

7. Estudia el apartado [1.4. _Modelo de computación de
   sustitución_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#14-modelo-de-computacion-de-sustitucion)
   en el que se explica cómo un intérprete evalúa una expresión de
   programación funcional. Hay dos formas de hacerlo y ambas obtienen
   el mismo resultado. 
   
    Repasa los ejemplos de la evaluación de `(doble (cuadrado a))` y de
    `(f (+ a 1))` usando las dos formas.

8. Haz el siguiente ejercicio.

    ----
    
    **Ejercicio 3**

    a) Supongamos las definiciones

    ```racket
    (define (f x y)
        (cons x y))

    (define (g x)
        (cons 2 x))
    ```

    Realiza la evaluación paso a paso de la siguiente expresión 

    ```racket
    (f (g (+ 2 1)) (+ 1 1))
    ```

    mediante el **modelo de sustitución**, utilizando tanto el **orden
    aplicativo** y como el **orden normal**.

    Escribe la solución entre comentarios en el propio fichero `.rkt`.

    b) Supongamos las definiciones

    ```racket
    (define (f x)
        (/ x 0))
    
    (define (g x y)
        (if (= x 0)
            0
            y))
        ```

    Igual que en el apartado anterior, realiza la evaluación paso a paso
    de la siguiente expresión

    ```racket
    (g 0 (f 10))
    ```

    mediante el **modelo de sustitución**, utilizando tanto el **orden
    aplicativo** y como el **orden normal**. Y escribe la solución
    entre comentarios en el propio fichero `.rkt` de la práctica.
    
    ----
    
9. El modelo de sustitución sólo explica una parte del funcionamiento
   de la evaluación de expresiones de Scheme. Las formas especiales
   son primitivas de Scheme que no se evalúan con el modelo de
   evaluación, sino que cada forma tiene su propia regla de
   evaluación.
   
    Prueba todos los ejemplos de las secciones [2.2. _Formas
    especiales en
    Scheme_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#22-formas-especiales-en-scheme)
    para entender cómo se evalúan las formas especiales `define`,
    `if`, `cond`, `and` y `or`.

10. Resuelve los siguientes ejercicios, en los que tendrás que usar
    algunas de las formas especiales vistas anteriormente:

    ----

    **Ejercicio 4**

    Implementa la función `(tirada-ganadora t1 t2)` que reciba 2
    parejas como argumento, donde cada pareja representa una tirada
    con 2 dados (contiene dos números). La función debe determinar qué
    tirada es la ganadora, teniendo en cuenta que será aquella cuya
    suma de sus 2 dados esté más próxima al número 7. La función
    devolverá 1 si `t1` es la ganadora, 2 si `t2` es la ganadora o
    bien 0 si hay un empate. Este último caso se producirá cuando la
    diferencia con 7 de ambas tiradas es la misma.

    ```racket
    (tirada-ganadora (cons 1 3) (cons 1 6)) ; ⇒ 2
    (tirada-ganadora (cons 1 5) (cons 2 2)) ; ⇒ 1
    (tirada-ganadora (cons 6 2) (cons 3 3)) ; ⇒ 0
    ```

    ----

    **Ejercicio 5**

    Define la función `tipo-triangulo` que recibe como parámetro las
    coordenadas en el plano de los vértices de un triángulo
    representados con parejas. La función devuelve una cadena con el
    tipo de triángulo correspondiente: equilátero, isósceles o
    escaleno.

    Recuerda que un triángulo equilátero es aquel cuyos tres lados
    tienen la misma longitud, el isósceles el que tiene dos lados
    iguales y el escaleno el que todos sus lados son diferentes.

    Como siempre, te recomendamos que implementes funciones auxiliares
    y que definas la función principal como una composición de
    llamadas a esas funciones auxiliares.
    
    Ejemplos:

    ```racket
    (tipo-triangulo (cons 1 1) (cons  1 6) (cons 6 1)) ; ⇒ "isósceles"
    (tipo-triangulo (cons -2 3) (cons  2 6) (cons 5 3)) ; ⇒ "escaleno"
    (tipo-triangulo (cons -3 0) (cons  3 0) (cons 0 5.1961)) ;  ⇒ "equilatero"
    ```

    !!! Note "Nota"
        Para comparar dos números reales debemos comprobar si la
        resta entre ambos es menor que una constante `epsilon` que hemos
        definido. Por ejemplo, `epsilon` puede valer 0.0001.

        Puedes usar la siguiente función auxiliar:

        ```racket
        (define epsilon 0.0001)
    
        (define (iguales-reales? x y)
            (< (abs (- x y)) epsilon))
        ```

    ----

11. Una característica especial de Scheme es que permite trabajar con
    identificadores como objetos primitivos del lenguaje. Es lo que se
    denominan **símbolos**. Lee el apartado [2.3. _Forma especial
    `quote` y
    símbolos_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#23-forma-especial-quote-y-simbolos)
    para entender este concepto. Es muy importante que leas la
    sintaxis y la evaluación de _quote_ y pruebes los ejemplos que hay
    en ese apartado.

12. Resuelve el siguiente ejercicio, en el que trabajaremos con
    parejas (vistas en el seminario de Scheme) y símbolos.

    ----
    
    **Ejercicio 6**

    Supongamos que queremos programar un juego de cartas. Lo primero
    que debemos hacer es definir una forma de representar las cartas y
    funciones que trabajen con esa representación. En este ejercicio
    vamos a implementar esas funciones.

    Representaremos una carta por un símbolo con dos letras: la primera
    indicará su número o figura y la segunda el palo de la carta.

    Por ejemplo:

    ```racket
    (define tres-de-oros '3O)
    (define as-de-copas 'AC)
    (define caballo-de-espadas 'CE)
    ```

    Debemos definir la función `carta` que devuelve una pareja con el
    valor correspondiente a su orden en la baraja española (un número)
    y el palo de la carta (un símbolo).

    ```racket
    (carta tres-de-oros) ; ⇒ (3 . Oros)
    (carta as-de-copas) ; ⇒ (1 . Copas)
    (carta 'RB) ; ⇒ (12 . Bastos)
    ```

    Los valores de las cartas de la baraja española son:

    ```text
    A (As) ⇒ 1
    S (Sota) ⇒ 10
    C (Caballo) ⇒ 11
    R (Rey) ⇒ 12
    ```

    Para realizar el ejercicio debes definir en primer lugar las
    funciones `(obten-palo char)` y `(obten-valor char)` que devuelven
    el palo y el valor, dado un carácter. Y debes implementar la
    función `carta` usando estas dos funciones.

    ```racket
    (obten-palo #\O) ; ⇒ Oros
    (obten-palo #\E) ; ⇒ Espadas
    (obten-valor #\3) ; ⇒ 3
    (obten-valor #\S) ; ⇒ 10
    ```

    !!! Note "Pista"
        Puedes utilizar las funciones `(symbol->string simbolo)` que convierte un
        símbolo en una cadena y `(string-ref cadena pos)` que devuelve el
        carácter de una cadena situado en una determinada posición.

13. Repasa la sección [2.4. _Forma expecial `quote` con
    expresiones_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#24-forma-expecial-quote-con-expresiones). Prueba
    los ejemplos en los que se construyen listas y parejas usando
    `quote`.
    
14. Estudia la sección [2.5. _Función
    `eval`_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#25-funcion-eval)
    en la que se introduce la función `eval`. Es una función que
    tienen muy pocos lenguajes y que permite evaluar en tiempo de
    ejecución una expresión. 
    
    Debes entender la diferencia entre `(eval (+ 10 8))` y `(eval `(+
    10 8))`. Aunque el resultado es el mismo, la evaluación de ambas
    expresiones es completamente distinta.

15. Estudia, por último, la sección
    [2.6. _Listas_](../../teoria/tema02-programacion-funcional/tema02-programacion-funcional.md#26-listas)
    en la que repasamos dos conceptos fundamentales:

    - Distinguir la forma de construir listas usando `list` y
      `quote`. Prueba todos los ejemplos del apartado para entender
      esta diferencia.
    
    - Distinguir entre `cons` y `append` para construir nuevas listas
      a partir de listas ya existentes. Prueba los ejemplos y recuerda
      que `cons` sirve para añadir un elemento a la cabeza de una
      lista y `append` para concatenar dos o más listas. Son dos cosas
      muy distintas que no debes confundir.
      
16. Esta semana, en clase de teoría, hemos visto cómo trabajar con las
    listas y cómo definir funciones recursivas para procesarlas. La
    semana que viene repasaremos esos conceptos en las prácticas.

## Sube el trabajo a Moodle

Sube el fichero `semana2.rkt` a Moodle, en la entrega denominada
_Semana 2_, para que tu profesor de prácticas lo pueda revisar. 

Puedes hacer preguntas a tu profesor de prácticas sobre cualquier duda
que te haya surgido tanto en clase de prácticas como usando las
tutorías de UACloud.



----
Lenguajes y Paradigmas de Programación, curso 2021-22  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez


# Tema 5: Programación Funcional con Swift

## 1. Introducción

Te recomendamos que leas el seminario de Swift
en el que se introduce el lenguaje y se explica cómo ejecutar
programas en este lenguaje:

- [Seminario de Swift](../../seminarios/seminario2-swift/seminario2-swift.md)


### 1.2. Conceptos fundamentales de Programación Funcional ###

Vamos a repasar en este tema cómo se implementan en Swift conceptos
principalmente funcionales como:

- Valores inmutables
- Tipos de datos recursivos
- Funciones como objetos de primera clase y clasuras
- Funciones de orden superior

Repasamos rápidamente algunos conceptos básicos de programación
funcional, vistos en los primeros temas de la asignatura.

Programación Funcional:

> La Programación Funcional es un paradigma de programación que trata
> la computación como la evaluación de funciones matemáticas y que
> evita cambios de estado y datos mutables.

Funciones matemáticas o puras:

> Las funciones matemáticas tienen la característica de que cuando las
> invocas con el mismo argumento siempre te devolverán el mismo
> resultado.

Funciones como objetos de primera clase:

> En programación funcional, las funciones son objetos de primera
> clase del lenguaje, similares a enteros o _strings_. Podemos pasar
> funciones como argumentos en las denominadas _funciones de orden
> superior_ o devolver funciones creadas en tiempo de ejecución
> (clausuras).

### 1.3. Características básicas de Swift ###

Swift es un lenguaje principalmente imperativo, pero en su diseño se
han introducido conceptos modernos de programación funcional,
extraídos de lenguajes como Rust o Haskell. Por ello se puede
considerar un lenguaje **multi-paradigma**, en el que se puede definir
código funcional que se puede ejecutar junto con código imperativo.

Como dice su creador [Chris Lattner](http://nondot.org/sabre/):

> El lenguaje Swift es el resultado de un esfuerzo incansable de un
> equipo de expertos en lenguajes, gurús de documentación, ninjas de
> optimización de compiladores [..]. Por supuesto, también se
> benefició enormemente de las experiencias ganadas en muchos otros
> lenguajes, tomando ideas de Objective-C, Rust, Haskell, Ruby,
> Python, C#, CLU, y demasiados otros para ser enumerados.

#### 1.3.1. Lenguaje fuertemente tipado ####

A diferencia de Scheme, Swift es un lenguaje **fuertemente tipado** en el
que hay que definir los tipos de variables, parámetros y
funciones.

Por ejemplo, en las siguientes declaraciones definimos variables de
distintos tipos:

```swift
let n: Int = 10
let str: String = "Hola"
let array: [Int] = [1,2,3,4,5]
```

El compilador de Swift permite identificar los tipos de las variables
cuando se realiza una asignación. La técnica se denomina **inferencia
de tipos** y permite declarar variables sin escribir su tipo. Por
ejemplo, las variables anteriores se pueden declarar también asi:

```swift
let n = 10
let str = "Hola"
let array = [1,2,3,4,5]
```

Aunque no hayamos declarado explícitamente el tipo de las variables,
el compilador les ha asignado el tipo correspondiente. Por ejemplo, no
podemos asignarles un valor de distinto tipo:

```swift
var x = 5
x = 4 // correcto
x = 6.0 // error
// error: cannot assign value of type 'Double' to type 'Int'
// x = 5.0
//     ^~~
//    Int( )
```

El compilador indica el error e incluso sugiere una posible solución
del mismo. En este caso llamar al constructor `Int()` pasándole un
`Double` como parámetro.

#### 1.3.2. Lenguaje multi-paradigma ####

Swift permite combinar características funcionales con características
imperativas y de programación orientada a objetos. Veremos en este
tema muchas características funcionales que podremos utilizar en
cualquier programa Swift que desarrollemos.

Por ejemplo, cuando declaramos una variable podemos declararla como
mutable, usando la declaración `var`, o como inmutable, usando la
declaración `let`. Si queremos utilizar un enfoque funcional
preferiremos siempre declarar las variables con `let`. 

```swift
var x = 10
x = 20 // x es mutable
let y = 10
y = 20 // error: y es inmutable
```

Una ventaja de la inmutabilidad es que permite que el compilador de
Swift optimice el código de forma muy eficiente. De hecho, el propio
compilador nos indica que es preferible definir una variable como
`let` si no la vamos a modificar:

```swift
func saluda(nombre: String) -> String {
    var saludo = "Hola " + nombre + "!"
    return saludo
}
//warning: variable 'saludo' was never mutated; consider changing to 'let' constant
//    var saludo = "Hola " + nombre
//    ~~~ ^
//    let
```


## 2. Inmutabilidad

Una de las características funcionales importantes de Swift es el
énfasis en la inmutabilidad para reforzar la seguridad del
lenguaje. 

Hemos visto que la palabra clave `let` permite definir constantes y
que Swift recomienda su uso si el valor que definimos es un valor que
no va a ser modificado.

El valor asignado a una constante `let` puede no conocerse en tiempo
de compilación, sino que puede ser obtenido en tiempo de ejecución
como un valor devuelto por una función:

```swift
let respuesta: String = respuestaUsuario.respuesta()
```

Al declarar una variable como `let` se bloquea su contenido y no se
permite su modificación. Una de las ventajas del paradigma funcional y
de la inmutabilidad es que garantiza que el código que escribimos no
tiene efectos laterales y puede ser ejecutado sin problemas en
entornos multi-procesador o multi-hilo.

### 2.1. Creación de nuevas estructuras y mutación

En la [biblioteca estándar de
Swift](https://developer.apple.com/documentation/swift/swift_standard_library)
existen una gran cantidad de estructuras (como `Int`, `Double`,
`Bool`, `String`, `Array`, `Dictionary`, etc.) que tienen dos tipos de
métodos: métodos que mutan la estructura y métodos que devuelven una
nueva estructura. Cuando estemos escribiendo código con estilo
funcional deberemos utilizar siempre estos últimos métodos, los que
construyen estructuras nuevas.

Por ejemplo, en el struct `Array` se define el método `sort` y el
método `sorted`. El primero ordena el array con mutación y el segundo
devuelve una copia ordenada, sin modificar el array original. En el
siguiente código no se modifica el array original, sino que se
construye un array nuevo ordenado:


```swift
// Código recomendable en programación funcional
// porque utiliza el método sorted que devuelve una
// copia del array original
let miArray = [10, -1, 3, 80]
let arrayOrdenado = miArray.sorted()
print(miArray)
print(arrayOrdenado)
// Imprime:
// [10, -1, 3, 80]
// [-1, 3, 10, 80]
```

Este código es el recomendable cuando estemos escribiendo código con
un estilo de programación funcional.

Sin embargo, el siguiente código es imperativo y utiliza la mutación del array original:

```swift
// Código no recomendable en programación funcional
// porque utiliza el método sort que muta el array original
var miArray = [10, -1, 3, 80]
miArray.sort()
print(miArray)
// Imprime:
// [-1, 3, 10, 80]
```

Otro ejemplo es en la forma de añadir elementos a un array. Podemos
hacerlo con un enfoque funcional, usando el operador `+` que construye
un array nuevo:

```swift
// Código recomendable en programación funcional
let miArray = [10, -1, 3, 80]
let array2 = miArray + [100]
print(array2)
// Imprime:
// [10, -1, 3, 80, 100]
```

Y podemos hacerlo usando un enfoque imperativo, con el método
`append`:

```swift
// Código no recomendable en programación funcional
var miArray = [10, -1, 3, 80]
miArray.append(100)
print(miArray)
// Imprime:
// [10, -1, 3, 80, 100]
```

!!! Important "Importante"
    En programación funcional debemos usar siempre los métodos
    **que no modifican las estructuras**. Así evitaremos los efectos
    laterales y nuestro código funcionará correctamente en entornos
    multi-hilo.

Cuando definimos una variable de tipo `let` el valor que se
asigne a esa variable se convierte en inmutable. Si se trata de una
estructura o una clase con métodos mutables el compilador dará un
error. Por ejemplo:

```swift
let miArray = [10, -1, 3, 80]
miArray.append(100)
// error: cannot use mutating member on immutable value: 'miArray' is a 'let' constant
```

Otro ejemplo. El método `append(_:)` de un `String` es un método
mutable. Si definimos una cadena con `let` no podremos modificarla y
daría error el siguiente código:

```swift
var cadenaMutable = "Hola"
let cadenaInmutable = "Adios"
cadenaMutable.append(cadenaInmutable) // cadenaMutable es "HolaAdios"
cadenaInmutable.append("Adios")
// error: cannot use mutating member on immutable value: 'cadenaInmutable' is a 'let' constant
```


## 3. Funciones


### 3.1. Definición de una función en Swift

Para definir una función en Swift se debe usar la palabra `func`,
definir el nombre de la función, sus parámetros y el tipo de
vuelto. El valor devuelto por la función se debe devolver usando la
palabra `return`.

Código de la función `saluda(nombre:)`:

```swift
func saluda(nombre: String) -> String {
    let saludo = "Hola, " + nombre + "!"
    return saludo
}
```

Para invocar a la función `saluda(nombre:)`:

```swift
print(saluda(nombre:"Ana"))
print(saluda(nombre:"Pedro"))
// Imprime "Hola, Ana!"
// Imprime "Hola, Pedro!"
```

### 3.2. Etiquetas de argumentos y nombres de parámetros

Cada parámetro de una función tiene una etiqueta del argumento y un
nombre de parámetro. La etiqueta del argumento se usa cuando se llama a
la función y el nombre del parámetro se usa internamente en su
implementación. Por defecto, los parámetros usan su nombre de
parámetro como etiqueta del argumento:

```swift
func unaFuncion(primerNombreParametro: Int, segundoNombreParametro: Int) {
    // En el cuerpo de la función, primerNombreParametro y
    // segundoNombreParametro se refieren a los valores de los
    // argumentos del primer y el segundo parámetro
}
unaFuncion(primerNombreParametro: 1, segundoNombreParametro: 2)
```

Es posible hacer distintos la etiqueta del argumento del nombre del
parámetro:

```swift
func saluda(nombre: String, de ciudad: String) -> String {
    return "Hola \(nombre)! Me alegro de que hayas podido visitarnos desde \(ciudad)."
}
print(saluda(nombre: "Bill", de: "Cupertino"))
// Imprime "Hola Bill! Me alegro de que hayas podido visitarnos desde Cupertino."
```

En este caso el nombre externo del parámetro (el que usamos al invocar la función)
es `de` y el nombre interno (el que se usa en el cuerpo de la función)
es `ciudad`. 

Otro ejemplo, la siguiente función `concatena(palabra:con:)`: 

```swift
func concatena(palabra str1: String, con str2: String) -> String {
    return str1+str2
}

print(concatena(palabra:"Hola", con:"adios"))
```

Si no se quiere una etiqueta del argumento para un parámetro, se puede
escribir un subrayado (`_`) en lugar de una etiqueta del argumento
explícita para ese parámetro. Esto nos permite llamar a la función sin
usar un nombre de parámetro. Por ejemplo, la función `max(_:_:)` y la
función `divide(_:entre:)`:

```swift
func max(_ x:Int, _ y: Int) -> Int {
   if x > y {
      return x
   } else {
      return y
   }
}

print(max(10,3))

func divide(_ x:Double, entre y: Double) -> Double {
   return x / y
}

print(divide(30, entre:4))
```

El perfil de la función está formado por el nombre de la función, las
etiquetas de los argumentos y el tipo devuelto por la función. En la
documentación de las funciones usaremos las etiquetas separadas por
dos puntos. Por ejemplo, las funciones anteriores son `max(_:_:)` y
`divide(_:entre:)`.

Las etiquetas de los argumentos son parte del nombre de la
función. Es posible definir funciones distintas con
sólo distintos nombres de argumentos, como las siguientes funciones
`mitad(par:)` y `mitad(impar:)`:

```swift
func mitad(par: Int) -> Int{
    return par/2
}

func mitad(impar: Int) -> Int{
    return (impar+1)/2
}

print(mitad(par: 8))
// Imprime 4
print(mitad(impar: 9))
// Imprime 5
```



### 3.3. Parámetros y valores devueltos

Es posible definir funciones sin parámetros:

```swift
func diHolaMundo() -> String {
    return "hola, mundo"
}
print(diHolaMundo())
// Imprime "hola, mundo"
```

Podemos definir funciones sin valor devuelto. Por ejemplo, la
siguiente función `diAdios(nombre:)`. No hay que escribir flecha con el
tipo devuelto. Cuidado, no sería propiamente programación funcional.

```swift
func diAdios(nombre: String) {
    print("Adiós, \(nombre)!")
}
diAdios(nombre:"Dave")
// Imprime "Adiós, Dave!"
```

Es posible devolver múltiples valores, construyendo una tupla. Por
ejemplo, la siguiente función `ecuacion(a:b:c:)` calcula las dos
soluciones de una ecuación de segundo grado:

```swift
func ecuacion(a: Double, b: Double, c: Double) -> (pos: Double, neg: Double) {
    let discriminante = b*b-4*a*c
    let raizPositiva = (-b + discriminante.squareRoot()) / 2*a
    let raizNegativa = (-b - discriminante.squareRoot()) / 2*a
    return (raizPositiva, raizNegativa)
}
```

Recordemos (consultar el seminario de Swift) que podemos acceder a los
valores de la tupla por posición:

```swift
let resultado = ecuacion(a: 1, b: -5, c: 6)
print("Las raíces de la ecuación son \(resultado.0) y \(resultado.1)")
//Imprime "Las raíces de la ecuación son 3.0 y 2.0"
```

En este caso en la definición del tipo devuelto por la función estamos
etiquetando esos valores con las etiquetas `pos` y `neg`. De esta
forma podemos acceder a los componentes de la tupla usando esas
etiquetas definidas:

```swift
let resultado = ecuacion(a: 1, b: -5, c: 6)
print("Las raíces de la ecuación son \(resultado.pos) y \(resultado.neg)")
//Imprime "Las raíces de la ecuación son 3.0 y 2.0"
```

## 4. Recursión

Veamos algunos ejemplos de funciones recursivas en Swift.

Primero una función `suma(hasta:)` que devuelve la suma desde 0 hasta
el número que le pasamos como parámetro.

```swift
func suma(hasta x: Int) -> Int {
  if x == 0 {
    return 0
  } else {
    return x + suma(hasta: x - 1)
  }
}

print(suma(hasta: 5))
// Imprime "15"
```

También es posible definir recursiones que recorran arrays de una
forma similar a cómo trabajábamos en Scheme. Los arrays en Swift no
funcionan exactamente como las listas de Scheme (no son listas de
parejas), pero podemos obtener el primer elemento y el resto de la
siguiente forma.

```swift
let a = [10, 20, 30, 40, 50, 60]
let primero = a[0]
let resto = Array(a.dropFirst())
```

En `primero` se guarda el número 10. En `resto` se guarda el `Array`
del 20 al 60. El método `dropFirst` devuelve una `ArraySlice`, que es
una vista de un rango de elementos del array, en este caso el que va
desde la posición 1 hasta la 5 (la posición inicial de un array es la
0). Es necesario el constructor `Array` para convertir ese
`ArraySlice` en un `Array`.

Usando las instrucciones anteriores podemos definir la función recursiva que suma los
valores de un Array de la siguiente forma similar a cómo lo hacíamos
en Scheme:

```swift
func sumaValores(_ valores: [Int]) -> Int {
    if (valores.isEmpty) {
        return 0
    } else {
        let primero = valores[0]
        let resto = Array(valores.dropFirst())
        return primero + sumaValores(resto)
    }
}

print(sumaValores([1,2,3,4,5,6,7,8])) 
// Imprime "36"
```

Un último ejemplo es la siguiente función `minMax(array:)` que
devuelve el número más pequeño y más grande de un array de enteros:

```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
    if (array.count == 1) {
        return (array[0], array[0])
    } else {
        let primero = array[0]
        let resto = Array(array.dropFirst())

        // Llamada recursiva que devuelve el mínimo y el máximo del
        // resto del array
        let minMaxResto = minMax(array: resto)

        let minimo = min(primero, minMaxResto.min)
        let maximo = max(primero, minMaxResto.max)
        return (minimo, maximo)
    }
}

let limites = minMax(array: [8, -6, 2, 100, 3, 71])
print("El mínimo es \(limites.min) y el máximo es \(limites.max)")
// Imprime "El mímimo es -6 y el máximo es 100"
```

En este ejemplo nos apartamos un poco de la solución vista en Scheme
porque permitimos pasos de ejecución que inicializan variables. Pero
no nos salimos del paradigma funcional, porque todas son variables
inmutables definidas con `let`.


## 5. Tipos función 

En Swift las funciones son objetos de primera clase y podemos
asignarlas a variables, pasarlas como parámetro o devolverlas como
resultado de otra función. Al ser un lenguaje fuertemente tipado, las
variables, parámetros o resultados deben ser objetos de tipo función.

Cada función tiene un tipo específico, definido por el tipo de sus
parámetros y el tipo del valor devuelto.

```swift
func sumaDosInts(a: Int, b: Int) -> Int {
    return a + b
}
func multiplicaDosInts(a: Int, b: Int) -> Int {
    return a * b
}
```

El tipo de estas funciones es `(Int, Int) -> Int`, que se puede leer como:

"Un tipo función que tiene dos parámetros, ambos de tipo `Int` y que
devuelve un valor de tipo `Int`".

En Swift se puede usar un tipo función de la misma forma que cualquier
otro tipo, por ejemplo asignando la función a una variable:

```swift
var f = sumaDosInts
print(f(2,3))
// Imprime "5"
f = multiplicaDosInts
print(f(2,3))
// Imprime "6"
```

La variable `f` es una variable de tipo `(Int, Int) -> Int`, o sea,
una variable que contiene funciones de dos argumentos `Int` que
devuelven un `Int`.

!!! Note "Nota"
    Habrás notado que al invocar a `f` no se ponen etiquetas en los
    argumentos. De hecho, si las pusiéramos el compilador de Swift se
    quejaría:
    
    ```swift
    print(f(a:2, b:3))
    //error: extraneous argument labels 'a:b:' in call
    ```

    Esto es debido a que al ser `f` una variable se le puede asignar
    cualquier función que tenga el perfil `(Int, Int) -> Int` sin
    tener en cuenta las etiquetas de los argumentos.

### 5.1. Funciones que reciben otras funciones

Podemos usar un tipo función en parámetros de otras funciones:

```swift
func printResultado(funcion: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Resultado: \(funcion(a, b))")
}
printResultado(funcion: sumaDosInts, 3, 5)
// Prints "Resultado: 8"
```

La función `printResultado(funcion:_:_:)` toma como primer parámetro otra
función que recibe dos `Int` y devuelve un `Int`, y como segundo y
tercer parámetro dos `Int`. Y en el cuerpo llama a la función que se
pasa como parámetro con los argumentos `a` y `b`.

Veamos otro ejemplo, que ya vimos en Scheme. Supongamos que queremos
calcular el sumatorio desde `a` hasta `b` en el que aplicamos una
función `f` a cada número que sumamos:

```text
sumatorio(a, b, f) = f(a) + f(a+1) + f(a+2) + ... + f(b)
```

Recordamos que se resuelve con la siguiente recursión:

```text
sumatorio(a, b, f) = f(a) + sumatorio(a+1, b, f)
sumatorio(a, b, f) = 0 si a > b
```

Veamos cómo se implementa en Swift: 

```swift
func sumatorio(desde a: Int, hasta b: Int, func f: (Int) -> Int) -> Int {
   if a > b { 
      return 0 
   } else {
      return f(a) + sumatorio(desde: a + 1, hasta: b, func: f)
   }
}

func identidad(_ x: Int) -> Int {
   return x
}

func doble(_ x: Int) -> Int {
   return x + x
}

func cuadrado(_ x: Int) -> Int {
    return x * x
}

print(sumatorio(desde: 0, hasta: 10, func: identidad)) // Imprime 55
print(sumatorio(desde: 0, hasta: 10, func: doble)) // Imprime 110
print(sumatorio(desde: 0, hasta: 10, func: cuadrado)) // Imprime 385
```


### 5.2. Funciones en estructuras

Como cualquier otro tipo Las funciones pueden también incluirse en
  estructuras de datos compuestas, como arrays:
  
```swift
var funciones = [identidad, doble, cuadrado]
print(funciones[0](10)) // 10
print(funciones[1](10)) // 20 
print(funciones[2](10)) // 100
```

El tipo de la variable `funciones` sería `[(Int) -> Int]`. 

Al ser Swift fuertemente tipado, no podríamos hacer un array con
distintos tipos de funciones. Por ejemplo el siguiente código daría un
error:

```swift
func suma(_ x: Int, _ y: Int) -> Int {
   return x + y
}
// La siguiente línea genera un error
var misFunciones = [doble, cuadrado, suma]
// error: heterogenous collection literal could only be inferred to
// '[Any]'; add explicit type annotation if this is intentional

```

### 5.3 Funciones que devuelven otras funciones

Por último, veamos un ejemplo de funciones que devuelven otras
funciones. 

Es un ejemplo sencillo, una función que devuelve otra que
suma 10:

```swift
func construyeSumador10() -> (Int) -> Int {
  func suma10(x: Int) -> Int {return x+10}
  return suma10
}

var g = construyeSumador10()
print(g(20))
// Imprime 30
```

La función devuelta por `construyeSumador10()` es una función con el tipo
`(Int) -> Int` (recibe un parámetro entero y devuelve un entero). En
la llamada a `construyeSumador10()` se crea esa función y se asigna a la
variable `g`.

Estas funciones devueltas se denominan **clausuras**. Más adelante
hablaremos algo más de ellas. Veremos también más adelante que es
posible usar **expresiones de clausura** que construyen clausuras
anónimas. 

Podemos modificar el ejemplo anterior, haciendo que la función
`construyeSumador` reciba el número a sumar como parámetro:

```swift
func construyeSumador(inc: Int) -> (Int) -> Int {
  func suma(x: Int) -> Int {return x+inc}
  return suma
}

var f2 = construyeSumador(inc: 10)
var f3 = construyeSumador(inc: 100)
print(f2(20))
// Imprime "30"
print(f3(20))
// Imprime "120"
```

Invocamos dos veces a `construyeSumador(inc:)` y guardamos las
clausuras construidas en las variables `f2` y `f3`. En `f2` se guarda una
función que suma `10` a su argumento y en `f3` otra que suma `100`.

## 6. Tipos

Entre las ventajas del uso de tipos está la detección de errores en
los programas en tiempo de compilación o las ayudas del entorno de
desarrollo para autocompletar código. Entre los inconvenientes se
encuentra la necesidad de ser más estrictos a la hora de definir los
parámetros y los valores devueltos por las funciones, lo que impide la
flexibilidad de Scheme.

Se utilizan tipos para definir los posibles valores de:

- variables
- parámetros de funciones
- valores devueltos por funciones

Tal y como hemos visto cuando hemos comentado que Swift es fuertemente
tipado las definiciones de tipos van precedidas de dos puntos en las
variables y parámetros, o de una flecha (`->`) en la definición de los
tipos de los valores devueltos por una función:

```swift
let valorDouble : Double = 3.0
let unaCadena: String = "Hola"

func calculaEstadisticas(valores: Array<Int>) -> (min: Int, max: Int, media: Int) {
   ...
}
```

En Swift existen dos clases de tipos: tipos con nombre y tipos compuestos. 

### 6.1. Tipos con nombre

Un tipo con nombre es un tipo al que podemos dar un nombre determinado
cuando se define. Por ejemplo, al definir un nombre de una clase o de
un enumerado estamos también definiendo un nombre de un tipo.
 
En Swift es posible definir los siguientes tipos con nombre:

- nombres de clases
- nombres de estructuras
- nombres de enumeraciones
- nombres de protocolos 

Por ejemplo, instancias de una clase definida por el usuario llamada
`MiClase` tienen el tipo `MiClase`. 

Además de los tipos definidos por el usuario, la biblioteca estándar
de Swift tiene un gran número de tipos predefinidos. A diferencia de
otros lenguajes, estos tipos no son parte del propio lenguaje sino que
se definen en su mayoría como estructuras implementadas en esta
biblioteca estándar. Por ejemplo, arrays, diccionarios o incluso los
tipos más básicos como `String` o `Int` están construidos en esa
biblioteca. La implementación de estos elementos está disponible en
abierto en el [sitio GitHub de
Swift](https://github.com/apple/swift/tree/master/stdlib/public/core). 

### 6.2. Tipos compuestos

Los tipos compuestos son tipos sin nombre. En Swift se definen dos:
tuplas y tipos función. Un tipo compuesto puede tener tipos con nombre
y otros tipos compuestos. Por ejemplo la tupla `(Int, (Int, Int))`
contiene dos elementos: el primero es el tipo con nombre `Int` y el
segundo el tipo compuesto que define la tupla `(Int, Int)`. Los tipos
función los hemos visto previamente.

```swift

let tupla: (Int, Int, String) = (2, 3, "Hola")
let otraTupla: (Int, Int, String) = (5, 8, "Adios")

func sumaTupla(tupla t1: (Int, Int), con t2: (Int, Int)) -> (Int, Int) {
  return (t1.0 + t2.0, t1.1 + t2.1)
}

print(sumaTupla(tupla: (tupla.0, tupla.1),
                con: (otraTupla.0, otraTupla.1)))

// Imprime (7, 11)
```

#### 6.2.1. Typealias ####

En Swift se define la palabra clave `typealias` para darle un nombre
asignado a cualquier otro tipo. Ambos tipos son iguales a todos los
efectos (es únicamente azúcar sintáctico).

Por ejemplo, en el siguiente código definimos un `typealias` llamado
`Resultado` que corresponde a una tupla con dos `Int` correspondientes
al resultado de un partido de futbol. Una vez definido, podemos usarlo
como un tipo. La función `quiniela(partido:)` devuelve un `String`
correspondiente al resultado de la quiniela de un partido:


```swift
typealias Resultado = (Int, Int)

func quiniela(partido: Resultado) -> String {
  switch partido {
    case let (goles1, goles2) where goles1 < goles2:
      return "Dos"
    case let (goles1, goles2) where goles1 > goles2:
      return "Uno"
    default:
      return "Equis"
  }
}

print(quiniela(partido: (1,3)))
// Imprime "Dos"
print(quiniela(partido: (2,2)))
// Imprime "Equis"
```

En el ejemplo se usa una sentencia `switch` que recibe el resultado
del partido. Este resultado es una tupla de dos enteros. En el `case
let` se instancia los valores de esa tupla en las variables `goles1` y
`goles2` y después se define una condición para entrar en el caso. En
el primer caso, que `goles1` sea menor que `goles2` y en el segundo
que `goles1` sea mayor que `goles2`.

### 6.3. Tipos valor y tipos referencia

En Swift existen dos tipos de construcciones que forman la base de la
programación orientada a objetos: las estructuras (_structs_) y las
clases. En el tema siguiente hablaremos sobre ello.

En la [biblioteca estándar de
Swift](https://developer.apple.com/documentation/swift/swift_standard_library)
la mayor parte de los tipos definidos (como `Int`, `Double`, `Bool`,
`String`, `Array`, `Dictionary`, etc.) son estructuras, no clases.

Una de las diferencias más importantes entre estructuras y clases es
su comportamiento en una asignación: las estructuras tienen una
**semántica de copia** (son tipos valor) y las clases tienen una **semántica de
referencia** (son tipos referencia).

Un _tipo valor_ es un tipo que tiene semántica de copia en las
asignaciones y cuando se pasan como parámetro en llamadas a funciones.

Los tipos valor son muy útiles porque evitan los efectos laterales en
los programas y simplifican el comportamiento del compilador en la
gestión de memoria. Al no existir referencias, se simplifica
enormemente la gestión de memoria de estas estructuras. No es
necesario llevar la cuenta de qué referencias apuntan a un determinado
valor, sino que se puede liberar la memoria en cuanto se elimina el
ámbito actual.

Frente a un tipo valor, un tipo de referencia es aquel en los que los
valores se asignan a variables con una semántica de referencia. Cuando
se realizan varias asignaciones de una misma instancia a distintas
variables todas ellas guardan una referencia a la misma instancia. Si
la instancia se modifica, todas las variables reflejarán el nuevo
valor. Cuando veamos las clases en el próximo tema veremos algunos ejemplos.

Veamos ahora algunos ejemplos de copia por valor en estructuras.

Por ejemplo, si asignamos una cadena a otra, se realiza una copia:

```swift
var str1 = "Hola"
var str2 = str1
str1.append("Adios")
print(str1) // Imprime "HolaAdios"
print(str2) // Imprime "Hola"
```

Los arrays también son estructuras y, por tanto, también tienen
semántica de copia:

```swift
var array1 = [1, 2, 3, 4]
var array2 = array1
array1[0] = 10
print(array1) // [10, 2, 3, 4]
print(array2) // [1, 2, 3, 4]
```

A diferencia de otros lenguajes como Java, los parámetros de una
función siempre son inmutables y se pasan por copia, para reforzar el
carácter funcional de las funciones. Por ejemplo, es incorrecto
escribir lo siguiente:

```
func ponCero(array: [Int], pos: Int) {
    array[pos] = 0
// error: cannot assign through subscript: 'array' is a 'let' constant
}
```

Se podría pensar que es muy costoso copiar un array entero. Por
ejemplo, si asignamos o pasamos como parámetro un array de 1000
elementos. Pero no es así. El compilador de Swift optimiza estas
sentencias y sólo realiza la copia en el momento en que hay una
modificación de una de las variables que comparten el array. Es lo que
se llama _copy on write_.


## 7. Enumeraciones ##

Las enumeraciones definen un tipo con un valor restringido de posibles
valores:

```swift
enum Direccion {
    case norte
    case sur
    case este
    case oeste
}
```

Cualquier variable del tipo `Direccion` solo puede tener uno de los
cuatro valores definidos. Se obtiene el valor escribiendo el nombre de
la enumeración, un punto y el valor definido. Si el tipo de
enumeración se puede inferir no es necesario escribirlo.

```swift
let hemosGirado = true
var direccionActual = Direccion.norte
if hemosGirado {
   direccionActual = .sur
}
```

En sentencias switch:

```swift
let direccionAIr = Direccion.sur
switch direccionAIr {
case .norte:
   print("Nos vamos al norte")
case .sur:
   print("Cuidado con los pinguinos")
case .este:
    print("Donde nace el sol")
case .oeste:
    print("Donde el cielo es azul")
}
// Imprime "Cuidado con los pinguinos"
```

Otro ejemplo:

```swift
enum Planeta {
    case mercurio, venus, tierra, marte, jupiter, saturno, urano, neptuno
}
```

Y, por último, es más correcto definir el resultado de una quiniela con un
enumerado en lugar de con un `String`:

```Swift
enum Quiniela {
    case uno, equis, dos
}
```

### 7.1. Valores brutos de enumeraciones ###

Es posible asignar a las constantes del enumerado un valor concreto de
un tipo subyacente, por ejemplo enteros:

```swift
enum Quiniela: Int {
    case uno=1, equis=0, dos=2
}
```

Se puede obtener el valor bruto a partir del propio tipo o de una
variable del tipo, usando `rawValue`:

```swift
// Obtenemos el valor bruto a partir del tipo
let valorEquis: Int = Quiniela.equis.rawValue

// Obtenemos el valor bruto a partir de una variable
let res = Quiniela.equis
let valorEquis = res.rawValue
```

También se puede asignar los valores de forma implícita, dando un
valor a la primera constante. Las siguientes tienen el valor consecutivo:

```swift
enum Planeta: Int {
    case mercurio=1, venus, tierra, marte, jupiter, saturno, urano, neptuno
}
let posicionTierra = Planeta.tierra.rawValue
// posicionTierra es 3
```


Podemos escoger cualquier tipo subyacente. Por ejemplo el tipo `Character`:

```swift
enum CaracterControlASCII: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```

El carácter nueva línea (_lineFeed_) se puede obtener de la siguiente forma:

```
let nuevaLinea = CaracterControlASCII.LineFeed.rawValue
```

Y por último, se puede definir como tipo subyacente `String` y los
valores brutos de las constantes serán sus nombres convertidos a
cadenas:

```swift
enum Direccion: String {
    case norte, sur, este, oeste
}
let direccionAtardecer = Direccion.oeste.rawValue
// direccionAtardecer es "oeste"
```

En este caso, también se puede inicializar el valor bruto con una
asignación explícita y no usar el propio nombre:

```swift
enum Direccion: String {
    case norte = "north"
    case sur = "south"
    case este = "east"
    case oeste = "west"
}
let direccionAtardecer = Direccion.oeste.rawValue
// direccionAtardecer es "west"
```

Cuando se definen valores brutos es posible inicializar el enumerado
de una forma similar a una estructura o una clase pasando el valor
bruto. Devuelve el valor enumerado correspondiente o `nil` (un
opcional):

```swift
let posiblePlaneta = Planeta(rawValue: 7)
// posiblePlaneta es de tipo Planeta? y es igual a Planeta.urano
```

## 8. Enumeraciones instanciables ##

Una característica singular de las enumeraciones en Swift es que
permiten definir valores variables asociados a cada caso de la
enumeración, creando algo muy parecido a una instancia de la
enumeración.

### 8.1. Valores asociados a instancias de enumeraciones ###

Un enumerado instanciable permite asociar valores a la instancia del
enumerado. Para crear una instancia del enumerado debemos proporcionar
el valor asociado.

Al igual que un enumerado normal, el enumerado puede especificar
distintos casos. Cada caso puede determinar un tipo de valor asociado.

En otros lenguajes de programación se llaman _uniones etiquetadas_ o
_variantes_.

Por ejemplo, podemos definir un enumerado que permita guardar un
`Int` o un `String`:

```swift
enum Multiple {
    case num(Int)
    case str(String)
}
```

De esta forma, podemos crear valores de tipo `Multiple` que contienen
un `Int` (instanciando el caso `num`) o un `String` (instanciando el
caso `str`):

```swift
let valor3 = Multiple.num(10)
let valor4 = Multiple.str("Hola")
```

Para obtener el valor asociado debemos usar una expresión `case let`
en una sentencia `switch` con una variable a la que se asigna el
valor. Por ejemplo, la siguiente función reciba instancias de tipo
`Multiple` e imprime el valor asociado al enumerado que se pasa como
parámetro.

```swift
func imprime(multiple: Multiple) {
    switch multiple {
    case let .num(x):
        print("Multiple tiene un Int: \(x)")
    case let .str(s):
        print("Multiple tiene un String: \(s)")
    }
}
imprime(multiple: valor3)
// Imprime "Multiple tiene un Int: 10"
imprime(multiple: valor4)
// Imprime "Multiple tiene un String: Hola
```

!!! Note "Nota"
    No hay que confundir un valor asociado a un caso y un valor bruto:
    el valor bruto de un caso de enumeración es el mismo para todas
    las instancias, mientras que el valor asociado es distinto y se
    proporciona cuando se define el valor concreto de la enumeración.


El tipo del caso también puede ser un tipo compuesto, como una
tupla. Usamos un enum para definir posibles valores de un código de
barras, en el que incluimos dos posibles tipos de código de barras: el
código de barras lineal (denominado UPC) y el código QR:

```swift
enum CodigoBarras {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

Se lee de la siguiente forma: “Definimos un tipo enumerado llamado
`CodigoBarras`, que puede tomar como valor un `upc` (código de barras
lineal) con un valor asociado de tipo `(Int, Int, Int, Int)` (una
tupla de 4 enteros que representan los 4 números que hay en los
códigos de barras lineales) o un valor `qrCode` con valor asociado de
tipo `String`". 

Veamos un ejemplo de uso, en el que creamos un código de barras de
producto de tipo UPC, después lo modificamos a otro de tipo código QR
y por último lo imprimimos:

```swift
var codigoBarrasProducto = CodigoBarras.upc(8, 85909, 51226, 3)
codigoBarrasProducto = .qrCode("ABCDEFGHIJKLMNOP")

switch codigoBarrasProducto {
case let .upc(sistemaNumeracion, fabricante, producto, control):
   print("UPC: \(sistemaNumeracion), \(fabricante), \(producto), \(control).")
case let .qrCode(codigoProducto):
   print("Código QR: \(codigoProducto).")
}
// Imprime  "Código QR : ABCDEFGHIJKLMNOP."
```

### 8.2. Enumeraciones recursivas ###

Es posible combinar las características de las enumeraciones con valor
con la recursión para crear enumeraciones recursivas. Hay que preceder
la palabra clave `enum` con `indirect`:

```swift
indirect enum ExpresionAritmetica {
    case numero(Int)
    case suma(ExpresionAritmetica, ExpresionAritmetica)
    case multiplicacion(ExpresionAritmetica, ExpresionAritmetica)
}

let cinco = ExpresionAritmetica.numero(5)
let cuatro = ExpresionAritmetica.numero(4)
let suma = ExpresionAritmetica.suma(cinco, cuatro)
let producto = ExpresionAritmetica.multiplicacion(suma, ExpresionAritmetica.numero(2))
```

Es muy cómodo manejar enumeraciones recursivas de forma recursiva:

```swift
func evalua(expresion: ExpresionAritmetica) -> Int {
    switch expresion {
    case let .numero(valor):
        return valor
    case let .suma(izquierda, derecha):
        return evalua(expresion: izquierda) + evalua(expresion: derecha)
    case let .multiplicacion(izquierda, derecha):
        return evalua(expresion: izquierda) * evalua(expresion: derecha)
    }
}

print(evalua(expresion: producto))
// Imprime 18
```

Otro ejemplo de enums recursivos, para definir un tipo de datos
`Lista` similar al que vimos en Scheme. La lista puede ser una lista
vacía o puede contener dos elementos: un valor `Int` y otra lista:

```swift
indirect enum Lista {
    case vacia
    case nodo(Int, Lista)
}
```

Para crear una lista de tipo `nodo` deberemos dar un valor entero (el
valor de la cabeza de la lista) y otra lista (el resto de la
lista). También podemos crear una lista vacía.

Por ejemplo, podemos crear la lista `(10, 20, 30)` de la siguiente
manera:

```swift
let lista1 = Lista.nodo(30, Lista.vacia)
let lista2 = Lista.nodo(20, lista1)
let lista3 = Lista.nodo(10, lista2)
```

Podríamos crear esta misma lista de una forma más abreviada:

```swift
let lista: Lista = .nodo(10, .nodo(20, .nodo(30, .vacia)))
```

Una vez definido el tipo enumerado, podemos definir funciones que
trabajen con él. La siguiente función, por ejemplo, es una función
recursiva que recibe una lista y devuelve la suma de sus
elementos. Funciona de una forma muy similar a la definición que
hicimos en Scheme:

```swift
func suma(lista: Lista) -> Int {
    switch lista {
    case  .vacia:
        return 0
    case let .nodo(first, rest):
        return first + suma(lista: rest)
    }
}

let z: Lista = .nodo(20, .nodo(10, .vacia))

print(suma(lista: z))
// Imprime 30
```

Podemos también definir una función recursiva `construye(lista:[Int])`
que devuelve una lista a partir de una array de enteros:

```swift
func construye(lista: [Int]) -> Lista {
    if (lista.isEmpty) {
        return Lista.vacia
    } else {
        let primero = lista[0]
        let resto = Array(lista.dropFirst())
        return Lista.nodo(primero, construye(lista: resto))
    } 
}

let lista2 = construye(lista: [1,2,3,4,5])

print(suma(lista: lista2))
// Imprime 15
```

## 9. Opcionales

Una de las características principales que Swift intenta promover es
la seguridad y la robustez. Debe ser difícil que el desarrollador
escriba código con errores y que rompa la aplicación. Por ejemplo, la
comprobación estática de los tipos de datos o el manejo automático de
la gestión de memoria son dos características del lenguaje que van en
esta dirección.

Otro de los elementos más importantes del lenguaje para promover la
seguridad son los opcionales. Vamos a estudiar su uso y utilidad.

En muchos lenguajes existe el concepto de _valor vacío_. Por ejemplo,
en Java se usa _null_ o en Python _None_. 

!!! Note "Nota"
    Tony Hoare introdujo el concepto de _Null_ en ALGOL, en 1965. En
    una conferencia en 2009 habla sobre esta idea y la considera un
    costoso error: [Null References: The Billion Dollar
    Mistake](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare). 

El concepto de _null_ es un concepto peligroso, como lo saben bien los
desarrolladores Java. En Java, si intentamos usar una variable que
contiene _null_ se produce la típica excepción _null pointer
exception_ y la aplicación se rompe. Todos hemos caído en este error,
y con más frecuencia de la que sería deseable.

En Swift también existe el valor nulo. La forma de representarlo es el
identificador `nil`. 

La característica de seguridad que introduce Swift con respecto a Java
y a otros lenguajes es que no es posible asignar `nil` a una variable
de un tipo normal.

Por ejemplo, la siguiente línea daría un error de compilación:

```swift
let cadena: String = nil
// error: 'nil' cannot initialize specified type 'String'
```

Si queremos utilizar `nil` debemos declarar la variable usando lo que
se denomina **tipo opcional**:

```swift
var cadena: String? = "Hola"
cadena = nil
```

El tipo `String?` indica que podemos tener un valor `nil` o un valor
del tipo original. Primero estamos definiendo la variable `cadena` del
tipo `String?` (`String` opcional) y le estamos asignando un valor
determinado (de tipo `String`). Y después le asignamos `nil`.

El uso de opcionales es necesario en situaciones en las que podemos
obtener un valor desconocido. Por ejemplo, en alguna función en la que
pedimos un valor al usuario y el usuario puede no introducir
ninguno. O en estructuras de datos en las que hacemos búsquedas que
pueden no devolver ningún valor, como en un diccionario:

```swift
var edades = [
    "Raquel": 30,
    "Pedro": 22,
]
let edad1 = edades["Raquel"]
let edad2 = edades["Ana"] // devuelve nil
```

En el código anterior definimos un diccionario `edades` con claves de
tipo `String` y valores `Int`. Después buscamos en el diccionario por
la clave `"Raquel"` y se devuelve el valor `30`, que se guarda en la
variable `edad1`. Cuando se busca por la clave `"Ana"` se devuelve un
`nil` porque no está definida. 

Por ello, la variable `edad2` será de tipo `Int?` (`Int` opcional) y
contendrá un `nil`.

Un valor opcional no puede ser usado directamente. Primero debemos
comprobar si el valor es distinto de `nil` y sólo después podremos
usarlo. 

Para reforzar esto, Swift _esconde_ o _envuelve_ (_wrap_) el valor
real del opcional y obliga a llamar al operador `!` para
_desenvolverlo_ (_unwrap_) y usarlo. Este operador se denomina de
**desenvoltura forzosa** (_forced unwrapping_).

Por ejemplo, el siguiente código produce un error de compilación
porque intentamos usar un opcional sin desenvolverlo:

```swift
var x: Int? = 10
let y = x + 10 
// error: value of optional type 'Int?' must be unwrapped to a value of type 'Int'
```

Para usar el valor asignado a `x` debemos desenvolverlo con el
operador `!`:

```swift
var x: Int? = 10
let y = x! + 10 
print(y)
// Imprime "20"
```

Si se aplica el operador `!` a un valor `nil` se produce un error en
tiempo de ejecución y la aplicación se rompe:

```swift
var respuestaEncuesta: String?
print(respuestaEncuesta!)
// Fatal error: Unexpectedly found nil while unwrapping an Optional value
```

Podemos definir como opcional variables, parámetros
o valores devueltos por funciones de cualquier tipo, añadiéndoles la
interrogación al final.

Por ejemplo, la siguiente función `max` es una función que devuelve un
`Int?`, un entero opcional en el caso de que se le pase un array
vacío. Al devolver un opcional, debemos desenvolver el valor devuelto
cuando queramos usarlo como `Int` (por ejemplo, en la llamada recursiva).

```swift
func max(array:[Int]) -> Int? {
    if (array.isEmpty) {
        return nil
    } else if (array.count == 1) {
        return array[0]
    } else {
        let primero = array[0]
        let resto = Array(array.dropFirst())
        return max(primero, max(array:resto)!)
    }
}

let maximo = max(array:[10,200,-100,2])
print(maximo!)
// Imprime "200"
```

Una variable opcional sin asignar ningún valor se inicializa
automáticamente a `nil`:

```swift
var respuestaEncuesta: String?
// respuestaEncuesta es inicializado automáticamente a nil
```

### 9.1 Ligado opcional

Para comprobar si un valor opcional es `nil` podemos usar un `if`. Es
obligado hacerlo si desconocemos el valor que nos llega. Por ejemplo,
supongamos que la función `leerRespuesta()` lee una respuesta del
usuario y devuelve un `String?`. Para usar esta función deberíamos
comprobar si el valor devuelto es distinto de `nil`:

```swift
let respuestaEncuesta = leerRespuesta()
if respuestaEncuesta != nil {
    let respuesta = respuestaEncuesta!
    print("Respuesta: " + respuesta)
}
```

Como es muy habitual hacer lo anterior, en Swift es posible comprobar
si un opcional tiene valor y asignar su valor a otra variable al mismo
tiempo con una construcción llamada _ligado opcional_ (_optional
binding_):

```swift
let respuestaEncuesta = leerRespuesta()
if let respuesta = respuestaEncuesta {
    print ("Respuesta: " + respuesta)
}
```

Podemos leer el código anterior de la siguiente forma: "Si el
opcional `respuestaEncuesta` contiene un valor, define
la constante `respuesta` con el valor contenido en el opcional".

Una forma aún mejor de escribir el código anterior sería la siguiente,
en la que sólo usamos una variable:

```swift
// Mejor este código que el anterior
if let respuesta = leerRespuesta() {
    print ("Respuesta: " + respuesta)
}
```

!!! Note "Nota"
    Para no tener que buscar un nuevo nombre de variable, Swift permite 
    usar el mismo nombre de variable en la sentencia `if let`:

    ```swift
    var x: Int? = 0
    if let x = x {
        print(x)
    }
    ```
    La variable `x` creada por el `if let` es de tipo no opcional y sólo tiene valor 
    en el ámbito del `if`.

Otro ejemplo, el método `first` de un array devuelve un opcional que
contiene `nil` si el array está vacío o el primer elemento del array
en el caso en que exista. El siguiente código utiliza un ligado
opcional para implementar otra versión de la función que suma los
valores de un array:

```swift
func sumaValores(_ valores: [Int]) -> Int {
    if let primero = valores.first {
        let resto = Array(valores.dropFirst())
        return primero + sumaValores(resto)
    } else {
        return 0
    }
}

print(sumaValores([1,2,3,4,5,6,7,8])) 
// Imprime "36"
```

Si tenemos varios opcionales es posible comprobar que todos ellos son
distintos de `nil` usando varios `let` en el mismo `if`:

```swift
var x1: Int? = pedirNumUsuario()
var x2: Int? = pedirNumUsuario()
var x3: Int? = pedirNumUsuario()
if let dato1 = x1, let dato2 = x2, let dato3 = x3 {
   let suma = dato1+dato2+dato3
   print("Ningún nil y la suma de todos los datos es: \(suma)")
} else {
   print("Algún dato del usuario es nil")
}
```

### 9.2. Operador _nil-coalescing_ ###

El operador _nil-coalescing_ (`??`) permite definir un valor por
defecto en una asignación si un opcional es nil.

```swift
let a: Int? = nil
let b: Int? = 10
let x = a ?? -1
let y = b ?? -1
print("Resultado: \(x), \(y)")
// Imprime Resultado: -1, 10
```

En el ejemplo anterior, en la variable `x` se guardará el valor `-1` y
en la variable `y` el valor `10`.

### 9.3. Encadenamiento de opcionales ###

El encadenamiento de opcionales (_optional chaining_) permite llamar a
un método de una variable que contiene un opcional. Si la variable no
es `nil`, se ejecuta el método y se devuelve su valor como un
opcional. Si la variable es `nil` se devuelve `nil`.


```swift
let nombre1: String? = "Pedro"
let nombre2: String? = nil

// Error: let str1 = nombre1.lowercased()
// No podemos llamar al método lowercased() del String
// porque nombre es opcional y puede tener nil

let str1 = nombre1?.lowercased()
let str2 = nombre2?.lowercased()
// str1: String? = "pedro"
// str2: String? = nil
```


### 9.4. Definición de `Lista` con opcionales

Veamos como último ejemplo una segunda versión del enum `Lista`, en el que
utilizamos un único `case`, pero dando la posibilidad de que el resto
de la lista sea `nil` haciéndolo opcional.

Definimos el enumerado y también la función `suma(lista:)`:

```swift
indirect enum Lista{
	case nodo(Int, Lista?)
}

func suma(lista: Lista) -> Int {
	switch lista {
		case let .nodo(first, rest):
		if (rest == nil) {
			return first
		} else {
			return first + suma(lista: rest!)
		}
	}
}

let z: Lista = .nodo(20, .nodo(10, nil))
print(suma(lista: z))
/// Devuelve 30
```


## 10. Clausuras

Ya hemos visto previamente que en Swift las funciones son objetos de
primera clase del lenguaje y que es posible definir funciones y
pasarlas como parámetro de otras funciones. 

También es posible construir clausuras, funciones definidas en el
ámbito de otras funcionas y devueltas como resultados.

Veremos primero cómo definir de forma compacta funciones que se pasan
como parámetro de otras, utilizando _expresiones de clausuras_. Y
después veremos cómo las clausuras definidas en el interior de otras
funciones capturan las variables definidas en el ámbito de la función principal.


### 10.1. Expresiones de clausuras

Swift permite definir expresiones compactas con las que construir
estas funciones que se pasan como parámetro de otras funciones. Se
denominan _expresiones de clausuras_ (_closure expressions_). Estas
expresiones proporcionan optimizaciones de sintaxis para escribir
clausuras de forma concisa y clara. Vamos a ver las distintas
optimizaciones utilizando como ejemplo el método `sorted(by:)`.

### 10.2. El método `sorted(by:)`

Tal y como hemos visto anteriormente la biblioteca stándar de Swift
define un método `sorted()` que devuelve los elementos ordenados de un
[Array](https://developer.apple.com/reference/swift/array). El array
original no se modifica. La comparación entre los elementos se realiza
usando el comparador `<`.

Veamos un ejemplo con un array de cadenas:

```swift
let estudiantes = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
let ordenados = estudiantes.sorted()
print(ordenados)
// Imprime "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
```

Esta función es similar a las que hay en muchos lenguajes. El único
aspecto funcional es que el array original no se modifica, sino que la
ordenación construye un nuevo array (existe una función alternativa
mutable que se denomina `sort()`). 

Lo interesante relacionado con las clausuras está en la función
`sorted(by:)`. En esta función se utiliza una clausura como parámetro
para modificar la comparación entre elementos y resultar en una
ordenación distinta. Es una de las distintas funciones de orden
superior que se definen en las colecciones (más adelante veremos
otras).

El perfil de la función `sorted(by:)` es:

```
func sorted(by areInIncreasingOrder: (Element, Element) -> Bool)
```

El parámetro es una función de dos parámetros (del tipo de los
elementos del array) que devuelve un booleano indicando si el primer
parámetro va antes que el segundo en el array ordenado. La clausura de
ordenación devuelve `true` si el primer valor debería aparecer antes
del segundo valor y `false` en otro caso.

Por ejemplo, podríamos ordenar un array de cadenas en orden alfabético
inverso. 

```swift
func primeroMayor(s1: String, s2: String) -> Bool {
    return s1 > s2
}
let estudiantes = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
let alreves = estudiantes.sorted(by: primeroMayor)
print(alreves)
// Imprime ["Peter", "Kweku", "Kofi", "Akosua", "Abena"]
```

Si la primera cadena (`s1`) es mayor que la segunda cadena (`s2`), la
función `primeroMayor(s1:s2:)` devolverá `true`, indicando que `s1`
debería aparecer antes que `s2` en el array ordenado. La ordenación
mayor o menor se refiere a la ordenación alfabética, al estar tratando
con caracteres.

La versión anterior esta es una forma bastante complicada de escribir
lo que básicamente es una función de una única expresión (`a > b`). En
este ejemplo, sería preferible escribir la clausura de ordenación
_inline_, utilizando la sintaxis de expresiones de clausuras.

### 10.3. Sintaxis de las expresiones de clausura

La sintaxis de las expresiones de clausura tiene la siguiente forma
general:

```text
{ ( <parametros>) -> <tipo devuelto> in
   <sentencias>
}
```

Si aplicamos esta sintaxis al ejemplo anterior:

```swift
let alreves = estudiantes.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

Hay que hacer notar que la declaración de los parámetros y el tipo
devuelto por esta clausura _inline_ es idéntica a la declaración de la
función `primeroMayor(s1:s2:)`. En ambos casos, se escribe como `(s1:
String, s2: String) -> Bool`. Sin embargo, en la expresión de clausura
los parámetros y el tipo devuelto se escribe dentro de las llaves, no
fuera.

El comienzo del cuerpo de la clausura se introduce por la palabra
clave `in`. Esta palabra clave indica que la definición de los
parámetros y del tipo devuelto por la clausura ha terminado, y que el
cuerpo de la clausura va a comenzar.

Como el cuerpo de la clausura es corto, podemos incluso escribirlo en
una única línea:

```swift
let alreves = estudiantes.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
```

### 10.4. Inferencia del tipo por el contexto

Como la clausura de ordenación se pasa como argumento de un método,
Swift puede inferir los tipos de sus parámetros y el tipo del valor
que devuelve. El método `sorted(by:)` se llama sobre un array de cadenas,
por lo que su argumento debe ser una función del tipo `(String,
String) -> Bool`. Esto significa que los tipos `(String, String)` y
`Bool` no necesitan escribirse como parte de la definición de la
expresión de la clausura. Debido a que todos los tipos pueden ser
inferidos, la flecha del tipo devuelto y los paréntesis alrededor de
los nombres de los parámetros también pueden omitirse:

```swift
let alreves = estudiantes.sorted(by: { s1, s2 in return s1 > s2 } )
```

### 10.5. Devoluciones implícitas en clausuras con una única expresión

En clausuras con una única expresión podemos omitir también la palabra
clave `return`:

```swift
let alreves = estudiantes.sorted(by: { s1, s2 in s1 > s2 } )
```

### 10.6. Abreviaturas en los nombres de los argumentos

Swift proporciona automáticamente abreviaturas para los nombres de
argumentos de las clausuras _inline_ que pueden usarse para referirse
a los valores de los argumentos de la clausura usando los nombres
`$0`, `$1`, `$2`, etc.

Si se usa estos argumentos abreviados, se puede omitir la definición
de la lista de los argumentos:

```swift
let alreves = estudiantes.sorted(by: { $0 > $1 } )
```

### 10.7. Funciones operadoras

Incluso hay una forma aun más corta de escribir la expresión de
clausura anterior.  Swift define una implementación específica de
cadenas del operador mayor-que (`>`) como una función que tiene dos
parámetros de tipo `String` y devuelve un `Bool`. Esto es exactamente
lo que necesita el método `sorted(by:)`. Podemos, por tanto, pasar
simplemente este operador mayor-que, y Swift inferirá que queremos
usar el específico de cadenas:

```swift
let alreves = estudiantes.sorted(by: >)
```

### 10.8. Clausuras al final

Si necesitamos pasar una expresión de clausura a una función como el
argumento final de la clausura y la expresión es larga, puede ser útil
escribirla en su lugar como una clausura al final (_trailing
closure_). Una clausura al final es una expresión de clausura que se
escribe fuera de (y después de) los paréntesis de la función a la que
se le pasa como parámetro:

```swift
let alreves = estudiantes.sorted() { $0 > $1 }
```

Cuando se proporciona una expresión de clausura como único argumento de
una función o método y se pasa como una clausura al final, no es
necesario escribir los paréntesis tras el nombre de la función:

```swift
let alreves = estudiantes.sorted { $0 > $1 }
```


### 10.9. Variables capturadas

!!! Danger "Cuidado"
    Los ejemplos que vamos a ver a continuación no usan programación
    funcional, porque la variable capturada por la clausura es una
    variable **mutable** (se ha definido con `var` y no con `let`). Por
    eso las funciones resultantes no son funciones puras, sino que
    devuelven un valor distinto cada vez que son invocadas. Son 
    funciones con estado local mutable.

Una clausura puede capturar constantes y variables del contexto en el
que se define. La clausura puede referirse y modificar esos valores
dentro de su cuerpo, incluso si ya no existe el ámbito (_scope_)
original en el que se definieron estas constantes y variables.

En Swift, la forma más sencilla de una clausura que captura variables es
una función anidada (_nested function_) escrita en el cuerpo de otra
función. Una función anidada puede capturar cualquiera de los
argumentos de su función exterior y también puede capturar cualquier
constante y variable definida dentro de la función exterior.

Veamos un ejemplo similar al que vimos en Scheme. La función
`construyeIncrementador` contiene una función anidada llamada
`incrementador`. Esta función captura dos variables de su contexto:
`totalAcumulado` y `cantidad`. Después de capturar estas variables,
`incrementador` es devuelto por `construyeIncrementador` como una
clausura que incrementa `totalAcumulado` en `cantidad` cada vez que se
llama.

```swift
func construyeIncrementador(incremento cantidad: Int) -> () -> Int {
    var totalAcumulado = 0
    func incrementador() -> Int {
        totalAcumulado += cantidad
        return totalAcumulado
    }
    return incrementador
}
```

El tipo devuelto de `construyeIncrementador` es `() -> Int`. Esto
significa que devuelve una función que no tiene parámetros y que
devuelve un `Int` cada vez que es llamada.

La función `construyeIncrementador(incremento:)` tiene un único
parámetro `Int` con nombre externo `incremento` y nombre local
`cantidad`. El argumento pasado a este parámetro especifica cuánto
será incrementado `totalAcumulado` cada vez que se llama a la función
`incrementador` devuelta. La función `construyeIncrementador` define
una función anidada llamada `incrementador`, que realiza el incremento
real. Esta función simplemente añade `cantidad` a `totalAcumulado`, y
devuelve el resultado.

Si la consideramos aislada, la función anidada `incrementador()`
podría parecer extraña:

```swift
func incrementador() -> Int {
    totalAcumulado += cantidad
    return totalAcumulado
}
```

La función no tiene ningún parámetro, y sin embargo se refiere a
`totalAcumulado` y a `cantidad` en su cuerpo. Lo puede hacer porque ha
capturado una referencia a estas variables de la función de alrededor
y las usa en su propio cuerpo. Al capturar estas referencias las
variables `totalAcumulado` y `cantidad` no desaparecen cuando termina
la llamada a `construyeIncrementador`. Estas variables también estarán
disponibles la próxima vez que se llame la función `incrementador`.

Aquí hay un ejemplo de `construyeIncrementador` en acción:

```swift
let incrementaDiez = construyeIncrementador(incremento: 10)
```

Este ejemplo define una constante llamada `incrementaDiez` para
referenciar la función `incrementador` que devuelve
`construyeIncrementador`. Esta función añade 10 a la variable
`totalAcumulado` cada vez que se es llamada. Si llamamos a la función
más de una vez podemos comprobar su conducta en acción:

```swift
incrementaDiez()
// devuelve 10
incrementaDiez()
// devuelve 20
incrementaDiez()
// devuelve 30
```

Si creamos un segundo incrementador, tendrá sus propias referencias a
un variable `totalAcumulado` nueva, distinta de la anterior:

```swift
let incrementaSiete = construyeIncrementador(incremento: 7)
incrementaSiete()
// devuelve 7
```

Si llamamos a la función `incrementador` original (`incrementaDiez`)
vemos que sigue incrementando su propia variable `totalAcumulado` y
que no se ve afectada por la variable capturada por `incrementaSiete`:

```swift
incrementaDiez()
// devuelve 40
```


### 10.10. Clausuras con expresiones de clausura ###

En el ejemplo anterior hemos usado una definición interna de una
función para definir la clausura que se devuelve. Lo hemos hecho por
claridad, pero no es necesario. Es posible escribir un código más
compacto usando expresiones de clausura.

Por ejemplo, la función `construyeSumador()` vista en el apartado
"Funciones que devuelven otras funciones":

```swift
func construyeSumador10() -> (Int) -> Int {
  func suma10(x: Int) -> Int {return x+10}
  return suma10
}
```

Una versión de esta misma función usando una expresión de clausura es
la siguiente:

```swift
func construyeSumador10() -> (Int) -> Int {
    return {$0 + 10}
}

var f = construyeSumador10()
print(f(20))
// Imprime "30"
```

Y lo mismo con la función `constryeIncrementador(incremento:)` vista
en el apartado anterior:

```swift
func construyeIncrementador(incremento cantidad: Int) -> () -> Int {
    var totalAcumulado = 0
    func incrementador() -> Int {
        totalAcumulado += cantidad
        return totalAcumulado
    }
    return incrementador
}
```

La versión con una expresión de clausura:

```swift
func construyeIncrementador(incremento cantidad: Int) -> () -> Int {
    var totalAcumulado = 0
    return {totalAcumulado += cantidad
            return totalAcumulado}
}

let incrementaDiez = construyeIncrementador(incremento: 10)
print(incrementaDiez())
// Imprime "10"
print(incrementaDiez())
// Imprime "20"
```


### 10.11. Variables capturadas por clausuras y variables del ámbito de invocación ###

Las clasuras usan las variables capturadas y no las variables declaradas
en el ámbito en el que se invoca a la clausura. Vamos a explicarlo con un ejemplo.

```swift linenums="1" hl_lines="2 14 20"
func construyeFunc() -> () -> Int {
   var x = 0
   return {
      x = x + 1
      return x
   }
}

let f = construyeFunc()
print(f()) // -> 1
print(f()) // -> 2

func usaFunc(_ f: () -> Int) -> Int {
     var x = 10
     return f()
}

print(usaFunc(f)) // -> 3

var x = 100
print(usaFunc {return x + 10}) // -> 110
```

En el código anterior se resaltan las tres declaraciones de variables
`x`. Es muy importante comprobar el ámbito en el que se realizan esas
declaraciones. La primera declaración se realiza dentro de la función
`construyeFunc()`, la segunda dentro de la función `usaFunc()` y la
tercera en el ámbito global. En cada caso, la variable se inicializará
cuando se ejecute esa línea de código. 

La función `usaFunc` definida en la línea 13 recibe una función `f`
sin parámetros que devuelve un entero. En el ámbito local de `usaFunc`
se define la variable local `x` que tiene el valor `10` antes de
invocar a la función `f` recibida.

¿Qué pasa si la función recibida es una clausura que ha capturado una
variable que también se llama `x`? En el caso de la invocación a
`usaFunc` que hay en la línea 18, la función `f` que se pasa como
parámetro es la clausura obtenida en la línea 9. Esta clausura ha
capturado la variable `x` definida en la línea 2. Y en ese momento
esa variable tiene el valor 2. El código de la clausura es el definido
en las líneas 3 a 6:

```swift
{
x = x + 1
return x
}
```

¿A qué variable `x` se refiere ese código? ¿A la variable capturada que
tiene un valor de 2? ¿O a la variable en el ámbito de ejecución (línea
14) que tiene un valor de 10?

Si ejecutamos el código veremos que la expresión devuelve 3. O sea que
las clausuras usan siempre las variables capturadas.

Podemos comprobarlo también en la invocación de la línea 21. Ahí la
clausura que se pasa es una expresión de clausura que captura la
variable `x` definida en la línea anterior. Por eso cuando se ejecuta
la sentencia se imprime el valor `110` y no el valor `20`.


### 10.12. Las clausuras son tipos de referencia

En el ejemplo anterior, `incrementaSiete` e `incrementaDiez` son
constantes, pero las clausuras a las que estas constantes se refieren
pueden incrementar la variable `totalAcumulado` que han
capturado. Esto es porque funciones y clausuras son tipos referencia.

Siempre que asignamos una función o una clausura a una constante o una
variable, estamos realmente estableciendo que la constante o variable
es una referencia a la función o la clausura. En el ejemplo anterior,
es la elección de la clausura a la que referencia `incrementaDiez` la
que es constante, no los contenidos propios de la clausura.

Esto también significa que si asignamos una clausura a dos constantes
o variables distintas, ambas constantes o variables se referirán a la
misma clausura:

```swift
let tambienIncrementaDiez = incrementaDiez
tambienIncrementaDiez()
// devuelve 50
```


## 11. Funciones de orden superior

Una de las características funcionales que más hemos usado para
trabajar con listas en Scheme son las funciones de orden superior como
`map`, `filter` o `foldl`. Swift tiene definidas funciones
equivalentes para trabajar con colecciones. Se denominan `map`,
`filter` y `reduce`. Todas ellas aceptan expresiones de clausura como
argumento.

### 11.1 Map

El método `map` se define en el protocolo
[`CollectionType`](https://developer.apple.com/library/ios/documentation/Swift/Reference/Swift_CollectionType_Protocol/index.html#//apple_ref/swift/intfm/CollectionType/s:FEsPs14CollectionType3mapurFzFzWx9Generator7Element_qd__GSaqd___)
y es adoptado por múltiples estructuras como `Array`, `Dictionary`,
`Set`.

El perfil del método `map` es el siguiente:

```swift
func map<T>(_ transform: (Element) -> T) -> [T]
```

Se trata de un método genérico (lo veremos más adelante) que recibe
como parámetro una función unaria (función de transformación) 
del tipo de los elementos de la colección y que devuelve otro elemento
(puede ser del mismo o de distinto tipo que los elementos de la
colección). Devuelve un array que contiene el resultado de aplicar
la función de transformación a cada elemento del array original.

Por ejemplo:

```swift
let numeros = [Int](0...5)
numeros.map {$0 * $0}
// devuelve [0, 1, 4, 9, 16, 25]
```

Otro ejemplo, en el que usamos `map` para implementar la función
`sumaParejas(parejas: [(Int, Int)]) -> [Int]` que devuelve recibe el
array `parejas` de tuplas de dos enteros y devuelve un array con el
resultado de sumar los dos elementos de cada pareja:

```swift
func suma(parejas: [(Int, Int)]) -> [Int] {
   return parejas.map({(pareja: (Int, Int)) -> Int in
                        return pareja.0 + pareja.1})
}
suma(parejas:[(1, 1), (2, 2), (3, 3), (4, 4)])
// devuelve [2, 4, 6, 8]
```

Podemos usar en el cuerpo de la expresión de clausura de `map` una
variable capturada. Por ejemplo en la siguiente función
`incrementaValores(_:con:)` que suma `con` a todos los números de un
array que se le pasa por parámetro:

```swift
func incrementa(valores: [Int], con: Int) -> [Int] {
   return valores.map({(x: Int) -> Int in
                        return x + con})
}
incrementa(valores:[10, 20, 30], con: 5)
// devuelve [15, 25, 35]
```
La versión abreviada de la expresión de clausura es:

```swift
func incrementa(valores: [Int], con inc: Int) -> [Int] {
   return valores.map {$0 + inc}
}
incrementa(valores: [10, 20, 30], con: 5)
// devuelve [15, 25, 35]
```


### 11.2. Filter


La función `filter` es también igual que la definida en Scheme. Su
perfil es:

```swift
func filter(_ isIncluded: (Element) -> Bool) -> [Element]
```

Recibe una clausura de un argumento que devuelve
un booleano. La función devuelve un array con los elementos de la
colección para los que la clausura devuelve _true_. 

Ejemplo:

```swift
let numeros = [Int](0...10)
numeros.filter {$0 % 2 == 0}
// devuelve [0, 2, 4, 6, 8, 10]
```


### 11.3. Reduce 

Similar al _foldl_ de Scheme. Su perfil es el siguiente:


```swift
func reduce<Result>(_ initialResult: Result, 
                    _ nextPartialResult: (Result, Element) -> Result) -> Result
```

Es una función genérica que devuelve un valor de un tipo genérico (el
tipo del resultado que se construye en la función). Recibe como
parámetro un valor inicial y una _función de plegado_ que se aplica al
resultado anterior y al elemento de la colección, devolviendo un
resultado. El resultado final es el resultado de aplicar la función de
plegado a todos los elementos de la colección, empezando por el valor
inicial.

Por ejemplo, podemos usar `reduce` para sumar todos los números de un array:


```swift
let numeros = [Int](0...10)
numeros.reduce(0, +)
```

La función combina los elementos de la colección usando la función de
combinación que se pasa como parámetro. La función que se pasa como
parámetro recibe dos parámetros: el primero es el resultado de la
combinación y el segundo se coge de la colección. 

Por ejemplo, el siguiente código usa `reduce` para sumar la longitud
de todas las cadenas de un array:

```swift
let cadenas = ["Patatas", "Arroz", "Huevos"]
cadenas.reduce(0, {(i: Int, c: String) -> Int in
                      c.count + i })
// devuelve 18
```

Es posible simplificar la notación anterior:

```swift
cadenas.reduce(0, {$1.count + $0})
```

También se puede utilizar la notación de clausura al final:

```swift
cadenas.reduce(0) {$1.count + $0}
```

La combinación se hace de izquierda a derecha:

```swift
let cadenas = ["Patatas", "Arroz", "Huevos"]
let cadenas = ["Patatas","Arroz", "Huevos"]
print(cadenas.reduce("*", {$0 + "-" + $1}))
// Imprime "*-Patatas-Arroz-Huevos"
```

El primer argumento de la función de plegado (`$0`) es el resultado
anterior (empieza por `"*"`) y el segundo argumento (`$1`) se coge del
array de cadenas.


### 11.4. Combinación de funciones de orden superior

Cuando el resultado de aplicar una función de orden superior a una
colección es otra colección es posible aplicar otra función de
orden superior a este resultado.

Por ejemplo, la siguiente sentencia devuelve todos los números pares
del array inicial elevados al cuadrado:


```swift
let numeros = [1,2,3,4,5,6,7,8,9,10]
numeros.filter{$0 % 2 == 0}.map{$0*$0}
// Devuelve el array [4,16,36,64,100]
```

Y la siguiente devuelve la suma números mayores de 100:

```swift
let numeros = [103, 2, 330, 42, 532, 6, 125]
numeros.filter{$0 >= 100}.reduce(0,+)
// Devuelve 1090
```


## 12. Genéricos


Empecemos con un ejemplo sencillo. Supongamos la siguiente función
`intercambia(_:)` que recibe una tupla `(Int, String)` y devuelve una
tupla `(String, Int)` con los valores intercambiados.

```swift
func intercambia(_ tupla: (Int, String)) -> (String, Int) {
   let tuplaNueva = (tupla.1, tupla.0)
   return tuplaNueva
}

let tupla = (10, "Hola")
intercambia(tupla)
// devuelve ("Hola", 10)
```

La función es interesante, pero sólo recibe tuplas cuya primera
componente es un `Int` y su segunda componente es un
`String`. Supongamos que queremos hacer la misma función para
intercambiar elementos de una tupla `(Int, Int)`. Tendríamos que usar
el mismo código, pero cambiando los tipos:

```swift
func intercambia(_ tupla: (Int, Int)) -> (Int, Int) {
   let tuplaNueva = (tupla.1, tupla.0)
   return tuplaNueva
}

let tupla = (10, 20)
intercambia(tupla)
// devuelve (20, 10)
```

El código es el mismo, lo único distinto son los tipos. ¿Podríamos
**generalizar** las funciones anteriores para hacer que el código
pueda trabajar con cualquier tipo? La respuesta es sí, usando
**función genérica**:

```swift
func intercambia<A,B>(_ tupla: (A, B)) -> (B, A) {
   let tuplaNueva = (tupla.1, tupla.0)
   return tuplaNueva
}
```

El cuerpo de la función es idéntico a la función anterior. La
diferencia es que en la versión genérica se usan *placeholders* (los
símbolos `A` y `B`) en lugar de tipos concretos. Son tipos genéricos,
que se definen usando un identificador entre símbolos de `<` y
`>`. Los tipos reales que se van a usar en la función se determinan en
cada invocación a la función, dependiendo del tipo del parámetro que
se utiliza en la llamada:

```swift
let tupla = (10, "Hola")
intercambia(tupla)
// devuelve ("Hola", 10)
let tupla2 = (10, 20)
intercambia(tupla2)
// devuelve (10, 20)
let tupla3 = (true, 10.5)
intercambia(tupla3)
// devuelve (10.5, true)
```

En el primer ejemplo, los tipos `A` y `B` se infieren como `Int` y
`String`. En el segundo ejemplo como `Int` e `Int`. Y en el tercero
como `Bool` y `Double`.

Los tipos genéricos se pueden usar en la definición de todos los
elementos de Swift: funciones, enums, estructuras, clases, protocolos
o extensiones. Terminamos con un ejemplo en el que incluimos muchos
conceptos vistos en este tema. Se trata de la implementación en Swift
de listas al estilo Scheme, con las funciones `first`, `resty `vacia`
usando un enum recursivo con un tipo genérico que permite generalizar
el tipo de elementos de la lista.

```swift
indirect enum Lista<T> {
     case vacia
     case nodo(T, Lista<T>)
}

func first<T>(_ lista: Lista<T>) -> T? {
   switch lista {
      case let .nodo(primero, _):
         return primero
      case .vacia:
         return nil
   }
}

func rest<T>(_ lista: Lista<T>) -> Lista<T>? {
   switch lista {
      case let .nodo(_, resto):
         return resto
      case .vacia:
         return nil
   }
}

func vacia<T>(_ lista: Lista<T>) -> Bool {
   switch lista {
      case .vacia:
         return true
      default:
         return false
   }
}

let lista : Lista = .nodo(20, .nodo(30, .nodo(40, .vacia)))

print(first(lista)!) // Imprime 20
print(first(rest(lista)!)!) // Imprime 30
print(first(rest(rest(lista)!)!)!) // Imprime 40
print(vacia(rest(rest(rest(lista)!)!)!)) // Imprime true
```


## 13. Bibliografía

- Swift Language Guide
    - [The Basics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)
    - [Collection Types](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)
    - [Functions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158)
    - [Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)
    - [Enumerations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145)
    - [Generics](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)
- [Biblioteca estándar de Swift](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/)

----

Lenguajes y Paradigmas de Programación, curso 2021–22  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez


## Tema 6: Programación Funcional con Swift

### Contenidos

- **1 Introducción**
- **2 Funciones**
- **3 Tipos función**
- **4 Recursión**
- **5 Tipos**
- **6 Opcionales**
- 7 Inmutabilidad
- 8 Clausuras
- 9 Funciones de orden superior
- 10 Genéricos

----

### Bibliografía

- [Seminario de Swift](https://github.com/domingogallardo/apuntes-lpp/blob/master/seminarios/seminario2-swift/seminario2-swift.md)
- Swift Language Guide
    - [The Basics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)
    - [Collection Types](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)
    - [Functions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158)
    - [Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)
    - [Enumerations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145)
- [Biblioteca estándar de Swift](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/)

----
### 1. Introducción
----

### Swift

Swift es un lenguaje principalmente imperativo, pero en su diseño se
han introducido conceptos modernos de programación funcional,
extraídos de lenguajes como Rust o Haskell. 

Como dice su creador [Chris Lattner](http://nondot.org/sabre/):

> El lenguaje Swift es el resultado de un esfuerzo incansable de un
> equipo de expertos en lenguajes, gurús de documentación, ninjas de
> optimización de compiladores [..]. Por supuesto, también se
> benefició enormemente de las experiencias ganadas en muchos otros
> lenguajes, tomando ideas de Objective-C, Rust, Haskell, Ruby,
> Python, C#, CLU, y demasiados otros para ser enumerados.


Vamos a repasar en este tema cómo se implementan en Swift conceptos
principalmente funcionales como:

- Valores inmutables
- Funciones como objetos de primera clase y clasuras
- Funciones de orden superior

----

### Ejecución de programas Swift

- Consultar en el seminario de Swift la forma de instalar el
  compilador de Swift: usando un contenedor Docker, usando el terminal
  (Mac) o en Linux.

Visual Code Studio con un terminal y con el comando docker para
ejecutar Swift:

<img src="imagenes/vcode.png" width="700px"/>

----

### Swift es fuertemente tipeado

- Swift es un lenguaje fuertemente tipeado, pero es posible no
  escribir el nombre del tipo en aquellos casos en los que el
  compilador pueda **inferirlo**.
- Por ejemplo, cuando se hace una asignación.

```swift
var x = 10
// x: Int = 10
var cadena = "Hola"
// cadena: String = "Hola"
var p = true
// p: Bool = true
```

----

### Repaso algunos conceptos PF

- Programación Funcional:

> La Programación Funcional es un paradigma de programación que trata
> la computación como la evaluación de funciones matemáticas y que
> evita cambios de estado y datos mutables.

- Funciones matemáticas o puras

> Las funciones matemáticas tienen la característica de que cuando las
> invocas con el mismo argumento siempre te devolverán el mismo
> resultado.

- Funciones como objetos de primera clase:

> En programación funcional, las funciones son objetos de primera
> clase del lenguaje, similares a enteros o _strings_. Podemos pasar
> funciones como argumentos en las denominadas _funciones de orden
> superior_ o devolver funciones creadas en tiempo de ejecución
> (clausuras).


----
### 2. Funciones
----

### Definición de una función en Swift

- Para definir una función en Swift se debe usar la palabra `func`,
definir el nombre de la función, sus parámetros y el tipo de vuelto.
- El valor devuelto por la función se debe devolver usando la palabra
`return`.

Ejemplo función `saluda(nombre:)`:

```swift
func saluda(nombre: String) -> String {
    let saludo = "Hola, " + nombre + "!"
    return saludo
}
```

Invocación a la función `saluda(nombre:)`:

```swift
print(saluda(nombre:"Ana"))
print(saluda(nombre:"Pedro"))
// Imprime "Hola, Ana!"
// Imprime "Hola, Pedro!"
```

----

### Etiquetas de argumentos y nombres de parámetros

- Cada parámetro de una función tiene una **etiqueta del argumento** y
un **nombre de parámetro**.
- Por defecto, los parámetros usan su nombre de parámetro como etiqueta
del argumento

```swift
func unaFuncion(primerNombreParametro: Int, segundoNombreParametro: Int) {
    // En el cuerpo de la función, primerNombreParametro y
    // segundoNombreParametro se refieren a los valores de los
    // argumentos del primer y el segundo parámetro
}
unaFuncion(primerNombreParametro: 1, segundoNombreParametro: 2)
```

- Es posible hacer distintos la etiqueta del argumento del nombre del
parámetro:

```swift
func saluda(nombre: String, de ciudad: String) -> String {
    return "Hola \(nombre)! Me alegro de que hayas podido visitarnos desde \(ciudad)."
}
print(saluda(nombre: "Bill", de: "Cupertino"))
// Imprime "Hola Bill! Me alegro de que hayas podido visitarnos desde Cupertino."
```

- Otro ejemplo, la siguiente función `concatena(palabra:con:)`: 

```swift
func concatena(palabra str1: String, con str2: String) -> String {
    return str1+str2
}

print(concatena(palabra:"Hola", con:"adios"))
```

- Si no se quiere una etiqueta del argumento para un parámetro, se puede
escribir un subrayado (`_`) en lugar de una etiqueta del argumento
explícita para ese parámetro:

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

- El perfil de la función está formado por el nombre de la función,
las etiquetas de los argumentos y el tipo devuelto por la función. En
la documentación de las funciones usaremos las etiquetas separadas por
dos puntos. Por ejemplo, las funciones anteriores son `max(_:_:)` y
`divide(_:entre:)`.

----

### Parámetros y valores devueltos

- Es posible definir funciones sin parámetros:

```swift
func diHolaMundo() -> String {
    return "hola, mundo"
}
print(diHolaMundo())
// Imprime "hola, mundo"
```


- Podemos definir funciones sin valor devuelto. Por ejemplo, la
  siguiente función `diAdios(nombre:)`. No hay que escribir flecha con
  el tipo devuelto. Cuidado, no sería propiamente programación
  funcional.

```swift
func diAdios(nombre: String) {
    print("Adiós, \(nombre)!")
}
diAdios(nombre:"Dave")
// Imprime "Adiós, Dave!"
```

- Es posible devolver múltiples valores, construyendo una tupla. Por
  ejemplo, la siguiente función `minMax(array:)` busca el número más
  pequeño y más grande de un array de enteros.

```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var minActual = array[0]
    var maxActual = array[0]
    for valor in array[1..<array.count] {
        if valor < minActual {
            minActual = valor
        } else if valor > maxActual {
            maxActual = valor
        }
    }
    return (minActual, maxActual)
}
```

- Los valores de la tupla devuelta se etiquetan y se puede acceder por
  esos nombres cuando se consulta el valor devuelto por la función:

```swift
let limites = minMax(array: [8, -6, 2, 109, 3, 71])
print("min es \(limites.min) y max es \(limites.max)")
// Imprime "min es -6 y max es 109"
```

----
### 3. Tipos función 
----

### Funciones como objetos de primera clase

- En Swift las funciones son objetos de primera clase y podemos
  asignarlas a variables, pasarlas como parámetro o devolverlas como
  resultado de otra función. Al ser un lenguaje fuertemente tipado,
  las variables, parámetros o resultados deben ser objetos de tipo
  función.

- Cada función tiene un tipo específico, definido por el tipo de sus
parámetros y el tipo del valor devuelto.

```swift
func sumaDosInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplicaDosInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
```

- El tipo de estas funciones es `(Int, Int) -> Int`

- En Swift se puede usar un tipo función de la misma forma que
  cualquier otro tipo:

```swift
var funcionMatematica: (Int, Int) -> Int = sumaDosInts
print("Resultado: \(funcionMatematica(2, 3))")
funcionMatematica = multiplicaDosInts
print("Resultado: \(funcionMatematica(2, 3))")
```

----

### Funciones que reciben otras funciones

- Podemos usar un tipo función en parámetros de otras funciones:

```swift
func printResultado(funcion: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Resultado: \(funcion(a, b))")
}
printResultado(funcion: sumaDosInts, 3, 5)
// Prints "Resultado: 8"
```

- Veamos otro ejemplo, que ya vimos en Scheme. Supongamos que queremos
  calcular el sumatorio desde `a` hasta `b` en el que aplicamos una
  función `f` a cada número que sumamos:

```text
sumatorio(a, b, f) = f(a) + f(a+1) + f(a+2) + ... + f(b)
```

- Recordamos que se resuelve con la siguiente recursión:

```text
sumatorio(a, b, f) = f(a) + sumatorio(a+1, b, f)
sumatorio(a, b, f) = 0 si a > b
```

- Implementación en Swift: 

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

----

### Funciones en estructuras de datos

- Las funciones pueden también incluirse en estructuras de datos
  compuestas, como arrays:
  
```swift
let funciones = [identidad, doble, cuadrado]
print(funciones[0](10)) // 10
print(funciones[1](10)) // 20 
print(funciones[2](10)) // 100
```

----


### Funciones que devuelven otras funciones

- Por último, veamos un ejemplo de funciones que devuelven otras
  funciones.
- Empecemos por un ejemplo sencillo de una función que devuelve otra
que suma 10:

```swift
func makeSumador10() -> (Int) -> Int {
  func suma10(x: Int) -> Int {return x+10}
  return suma10
}

var f = makeSumador10()
print(f(20))
// Imprime 30
```

- Hay que hacer notar la declaración de la función `makeSumador10`. Es
una función que no recibe argumentos y que devuelve otra función del
tipo `(Int) -> Int`, esto es, una función que recibe un entero y
devuelve otro entero.

----

### Otro ejemplo un poco más complicado

```swift
func eligeFuncionPaso(menorQueCero: Bool) -> (Int) -> Int {
    func pasoAdelante(x: Int) -> Int { return x + 1 }
    func pasoAtras(x: Int) -> Int { return x - 1 }
    return menorQueCero ? pasoAdelante : pasoAtras
}

var valorActual = -4
let acercarseACero = eligeFuncionPaso(menorQueCero: valorActual < 0)
// acercarseACero ahora se refiere a la función anidada pasoAdelante
while valorActual != 0 {
    print("\(valorActual)... ")
    valorActual = acercarseACero(valorActual)
}
print("cero!")
// -4...
// -3...
// -2...
// -1...
// cero!
```

----
### 4. Recursión
----


### Ejemplos de funciones recursivas en Swift

- Recursión pura:

```swift
func suma(hasta x: Int) -> Int {
  if x == 0 {
    return 0
  } else {
    return x + suma(hasta: x - 1)
  }
}

print(suma(hasta: 5))
```

----

### Funciones recursivas sobre Arrays

- Los arrays en Swift no funcionan exactamente como las listas de
Scheme (no son listas de parejas), pero podríamos obtener el primer
elemento y el resto de la siguiente forma.

```swift
let a = [10, 20, 30, 40, 50, 60]
let primero = a.first!
let resto = a.dropFirst()
```

- En `primero` se guarda el número 10. El símbolo `!` sirve para
_desenvolver el opcional_ que devuelve `first` (veremos después este concepto).

- En `resto` se guarda un `ArraySlice` del 20 al 60. Es una vista de un rango de
elementos del array, en este caso el que va desde la posición 1 hasta
la 5 (la posición inicial de un array es la 0).

- Podemos convertir un `ArraySlice` en un `Array`:

```swift
let resto = Array(a.dropFirst())
```

- La función recursiva que suma los valores de un array se puede
  entonces implementar entonces de la siguiente forma:


```swift
func sumaValores(_ valores: [Int]) -> Int {
  if let primero = valores.first {
      let resto = Array(valores.dropFirst())
      return primero + sumaValores(resto)
  } else {
      return 0
  }
}

print(sumaValores([1,2,3,4,5,6,7,8])) // 36
```

- La construcción `if let` comprueba si `valores.first` es distinto de
  `nil`. En ese caso, se guarda el número en la variable `primero`. Lo
  veremos más despacio cuando hablemos de los opcionales.

- Veremos que las colecciones en Swift implementan funciones de orden
  superior como `map`, `filter`, `reduce`, etc.

----
### 5. Tipos
----

### Swift es fuertemente tipeado

- Swift es un lenguaje fuertemente tipeado, a diferencia de
  Scheme. 
- Entre las ventajas del uso de tipos está la detección de errores en
  los programas en tiempo de compilación o las ayudas del entorno de
  desarrollo para autocompletar código. 
- Entre los inconvenientes se encuentra la necesidad de ser más
  estrictos a la hora de definir los parámetros y los valores
  devueltos por las funciones, lo que impide la flexibilidad de
  Scheme.
- Se utilizan tipos para definir los posibles valores de:
    - variables
    - parámetros de funciones
    - valores devueltos por funciones

- Las definiciones de tipos van precedidas de dos puntos en las
  variables y parámetros, o de una flecha (`->`) en la definición de
  los tipos de los valores devueltos por una función:

```swift
let valorDouble : Double = 3.0
let unaCadena: String = "Hola"

func calculaEstadisticas(valores: Array<Int>) -> (min: Int, max: Int, media: Int) {
   ...
}
```

- En Swift existen dos clases de tipos: **tipos con nombre** y **tipos
  compuestos**.


----

### Tipos con nombre

- Un tipo con nombre es un tipo al que se le puede dar un nombre
  determinado cuando se define:
    - nombres de clases
    - nombres de estructuras
    - nombres de enumeraciones
    - nombres de protocolos 


----

#### Tipos compuestos

- Los tipos compuestos son tipos sin nombre. 
- En Swift se definen dos: **tuplas** y **tipos función** (ya los
  hemos visto). 

Ejemplo tuplas:

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

----

### Enumeraciones

- Las enumeraciones definen un tipo con un valor restringido de
  posibles valores:


```swift
enum Direccion {
    case norte
    case sur
    case este
    case oeste
}
```

Ejemplo de uso:

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

----

### Valores brutos de enumeraciones

- Es posible asignar a las constantes del enumerado un valor concreto
  de un tipo subyacente:

```swift
enum CaracterControlASCII: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```

- Se puede devolver el valor bruto de la siguiente forma:

```
let nuevaLinea = CaracterControlASCII.lineFeed.rawValue
```

- También se puede hacer de forma implícita cuando el tipo subyacente
  es `Int`, dando un valor a la primera constante:

```swift
enum Planeta: Int {
    case mercurio=1, venus, tierra, marte, jupiter, saturno, urano, neptuno
}
let posicionTierra = Planeta.tierra.rawValue
// posicionTierra es 3
```

- Por último, se puede definir como tipo subyacente `String` y los
  valores brutos de las constantes serán sus nombres convertidos a
  cadenas:

```swift
enum Direccion: String {
    case norte, sur, este, oeste
}
let direccionAtardecer = Direccion.oeste.rawValue
// direccionAtardecer es "oeste"
```

- Cuando se definen valores brutos es posible inicializar el enumerado
  de una forma similar a una estructura o una clase pasando el valor
  bruto. Devuelve el valor enumerado correspondiente o `nil` (un
  opcional):

```swift
let posiblePlaneta = Planeta(rawValue: 7)
// posiblePlaneta es de tipo Planeta? y es igual a Planeta.urano
```

----

### Valores asociados a instancias de enumeraciones

- En otros lenguajes de programación se llaman _uniones etiquetadas_ o
  _variantes_. Permiten asociar valores de otro tipo a las opciones
  del enumerado.
- Una instancia de un **caso de enumeración** (_enum case_) puede
  tener valores asociados con la instancia. Instancias del mismo caso
  de enumeración pueden tener asociados valores diferentes. 
- Se proporciona el valor asociado cuando se crea la instancia. 

Ejemplo:

```swift
enum CodigoBarras {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

Creación de las instancias:

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

----

### Enumeraciones recursivas

- Es posible combinar las características de las enumeraciones con
valor con la recursión para crear enumeraciones recursivas. Hay que
preceder la palabra clave `enum` con `indirect`:

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

- Es muy cómodo manejar enumeraciones recursivas de forma recursiva:

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

- Otro ejemplo de enums recursivos, para definir un tipo de datos
`Lista` basado en parejas (similar a Scheme):


```swift
indirect enum Lista{
 case vacia
 case cons(Int, Lista)
}

func suma(lista: Lista) -> Int {
   switch lista {
   case  .vacia:
     return 0
   case let .cons(car, cdr):
     return car + suma(lista: cdr)
   }
}

let z: Lista = .cons(20, .cons(10, .vacia))

print(suma(lista: z))
// Imprime 30
```

- Podemos definir también una función recursiva `make(lista:[Int])`
que devuelve una lista a partir de una array de enteros:

```
func make(lista: [Int]) -> Lista {
    if let primero = lista.first {
        let resto = Array(lista.dropFirst())
        return Lista.cons(primero, make(lista: resto))
    } else {
        return Lista.vacia
    }
}

let lista = make(lista: [1,2,3,4,5])

print(suma(lista: lista))
// Imprime 15
```

----

### Typealias

- En Swift se define la palabra clave `typealias` para darle un nombre
  asignado a cualquier otro tipo. Ambos tipos son iguales a todos los
  efectos (es únicamente azúcar sintáctico).

```swift
typealias Resultado = (Int, Int)

enum Quiniela {
    case uno, equis, dos
}

func quiniela(resultado: Resultado) -> Quiniela {
  switch resultado {
    case let (goles1, goles2) where goles1 < goles2:
      return .dos
    case let (goles1, goles2) where goles1 > goles2:
      return .uno
    default:
      return .equis
  }
}

print(quiniela(resultado: (1,3)))
// Imprime Dos
print(quiniela(resultado: (2,2)))
// Imprime Equis
```

----
### 6. Opcionales
----

- En Swift el valor nulo se representa con `nil` (equivalente a `null`
  en Java). 
- No podemos asignar `nil` a una variable de un tipo dado:

```swift
// La siguiente línea daría un error en tiempo de compilación
// let cadena: String = nil
```

- Los tipos opcionales de Swift permiten asignar a variables o bien un
  valor propio del tipo o bien `nil`
- Podemos definir como opcional variables, parámetros o valores
  devueltos por funciones.
- Ejemplo: inicializador del tipo `Int` de Swift. Debido a que el
  inicializador puede fallar, devuelve un `Int` _opcional_, en lugar
  de un `Int`. Un `Int` opcional se escribe como `Int?`.

```swift
var posibleNumero = "123"
let numeroConvertido = Int(posibleNumero)
posibleNumero = "Hola mundo"
let conversionErronea = Int(posibleNumero)
// numeroConvertido y conversionErronea son de tipo "Int?", o "Int opcional"
// El primero contiene un número y el segundo nil
```
- Para definir una variable como sin valor debemos asignarle el valor
especial `nil`:

```swift
var codigoRespuestaServidor: Int? = 404
// codigoRespuestaServidor contine un valor Int de 404
codigoRespuestaServidor = nil
// codigoRespuestaServidor ahora no contiene ningún valor
```

- Una variable opcional sin asignar ningún valor se inicializa
  automáticamente a `nil`:

```swift
var respuestaEncuesta: String?
// respuestaEncuesta es inicializado automáticamente a nil
```

----

### Sentencias `if` y _desenvoltura forzosa_

- No se puede usar un opcional en expresiones en las que se espera un
  tipo básico.
- Se puede usar un `if` para comprobar si un valor opcional es
  distinto de `nil`:

```swift
if numeroConvertido != nil {
    print("numeroConvertido contiene algún valor entero.")
}
// Imprime "numeroConvertido contiene algún valor entero."
```

- Si estamos seguros de que el opcional contiene un valor, podemos
  acceder a él usando un signo de exclamación (`!`). Esto se conoce
  como _desenvoltura forzosa_ (_forced unwrapping_) del valor
  opcional:

```swift
if numeroConvertido != nil {
    let numero = numeroConvertido!
    print("numeroConvertido tiene un valor entero de \(numero).")
}
// Imprime "numeroConvertido tiene un valor entero de 123."
```

- Si se desenvuelve un opcional que contiene un `nil` se causa un error
en tiempo de ejecución:

```swift
let x = Int("Hola")
let y = x! + 100
// La sentencia anterior provoca un error en tiempo de ejecución
```

----

### Ligado opcional

- Es posible comprobar si un opcional tiene valor y asignar su valor a
  otra variable al mismo tiempo con una construcción llamada _ligado
  opcional_ (_optional binding_):

```swift
if let numeroVerdadero = Int(posibleNumero) {
    print("\"\(posibleNumero)\" tiene un valor entero de \(numeroVerdadero)")
} else {
    print("\"\(posibleNumero)\" no ha podido convertirse en un entero")
}
// Imprime ""123" tiene un valor entero de 123"
```

----

### Ejemplo de `minMax` con opcional

- Como ejemplo de uso de opcionales adaptamos el ejemplo anterior de la
función `minMax` para que pueda recibir un array vacío, en cuyo caso
devolverá `nil`.


```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var minActual = array[0]
    var maxActual = array[0]
    for valor in array[1..<array.count] {
        if valor < minActual {
            minActual = valor
        } else if valor > maxActual {
            maxActual = valor
        }
    }
    return (minActual, maxActual)
}
```

- Tendremos entonces que llamar a la función comprobando si el valor
  devuelto es distinto de `nil`:

```swift
if let limites = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min es \(limites.min) y max es \(limites.max)")
}
// Imprime "min es -6 y max es 109"
```

- En el caso anterior sabemos que `limites` va a devolver un valor
(porque llamamos a `minMax` con un array con elementos), por lo que
podemos desenvolverlo sin temor de provocar un error. 
- Sin embargo, en el ejemplo siguiente no es recomendable hacer una
desenvoltura forzosa, porque no sabemos si `minMax` va a devolver
`nil` o no. Hacemos un ligado opcional :

```swift
let valores = pedirNums() // La función pedirNums() pide una lista de 
                          // números por la entrada estándar y
                          // devuelve un [Int] (que puede estar vacío)
if let limites = minMax(valores) {
    print("min es \(limites.min) y max es \(limites.max)")
} else {
    print("No hay números")
}
```

----

### Ejemplo de `Lista` con opcional

Otra versión del enum `Lista` usando esta vez un opcional:

```swift
indirect enum Lista{
	case cons(Int, Lista?)
}

func suma(lista: Lista) -> Int {
	switch lista {
		case let .cons(car, cdr):
		if (cdr == nil) {
			return car
		} else {
			return car + suma(lista: cdr!)
		}
	}
}

let z: Lista = .cons(20, .cons(10, nil))
print(suma(lista: z))
```



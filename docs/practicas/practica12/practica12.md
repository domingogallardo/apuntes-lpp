# Práctica 12: Programación Orientada a Objetos en Swift (2)

## Antes de la clase de prácticas

Los siguientes ejercicios están basados en los conceptos de teoría
vistos la semana pasada. Antes de la clase de prácticas debes repasar
todos los conceptos y **probar en con el compilador de Swift** todos
los ejemplos de los siguientes apartados del tema 6 [_Programación
OO con Swift_](../../teoria/tema06-programacion-orientada-objetos-swift/tema06-programacion-orientada-objetos-swift.md#7-funciones-operadoras)

- Funciones operadoras
- Protocolos
- Casting de tipos
- Genéricos
- Extensiones


## Ejercicios

### Ejercicio 1 ###

a) Completa el código de la estructura ​`MiStruct`​ para que compile
correctamente. Hazlo primero en papel y después pruébalo en el
compilador.

```swift
protocol A {
    var a: String {get}
    func foo(a: String) -> String?
}
protocol B {
    mutating func bar()
}
struct MiStruct: A, B {
    // Completa el código
}
```

b) El siguiente código tiene errores. Intenta descubrir cuáles son sin
utilizar el compilador. Prueba distintas formas de arreglar el código
cambiando lo mínimo posible de lo ya definido (por ejemplo, no debes
añadir nuevas propiedades en `MiStruct`). Compruébalo con el compilador.

```swift
protocol A {
    var a: String {get set}
    func foo(a: Int, b: Int) -> Int?
}

protocol B {
    mutating func bar()
}

struct MiStruct: A, B {
    let a = 10
    func foo(valor1 a: Int, valor2 b: Int) -> Int {
        let res = a > 10 ? a: b
        return res
    }
}
```

c) Supongamos la estructura `Equipo` que aparece a continuación que
representa un equipo en una competición deportiva: 

```swift
struct Equipo {
    let puntos: Int
    let nombre: String
}
```

Modifica la definición para poder comprobar la igualdad de dos equipos y
que el siguiente código funcione correctamente:

```swift
let equipo1 = Equipo(puntos: 10, nombre: "Hércules")
let equipo2 = Equipo(puntos: 8, nombre: "Villareal")
print(equipo1 == equipo2) // imprime false
```

Después, modifica el código otra vez para que la estructura se ajuste
también al protocolo `Comparable` para poder comparar dos equipos
. Consulta el protocolo en [documentación de
Swift](https://developer.apple.com/documentation/swift/comparable). Un
equipo será menor que otro cuando tenga menos puntos. En el caso en
que ambos tengan los mismos puntos, será menor el que tenga menor
nombre en orden alfabético.

```swift
print(equipo1 > equipo2) // imprime true
```

Una vez definidos los operadores necesarios comprueba que funcionan
correctamente creando varios equipos, insertándolos en un array y
llamando al método `sorted`.

### Ejercicio 2 ###

a) Completa el siguiente código para que compile correctamente e imprima lo indicado:

```swift
struct Cuadrado {
    var lado: Double
}

// Completa el código justo a continuación,
// no puedes modificar el código anterior

var cuadrado = Cuadrado(lado: 4.0)
print(cuadrado.area) // Imprime: 16.0
cuadrado.lado = 10.0
print(cuadrado.area) // Imprime: 100.0

```

b) Rellena el siguiente código para que funcione correctamente:

```swift
protocol Persona {
    var nombre: String {get}
    func encantada() -> Persona 
    func refrescada() -> Persona 
}

enum Pocion {
    case magica, refrescante, venenosa

    func esBebida(por persona: Persona) -> __________ {
        ______________ {
            case _________:
                return persona.encantada()
            case _________:
                return persona.refrescada()
            default:
                return nil
        }
    }
}
```

c) Completa el código de la estructura ​`MiStruct` para que compile correctamente:

```swift
protocol A {
    var valor: Int {get set}
    func foo(a: Int) -> Int
}
protocol B {
    mutating func bar()
}
struct MiStruct: A, B {
    // Completa el código

}
```

d) Completa el siguiente código para que compile correctamente e imprima lo indicado:

```swift
struct Circulo {
    var radio: Double
    // Completa el código

}

let c1 = Circulo(radio: 5.0)
let c2 = Circulo(radio: 10.0)
let c3 = c1 + c2
print("El radio de la suma es: \(c3.radio)")
// Imprime: El radio de la suma es: 15.0
```


### Ejercicio 3 ##


a) Completa el bucle con el código que comprueba el tipo de la variable
`i` e imprime su propiedad `p` y su propiedad `a1` o `a2`, dependiendo
de su tipo.

```swift
protocol P {
   var p: Int { get }
}
class A1: P {
   var p = 0
   var a1 = 0
}
class A2: P {
   var p = 1
   var a2 = 0
}

var array: [P] = [A1(), A2()]
for i in array {

   // Código a completar
   //
}

// debe imprimir:
// debe imprimir:
// p: 0, a1: 0
// p: 1, a2: 0
```

b) Completa el código que hay a continuación para que compile
correctamente y aparezca en pantalla el resultado que se muestra.

```swift

protocol TieneVelocidad {
    func velocidadActual () -> Double
}

class Vehiculo {
    var velocidad = 0.0
    func velocidadActual() -> Double {
        return velocidad
    }
}

class Tren {
    static let velocidadEnMarcha = 300.0
    var pasajeros = 0
    var enMarcha = false
}

//
// Código a completar
//

var vehiculo1 = Vehiculo()
var tren1 = Tren()
tren1.enMarcha = true

let transportes: [TieneVelocidad] = [vehiculo1, tren1]

for i in transportes {
    print(i.velocidadActual())
}
// 0.0
// 300.0
```

### Ejercicio 4 ###

Define una estructura `Timer` con la que podamos ejecutar el siguiente
código sin errores. El temporizador se inicializa con un número
determinado de segundos y define un método de instancia `paso()` que
descuenta un segundo. Fíjate en el código y verás que es posible sumar
temporizadores. Por último, el atributo del tipo `pasosTotales` guarda
el número de pasos que se han realizado en todas las instancias.

```swift
var t1 = Timer(segundos: 10)
var t2 = Timer(segundos: 5)
for _ in 0...4 {
    t1.paso()
}
for _ in 0...2 {
    t2.paso()
}
var t3 = t1 + t2
t3.paso()
print("Segundos del temporizador 1: \(t1.segundos)")
print("Segundos del temporizador 2: \(t2.segundos)")
print("Segundos del temporizador 3: \(t3.segundos)")
print("Pasos totales: \(Timer.pasosTotales)")
// Imprime:
// Segundos del temporizador 1: 5
// Segundos del temporizador 2: 2
// Segundos del temporizador 3: 6
// Pasos totales: 9
```

### Ejercicio 5

Vamos, por último, con un ejercicio en el que veremos otra forma de
trabajar con figuras geométricas.

#### 1. Completa el código inicial ####

Comienza incluyendo en la práctica el código de las definiciones
de las estructuras geométricas: `Punto`, `Tamaño`, `Rectangulo` y
`Circulo`. Debes completar el código para que haga lo indicado en los
comentarios.

```swift
struct Punto {
    var x = 0.0, y = 0.0
}

struct Tamaño {
    var ancho = 0.0, alto = 0.0
}

struct Circulo {
    var centro = Punto()
    var radio = 0.0
    
    var area: Double {
        // Propiedad calculada que devuelve el 
        // área del círculo y modifica el radio
        // cuando se actualiza
    }
}

struct Rectangulo {
    var origen = Punto()
    var tamaño = Tamaño()

    var centro: Punto {
        // Propiedad calculada que devuelve el 
        // centro del rectángulo y traslada su
        // origen cuando se modifica
    }

    var area: Double {
        // Propiedad calculada que devuelve el
        // área del rectángulo
    }
}
```

Prueba las estructuras escribiendo algún código en el que se creen algunas
instancias y se actualicen sus propiedades.

#### 2. Define el protocolo figura

Define el protocolo `Figura` que contiene:

- Propiedad de lectura y escritura `centro` (`Punto`), que define el
  centro de la figura.
- Propiedades de sólo lectura `area` (`Double`) y `tamaño` (`Tamaño`)
  que devuelven el tamaño (alto y ancho) de la figura.
- Método `descripcion()` que devuelva un `String` con el centro y el
  área de la figura.

#### 3. Define extensiones

- Modifica las estructuras `Rectangulo` y `Circulo` para que se ajusten al
  protocolo `Figura`, añadiendo el código de implementación necesario.

- Prueba el código escrito hasta ahora, creando un array del tipo
  `Figura` (el protocolo) y añadiendo en él círculos y rectángulos.

#### 4. Estructura `AlmacenFiguras`

Por último, implementa una estructura `AlmacenFiguras`.

- Debe tener una única propiedad `figuras` que contenga un array de
figuras. Como en la práctica anterior, define en ella el método
`añade(figura:)` y las propiedades calculadas `numFiguras` (`Int`) y
`areaTotal` (`Double`).

- Escribe el método `cuentaTipos() -> (Int, Int)` que recorra el array
de figuras y devuelva una tupla con dos enteros: número de rectángulos
y número de círculos. La función debe imprimir por cada figura del
array el tipo de figura, su descripción y, en el caso en que la figura sea un rectángulo,
su tamaño.

Por ejemplo:

```
** Un rectángulo con tamaño Tamaño(ancho: 10.0, alto: 5.0) y descripción:
Centro: Punto(x: 8.0, y: 6.5) y área: 50.0
** Un círculo con descripción:
Centro: Punto(x: 5.0, y: 0.0) y área: 314.1592653589793
```

- Escribe un ejemplo de código en el que se guarden varias figuras
en un almacén de figuras y se llame a sus métodos.

----

Lenguajes y Paradigmas de Programación, curso 2024-25  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez


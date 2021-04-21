
# Práctica 11: Programación Orientada a Objetos en Swift (2)

## Entrega de la práctica

Para entregar la práctica debes subir a Moodle el fichero
`practica11.swift` con una cabecera inicial con tu nombre y apellidos,
y las soluciones de cada ejercicio separadas por comentarios.

## Ejercicios

### Ejercicio 1 ###

a) Escribe un ejemplo de código en el que definas una relación de
herencia entre una clase base y una clase derivada. Comprueba en el
código que un objeto de la clase derivada hereda las propiedades y
métodos de la clase base.

Investiga sobre el funcionamiento de la herencia en Swift. Escribe
ejemplos en donde compruebes este funcionamiento. Algunos ejemplos de
preguntas que puedes investigar (puedes añadir tú más preguntas):

- ¿Se puede sobreescribir el valor de una propiedad almacenada? ¿Y
calculada? 
- ¿Se puede añadir un observador a una propiedad de la clase base en
  una clase derivada?
- ¿Hereda la clase derivada propiedades y métodos estáticos de la clase base?
- ¿Cómo se puede llamar a la implementación de un método de la clase
  base en una sobreescritura de ese mismo método en la clase derivada?


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

c) Repasa el protocolo `GeneradorNumerosAleatorios` visto en
teoría. Define otra implementación del protocol llamada
`GeneradorFake` en la que siempre se devuelva el número `0.1`. Cambia
el ejemplo del dado para que utilice este generador y comprueba que
siempre devuelve el número 1.

c) Supongamos la estructura `Equipo` que aparece a continuación que
representa un equipo en una competición deportiva: 

```swift
struct Equipo {
    let puntos: Int
    let nombre: String
}
```

Debes hacer que la estructura se ajuste al protocolo `Comparable` para
poder comparar dos equipos . Consulta el protocolo en [documentación
de
Swift](https://developer.apple.com/documentation/swift/comparable). Un
equipo será menor que otro cuando tenga menos puntos. En el caso en
que ambos tengan los mismos puntos, será menor el que tenga menor
nombre en orden alfabético.

Una vez definidos los operadores necesarios comprueba que funcionan
correctamente creando varios equipos, insertándolos en un array y
llamando al método `sorted`.


### Ejercicio 2

En este ejercicio deberás implementar un conjunto de clases con las
que podamos "simular" una carrera de coches.

#### Función `random`

Utilizaremos la función del sistema `random()` que devuelve un número
aleatorio. Hay que importar la librería `Glibc` (en Linux) y
`Foundation` (en iOS) para usarla.

A continuación puedes ver un ejemplo de su utilización en un método de
tipo del enumerado `MarcaCoche` para devolver una marca aleatoria de
coche:


```swift
import Glibc

func rand(n: Int) -> Int {
    return random() % n
}

enum MarcaCoche: Int {
    case Mercedes=0, Ferrari, RedBull, McLaren
    
    static func random() -> MarcaCoche {
        let maxValue = McLaren.rawValue
        
        let r = rand(maxValue+1)
        return MarcaCoche(rawValue: r)!
    }

}
```

#### Enumerados y clases que gestionan los vehículos

Deberás implementar los siguientes enumerados y clases, con las propiedades indicadas.

**Enumerado `MarcaCoche`** 

- Posibles valores: `Mercedes`, `Ferrari`, `RedBull` y `McLaren`
- Método del tipo `random()` que devuelva aleatoriamente uno de los
  valores (consultar el código anterior).

**Enumerado `TipoCambio`**

- Posibles valores: `Automatico` o `Manual`
- Método del tipo `random()` que devuelve uno de esos valores.

**Clase base `Coche`**

- Propiedades de instancia almacenadas: `velocidadActual` (`Double`),
  `marcha` (`Int`), `distanciaRecorrida` (`Double`) y `marca`
  (`MarcaCoche`).
- Propiedad de instancia calculada: `descripcion` (`String`), que
  devuelve la marca del coche.
- Propiedades del tipo: Constantes `velocidadMaxima` (`Double`) y
  `marchaMaxima` (`Int`) inicializadas a 150.0 y 6

**Subclase `CocheAutomatico`**

- Hereda de `Coche` y sobreescribe la descripción, añadiendo la cadena
  "Automático".

**Subclase `CocheManual`**

- Hereda de `Coche` y sobreescribe la descripción, añadiendo la cadena
  "Manual".

**Observadores de propiedades en las subclases**

La velocidad de un coche manual se modifica cambiando su propiedad
`marcha` y la de un coche automático cambiando su propiedad
`velocidadActual`. En cada caso hay que definir observadores de
propiedades que modifiquen la otra propiedad.

La velocidad se calcula a partir de la marcha según la siguiente expresión:

```swift
velocidadActual = 25.0 * marcha
```

Y la marcha se calcula a partir de la velocidad con la expresión que
puedes encontrar en los apuntes de teoría, en la definición de la
clase `CocheAutomatico`.


**Distancia recorrida e información en pantalla**

Suponemos que se cambia la velocidad del coche cada hora y que en cada
cambio de velocidad se actualiza la propiedad `distanciaRecorrida`,
que irá acumulando la distancia recorrida por el coche desde su
inicialización. Cada vez que se cambia la velocidad también se
imprimirá la velocidad actual y la marca del coche en pantalla (ver el
ejemplo al final del ejercicio). Esto se puede implementar también en
los observadores.

#### Clase Carrera

Debes implementar las clases anteriores y una clase `Carrera` con la
que simular una carrera de `n` coches que conducen durante `k` horas.

Un ejemplo de uso de la clase `Carrera`:

```swift
let carrera = Carrera(numCoches: 2, horas: 3)
print("\nDescripción de la carrera:")
carrera.descripcion()
print("\n!!! Comienza la carrera !!!")
carrera.empezar()
print("\n!!! Clasificación !!!")
carrera.clasificacion()
```

Y su correspondiente salida por pantalla:

```text
Descripción de la carrera:
2 coches con una duración de 3 horas
 McLaren Automatico
 Mercedes Manual

!!! Comienza la carrera !!!

Horas transcurridas 1
McLaren Automatico viajando a 141.0 kilómetros por hora con la marcha 6
Mercedes Manual viajando a 25.0 kilómetros por hora con la marcha 1

Horas transcurridas 2
McLaren Automatico viajando a 114.0 kilómetros por hora con la marcha 5
Mercedes Manual viajando a 25.0 kilómetros por hora con la marcha 1

Horas transcurridas 3
McLaren Automatico viajando a 105.0 kilómetros por hora con la marcha 5
Mercedes Manual viajando a 100.0 kilómetros por hora con la marcha 4

!!! Clasificación !!!
1. McLaren Automatico (360.0 kilómetros recorridos)
2. Mercedes Manual (150.0 kilómetros recorridos)
```



### Ejercicio 3 ##


a) Completa el bucle con el código que comprueba el tipo de la variable
`i` e imprime su propiedad `x` y su propiedad `b` o `c`, dependiendo
de su tipo.

```swift
protocol X {
   var x: Int { get }
}
class Xb: A {
   var x = 0
   var b = 0
}
class Xc: A {
   var x = 1
   var c = 0
}

var array: [X] = [Xb(), Xc()]
for i in array {
   //
   // Código a completar
   //
}

// debe imprimir:
// x: 0, b: 0
// x: 1, c: 0
```

b) Completa el código que hay a continuación para que compile
correctamente y aparezca en pantalla el resultado que se muestra.

Resultado:

```swift
0.0
300.0
```

Código:

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
```

c) Define una extensión del enum `Arbol` del ejercicio 2 de la
práctica 9 en la que se implemente el método `min` que devuelva el
menor elemento del árbol. En la extensión debes especificar que el
tipo de los elementos del árbol deben cumplir el protocolo
`Comparable`, para poder realizar la comparación y obtener el mínimo.

Haz una prueba con un árbol de equipos, objetos de la estructura `Equipo`
definida en el apartado anterior.


### Ejercicio 4

Continuamos con el ejercicio de las figuras geométricas de la
práctica anterior.

Comienza incluyendo en la práctica el código de todas las definiciones
de las estructuras y clases geométricas: `Punto`, `Tamaño`,
`Rectangulo` y `Circulo`.

Una vez incluido debes realizar lo siguiente.


#### Protocolo figura

Define el protocolo `Figura` que contiene:

- Propiedad de lectura y escritura `centro` (`Punto`), que define el
  centro de la figura.
- Propiedades de sólo lectura `area` (`Double`) y `tamaño` (`Tamaño`)
  que devuelven el tamaño (alto y ancho) de la figura.


#### Extensiones

- Define las extensiones necesarias para que las clases `Rectangulo`,
y `Circulo` se ajusten al protocolo `Figura`, añadiendo el
código de implementación necesario.

- Añade mediante una extensión al protocolo `Figura` la propiedad
  calculada `descripcion` que devuelva un `String` con el centro y el
  área de la figura.

#### Clase `AlmacenFiguras`

- Reescribe la clase `AlmacenFiguras` y define en ella **una única
propiedad** `figuras` que contenga todas las figuras que se vayan
creando. Reescribe también la implementación de `areaTotal`. Modifica
los inicializadores en las clases geométricas para que se incluya la
figura recién creada en esta propiedad.

- Escribe el método de clase `cuentaTipos() -> (Int, Int)`
que recorra el array de figuras y devuelva una tupla con dos enteros:
número de rectángulos y número de círculos. La
función debe imprimir por cada figura del array, su descripción
por defecto proporcionada por el protocolo y el tipo de figura y sus
características específicas.

Por ejemplo:

```
- Descripción de la figura: Una figura con centro Punto(x: 7.0, y: 3.5) y área 50.0
  Rectangulo con origen Punto(x: 2.0, y: 1.0) y tamaño Tamaño(ancho: 10.0, alto: 5.0)
- Descripción de la figura: Una figura con centro Punto(x: 0.0, y: 2.0) y área 78.5398163397448
  Circulo con centro Punto(x: 0.0, y: 2.0) y radio 5.0
```



----

Lenguajes y Paradigmas de Programación, curso 2020-21  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez


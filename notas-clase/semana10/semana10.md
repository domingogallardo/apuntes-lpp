
## Tema 7: Programación Orientada a Objetos con Swift

### Contenidos

- **1. Introducción, historia y características**
- **2. Clases y estructuras**
- **3. Propiedades**
- **4. Métodos**
- **5. Inicialización**
- **6. Herencia**
- 7. Protocolos
- 8. Casting de tipos
- 9. Extensiones
- 10. Funciones operador
- 11. Genericos


----

### Bibliografía

- Swift Language Guide
    - [Classes and Structures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82)
    - [Properties](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID254)
    - [Methods](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-ID234)
    - [Inheritance](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID193=)
    - [Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

---
### 1. Introducción, historia y características de la Programación Orientada a Objetos
---

- Debéis estudiar la historia y las características generales de la
  POO que se explica en los apuntes.
- Suponemos conocidos los conceptos básicos de POO (por ejemplo, en
  Java): clase, objeto o instancia, atributos, método, herencia,
  interfaz, etc.

---
### POO en Swift
---

- Vamos a detallar a continuación las **características de Programación
Orientada a Objetos de Swift**. 
- Para una introducción rápida leer los últimos apartados del [seminario de
Swift](https://github.com/domingogallardo/apuntes-lpp/blob/master/seminarios/seminario2-swift/seminario2-swift.md)
(los apartados **Objetos, clases y estructuras**, **Protocolos y
extensiones** y **Genéricos**).

---
### 2. Clases y estructuras en Swift
---

- Clases y estructuras son los elementos de Swift con los que se
  implementan las características de POO
- En Swift se suele hablar de _instancias_ (un término más general) en
  lugar de _objetos_. Una instancia es un valor concreto de una clase
  o una estructura.

Las clases y las estructuras en Swift tienen muchas **cosas en
común**. Ambos pueden:

- Definir **propiedades** y almacenar valores.
- Definir **métodos** para proporcionar funcionalidad.
- Definir inicializadores para configurar el estado inicial.
- Ser extendidas para expandir su funcionalidad más allá de una
  implementación por defecto.
- Ajustarse a un protocolo.

Las clases tienen **características adicionales** que no tienen las
estructuras:

- Mediante la **herencia** una clase puede heredar las características de
  otra
- El casting de tipos permite comprobar e interpretar el tipo de una
  instancia de una clase en tiempo de ejecución.
- Se permite que exista más de una referencia a una instancia de una clase.

---

### Sintaxis

```swift
class UnaClase {
    // definición de clase
}
struct UnaEstructura {
    // definición de una estructura
}
```

---

### Ejemplo

```swift
struct CoordsPantalla {
    var posX = 0
    var posY = 0
}

class Ventana {
    var esquina = CoordsPantalla()
    var altura = 0
    var anchura = 0
    var visible = true
    var etiqueta: String?
}
```

- Las propiedades son constantes o variables que se almacenan en
la instancia de la clase o de la estructura. 

---

### Instancias de clases y estructuras

- Creación de una instancia:

```swift
var unasCoordsPantalla = CoordsPantalla()
var unaVentana = Ventana()
```
- Swift proporciona este **inicializador por defecto** para clases y
estructuras, siempre que no se defina algún inicializador
explícito. 

- En el caso de la instancia `unasCoordsPantalla` los valores a los
que se han inicializado sus propiedades son:

```swift
unasCoordsPantalla.posX // 0
unasCoordsPantalla.posY // 0
```

- Las propiedades de la instancia `unaVentana` son:

```swift
unaVentana.esquina // CoordsPantalla con posX = 0 y posY = 0
unaVentana.altura // 0
unaVentana.anchura // 0
unaVentana.visible // true
unaVentana.etiqueta // nil
```

- Todas las propiedades de una instancia deben estar definidas después
de haberse inicializado, a no ser que la propiedad se un opcional.

---

### Acceso a propiedades

- Se puede acceder y modificar las propiedades usando la _sintaxis de
punto_:

```swift
// Accedemos a la propiedad
unasCoordsPantalla.posX // Devuelve 0
// Actualizamos la propiedad
unasCoordsPantalla.posX = 100
unaVentana.esquina.posY = 100
```

---

### Inicialización de las estructuras por sus propiedades

- Si en las estructuras no se se definen inicializadores explícitos
(veremos más adelante cómo hacerlo) podemos utilizar un
**inicializador _memberwise_** en el que podemos proporcionar valores
de sus propiedades.

- En las clases no existen los inicializadores _memberwise_, sólo en
las estructuras.

```swift
let coords = CoordsPantalla(posX: 200, posY: 400)
```

- Cuando se llama al inicializador _memberwise_ podemos omitir valores
de cualquier propiedad que tenga un valor por defecto, o que sea un
opcional. 

```swift
let coords1 = CoordsPantalla(posX: 200)
print(coords1.posX, coords1.posY)
// Imprime 200 0
```

---

### Estructuras y enumeraciones son tipos valor

- Las instancias de estructuras y enumeraciones se copian cuando se
asignan a una variable o constante, o cuando se pasan a una función.

```swift
var coords1 = CoordsPantalla(posX: 600, posY: 600)
var coords2 = coords1
coords2.posX = 1000
coords1.posX // devuelve 600
```

---

### Las clases son tipos referencia

- Los tipos de referencias no se copian cuando se asignan o se pasan a
funciones, sino que se crean referencias a la misma instancia
existente.

```swift
var ventana1 = Ventana()
ventana1.esquina = coords1
ventana1.altura = 800
ventana1.anchura = 800
ventana1.etiqueta = "Finder"
var ventana2 = ventana1
ventana2.anchura = 1000
ventana1.anchura // devuelve 1000
```

- Debido a que son tipos de referencia, `ventana1` y
`ventan2` se refieren a la misma instancia de
`Ventana`.

- Una constante o variable en Swift que se refiere a una instancia de
un tipo referencia es similar a un puntero en C, pero no es un puntero
que apunta a una dirección de memoria y no requiere que se escriba un
asterisco (*) para indicar que estas creando una referencia. En su
lugar, estas referencias se definen como cualquier otra constante o
variable en Swift.

---

### Declaración de instancias con `let`

- Las estructuras y clases también tienen comportamientos distintos
cuando se declaran las variables con `let`.

- Si definimos con `let` una instancia de una estructura estamos
declarando constante la variable y todas las propiedades de la
instancia. No podremos modificar ninguna:

```swift
let coords3 = CoordsPantalla(posX: 400, posY: 400)
coords3.posX = 800
// error: cannot assign to property: 'coords3' is a 'let' constant
```

- Si definimos con un `let` una instancia de una clase sólo estamos
declarando constante la variable. No podremos reasignarla, pero sí que
podremos modificar las propiedades de la instancia referenciada por la
variable:

```swift
let ventana3 = Ventana()
// Sí que podemos modificar una propiedad de la instancia:
ventana3.etiqueta = "Listado"
// Pero no podemos reasignar la variable:
ventana3 = ventana1
// error: cannot assign to value: 'ventana3' is a 'let' constant
```


---

### Operadores de identidad

- Idéntico a (`===`) 
- No idéntico a (`!==`)

```swift
ventana1 === ventana2 // devuelve true
ventana1 === ventana3 // devuelve false
```

- "Idéntico a" significa que dos constantes o variables de una clase
  se refieren exactamente a la misma instancia de la clase.
- "Igual a" significa que dos instancias se consideran "iguales" o
  "equivalentes" en su valor. Es responsabilidad del diseñador de la
  clase definir la implementación de estos operadores.


---

### Paso como parámetro

- En Swift los parámetros de las funciones son constantes, se definen
usando el operador `let`. Esto hace que sea muy distinto el
comportamiento de un parámetro dependiendo de si es una estructura o
una clase.

- Si la instancia que se pasa como parámetro a una función es una
estructura su contenido no se podrá modificar. Sin embargo, si lo que
se pasa es una instancia de una clase, podremos modificar su
contenido.

- Un ejemplo típico de programación imperativa o procedural, en la que
  se modifica el contenido del parámetro pasado. Podemos hacerlo
  porque `ventana` es una clase.

```swift
func mueve(ventana: Ventana, incX: Int, incY: Int) {
    var nuevaPos = CoordsPantalla()
    nuevaPos.posX = ventana.esquina.posX + incX
    nuevaPos.posY = ventana.esquina.posY + incY
    ventana.esquina = nuevaPos
}

var ventana1 = Ventana()
mueve(ventana: ventana1, incX: 500, incY: 500)
print(ventana1.esquina)
// Imprime: CoordsPantalla(posX: 500, posY: 500)
```

- Sin embargo, si pasamos como parámetro una instancia de una
estructura, ésta será inmutable. El siguiente código genera un error
en el compilador que indica que el parámetro `coordsPantalla` es una
constante y no puede ser modificado:

```swift
// ¡¡CÓDIGO ERRÓNEO!!
func mueve(coordsPantalla: CoordsPantalla, incX: Int, incY: Int) {
    coordsPantalla.posX = coordsPantalla.posX + incX
    coordsPantalla.posY = coordsPantalla.posY + incY
}
// error: cannot assign to property: 'coordsPantalla' is a 'let' constant
```

- Si necesitamos hacer una función con la que se obtenga un valor
modificado de una estructura, podemos usar el enfoque funcional de
crear una nueva estructura y devolverla como resultado:

```swift
func mueve(coordsPantalla: CoordsPantalla, incX: Int, incY: Int) -> CoordsPantalla {
    var nuevaCoord = CoordsPantalla()
    nuevaCoord.posX = coordsPantalla.posX + incX
    nuevaCoord.posY = coordsPantalla.posY + incY
    return nuevaCoord
}

let coord1 = CoordsPantalla()
let coord2 = mueve(coordsPantalla: coord1, incX: 100, incY: 100)
print(coord2)
// Imprime CoordsPantalla(posX: 100, posY: 100)
```

- Usando esta última función podríamos reescribir el código de la
función que mueve una ventana de la siguiente forma:

```swift
func mueve(ventana: Ventana, incX: Int, incY: Int) {
    ventana.esquina = mueve(coordsPantalla: ventana.esquina, 
                            incX: incX, incY: incY)
}
```

!!! Note "Nota"
    Igual que en C, en Swift hay una forma de pasar como referencia una
    estructura. Hay que utilizar el operador `inout` precediendo el
    nombre del parámetro. Puedes encontrar más información en la
        documentación oficial de Swift. Busca el apartado _In-Out
    paremeters_ en la página sobre
    [Funciones](https://docs.swift.org/swift-book/LanguageGuide/Functions.html). 

---

### Criterios para usar estructuras y clases

- En general es preferible utilizar estructuras, por su facilidad de
  manejo y la ausencia de efectos laterales.
- Utilizaremos clases si necesitamos tener instancias compartidas o si
  necesitamos definir relaciones de herencia.

---
### 3. Propiedades
---

- Propiedades almacenadas y calculadas.
    - Las propiedades almacenadas (_stored properties_) almacenan
      valores constantes y variables como parte de una instancia
    - Las popiedades calculadas (_computed properties_) calculan (en
      lugar de almacenar) un valor.
- Las enumeraciones, clases y estructuras pueden contener propiedades:
    - Enumeraciones: pueden contener sólo propiedades calculadas.
    - Clases y estructuras: pueden contener propiedades almacenadas y
      calculadas.
- Propiedades de instancias o del tipo.
- Observadores de propiedades, que monitorizan cambios en los valores
  de una propiedad.
  
---

### Propiedades almacenadas

- Pueden ser variables y constantes:

```swift
struct RangoLongitudFija {
    var primerValor: Int
    let longitud: Int
}
var rangoTresItems = RangoLongitudFija(primerValor: 0, 
                                       longitud: 3)
// el rango representa ahora 0, 1, 2
rangoTresItems.primerValor = 6
// el rango representa ahora 6, 7, 8
```
---

### Propiedades calculadas

- Son propiedades que no almacenan realmente un valor, sino que
  proporcionan un _getter_ y un opcional _setter_ que devuelven y
  modifican otras propiedades y valores de forma indirecta.

```swift
struct Punto {
    var x = 0.0, y = 0.0
}
struct Tamaño {
    var ancho = 0.0, alto = 0.0
}
struct Rectangulo {
    var origen = Punto()
    var tamaño = Tamaño()
    var centro: Punto {
        get {
            let centroX = origen.x + (tamaño.ancho / 2)
            let centroY = origen.y + (tamaño.alto / 2)
            return Punto(x: centroX, y: centroY)
        }
        set(centroNuevo) {
            origen.x = centroNuevo.x - (tamaño.ancho / 2)
            origen.y = centroNuevo.y - (tamaño.alto / 2)
        }
    }
}
var cuadrado = Rectangulo(origen: Punto(x: 0.0, y: 0.0),
                  tamaño: Tamaño(ancho: 10.0, alto: 10.0))
let centroCuadradoInicial = cuadrado.centro
cuadrado.centro = Punto(x: 15.0, y: 15.0)
print("cuadrado.origen está ahora en (\(cuadrado.origen.x), \(cuadrado.origen.y))")
// Imprime "cuadrado.origen está ahora en (10.0, 10.0)"
```

- Cuando se modifica la propiedad calculada `centro` se ejecuta el
código del `set` y se actualizan las propiedades `x` e `y` con valores
calculados a partir del nuevo centro que se pasa como parámetro (`centroNuevo`).

<img src="imagenes/computedProperties.png" width="200px"/>

- Se puede definir una versión acortada del _setter_ usando la variable
por defecto `newValue` que contiene el nuevo valor asignado en el
_setter_:

```swift
struct Rectangulo {
    var origen = Punto()
    var tamaño = Tamaño()
    var centro: Punto {
        get {
            let centroX = origen.x + (tamaño.ancho / 2)
            let centroY = origen.y + (tamaño.alto / 2)
            return Punto(x: centroX, y: centroY)
        }
        set {
            origen.x = newValue.x - (tamaño.ancho / 2)
            origen.y = newValue.y - (tamaño.alto / 2)
        }
    }
}
```
---

### Propiedades solo-lectura

- Una propiedad calculada con un _getter_ y sin _setter_ se conoce como
una propiedad calculada de solo-lectura. 
- Es posible simplificar la declaración de una propiedad calculada de
solo-lectura eliminando la palabra clave `get` y sus llaves:

```swift
struct Cuboide {
    var ancho = 0.0, alto = 0.0, profundo = 0.0
    var volumen: Double {
        return ancho * alto * profundo
    }
}
let cuatroPorCincoPorDos = Cuboide(ancho: 4.0, alto: 5.0, 
                                   profundo: 2.0)
print("el volumen de cuatroPorCincoPorDos es \(cuatroPorCincoPorDos.volumen)")
// Imprime "el volumen de cuatroPorCincoPorDos es 40.0"
```

---

### Observadores de propiedades

- Los observadores de propiedades (_property observers_) observan y
responden a cambios en el valor de una propiedad. 
- Se llaman cada vez que el valor de una propiedad es actualizado,
incluso si el nuevo valor es el mismo que el valor actual de la
propiedad.

Observadores:

- `willSet` es llamado justo antes de que el nuevo valor se almacena
  en la propiedad.
- `didSet` es llamado inmediatamente después de que el nuevo valor es
  almacenado en la propiedad.


```swift
class ContadorPasos {
    var totalPasos: Int = 0 {
        willSet(nuevoTotalPasos) {
            print("Voy a actualizar totalPasos a \(nuevoTotalPasos)")
        }
        didSet {
            if totalPasos > oldValue  {
                print("Añadidos \(totalPasos - oldValue) pasos")
            }
        }
    }
}
let contadorPasos = ContadorPasos()
contadorPasos.totalPasos = 200
// Imprime: "Voy a actualizar totalPasos a 200"
// Imprime: "Añadidos 200 pasos"
contadorPasos.totalPasos = 360
// Imprime: "Voy a actualizar totalPasos a 360"
// Imprime: "Añadidos 160 pasos"
contadorPasos.totalPasos = 896
// Imprime: "Voy a actualizar totalPasos a 896"
// Imprime: "Añadidos 536 pasos"
```

- Podemos incluso utilizar el observador `didSet` para evitar que queden
en las propiedades valores no deseados. Por ejemplo, podríamos evitar
que se asignen valores negativos al total de pasos:


```swift
class ContadorPasos {
    var totalPasos: Int = 0 {
        willSet(nuevoTotalPasos) {
            print("Voy a actualizar totalPasos a \(nuevoTotalPasos)")
        }
        didSet {
            if totalPasos < 0 {
                totalPasos = oldValue
            }
            if totalPasos > oldValue  {
                print("Añadidos \(totalPasos - oldValue) pasos")
            }
        }
    }
}
let contadorPasos = ContadorPasos()
contadorPasos.totalPasos = 200
// Imprime: "Voy a actualizar totalPasos a 200"
// Imprime: "Añadidos 200 pasos"
contadorPasos.totalPasos = -10
// Imprime: "Voy a actualizar totalPasos a -10"
contadorPasos.totalPasos // devuelve 200
```

- Hay que hacer notar que al hacer la asignación `totalPasos =
  oldValue` dentro del `didSet` no se vuelve a lanzar el `willSet`.

---

### Variables locales y globales

- Las capacidades anteriores de propiedades calculadas y de observadores
también están disponibles para variables globales y locales.


```swift
var x = 10  {
   didSet {
      print("El nuevo valor: \(x) y el valor antiguo: \(oldValue)")
   }
}
var y = 2 * x
var z : Int {
   get {
      return x + y
   }
   set {
      x = newValue / 2
      y = newValue / 2
   }
}

print(z)
z = 100
print(x)
```

---

### Propiedades del tipo

- Las propiedades de las instancias son propiedades que pertenecen a
  una instancia de un tipo particular.
- Podemos definir también propiedades que pertenecen al tipo
  propiamente dicho, no a ninguna de las instancias de ese tipo.
- Sólo habrá una copia de estas propiedades, sea cual sea el número de
  instancias de ese tipo que creemos.
- Estos tipos de propiedades se llaman propiedades del tipo (_type
  propierties_).
- Se pueden definir en tanto en estructuras, clases como en
  enumeraciones.
- Se definen con la palabra clave `static`. 
- Las propiedades del tipo pueden ser también constantes (`let`) o
  variables (`var`).

```swift
struct UnaEstructura {
    static var almacenada = "A"
    static var calculada : Int {
        return 1
    }
}
enum UnaEnumeracion {
    static var almacenada = "A"
    static var calculada: Int {
        return 1
    }
}
class UnaClase {
    static var almacenada = "A"
    static var calculada: Int {
        return 1
    }
}
```

- Las propiedades del tipo se consultan y actualizan usando también la
sintaxis de punto, pero sobre _el tipo_, no sobre una instancia:

```swift
UnaEstructura.almacenada // devuelve "A"
UnaEstructura.almacenada = "B" 
UnaClase.calculada // devuelve 1
```

- No es posible acceder a la variable del tipo a través de una instancia:

```swift
let a = UnaEstructura()
a.almacenada // error
```

- Otro ejemplo:

```swift
struct Valor {
   var valor: Int = 0 {
      didSet {
         Valor.sumaValores += valor
      }
   }
   static var sumaValores = 0
}

var c1 = Valor()
var c2 = Valor()
var c3 = Valor()
c1.valor = 10
c2.valor = 20
c3.valor = 30
print("Suma de los cambios de valores: \(Valor.sumaValores)")
// Imprime 60
```

---
### Métodos
---

- Los _métodos_ son funciones que están asociadas a un tipo
  particular.
- Las clases, estructuras y enumeraciones pueden definir todas ellas
  métodos de instancia.
- También es posible definir métodos del tipo, asociados al propio
  tipo, no a una instancia concreta.

--- 

### Métodos de instancia

- Los métodos de instancia son funciones que pertenecen a instancias de
  una clase, estructura o enumeración. 
  
Un ejemplo de definición:

```swift
class Contador {
    var veces = 0
    func incrementa() {
        veces += 1
    }
    func incrementa(en cantidad: Int) {
        veces += cantidad
    }
    func reset() {
        veces = 0
    }
}
```

Y un ejemplo de uso:

```swift
let contador = Contador()
// el valor inicial del contador es 0
contador.incrementa()
// el valor del contador es ahora 1
contador.incrementa(en: 5)
// el valor del contador es ahora 6
contador.reset()
// el valor del contador es ahora 0
```

---

### Nombres locales y externos de parámetros

- El funcionamiento de los nombres locales y externos de los
  parámetros es igual en los métodos que en las funciones.
- Los nombres de los métodos en Swift se refieren normalmente al primer
  parámetro usando una preposición como `con`, `en`, `a` o `por`, como
  hemos visto en el ejemplo anterior `incrementa(en:)`. 
- El uso de la preposición permite que el método se lea como una
  frase.

Un ejemplo con nombre externo e interno:

```swift
class Contador {
    var veces = 0
    func incrementa(en cantidad: Int, numeroDeVeces: Int) {
        veces += cantidad * numeroDeVeces
    }
}
```

Se debe llamar al método de la siguiente forma:

```swift
let contador = Contador()
contador.incrementa(en: 5, numeroDeVeces: 3)
// el valor del contador es ahora 15
```

- Al igual que en las funciones, podemos definir explícitamente los
  nombres externos de los parámetros y usar el subrayado (`_`) para
  indicar que ese parámetro no tendrá nombre externo.

---

### La propiedad `self`

- Toda instancia de un tipo tiene una propiedad implícita llamada
  `self`, que es exactamente equivalente a la instancia misma. 
- Podemos usar la propiedad `self` para referirnos a la instancia actual
  dentro de sus propios métodos de instancia.

Ejemplo:

```swift
class Contador {
    var veces = 0
    func incrementa() {
        self.veces += 1
    }
}
```

- Es obligado usarlo cuando el nombre de la propiedad coincide con el
  nombre de un parámetro:

```swift
struct Punto {
    var x = 0.0, y = 0.0
    func estaAlaDerecha(de x: Double) -> Bool {
        return self.x > x
    }
}
let unPunto = Punto(x: 4.0, y: 5.0)
if unPunto.estaAlaDerecha(de: 1.0) {
    print("Este punto está a la derecha de la línea donde x == 1.0")
}
// Imprime "Este punto está a la derecha de la línea donde x == 1.0"
```

---

### Operaciones con instancias de tipo valor

- Las estructuras y las enumeraciones son **tipos valor**. Por defecto,
las propiedades de un tipo valor no pueden ser modificadas desde
dentro de los métodos de instancia.

- Si queremos modificar una propiedad de un tipo valor la forma más
natural de hacerlo es creando una instancia nueva, usando el estilo de 
programación funcional:
  
```swift
struct Punto {
    var x = 0.0, y = 0.0
    func incrementado(incX: Double, incY: Double) -> Punto {
        return Punto(x: x+incX, y: y+incY)
    }
}
let unPunto = Punto(x: 1.0, y: 1.0)
var puntoMovido = unPunto.incrementado(incX: 2.0, incY: 3.0)
print("Hemos movido el punto a (\(puntoMovido.x), \(puntoMovido.y))")
// Imprime "Hemos movido el punto a (3.0, 4.0)"
```

---

### Modificación de tipos valor desde dentro de la instancia ###

- Hay ocasiones en las que necesitamos modificar las
propiedades de nuestra estructura o enumeración dentro de un método
particular. 

- Necesitamos conseguir una conducta _mutadora_ para ese
método. Podemos conseguirlo colocando la palabra clave
`mutating` antes de la palabra `func` del método:

```swift
struct Punto {
    var x = 0.0, y = 0.0
    mutating func incrementa(incX: Double, incY: Double) {
        x += incX
        y += incY
    }
}
var unPunto = Punto(x: 1.0, y: 1.0)
unPunto.incrementa(incX: 2.0, incY: 3.0)
print("El punto está ahora en (\(unPunto.x), \(unPunto.y))")
// Imprime "El punto está ahora en (3.0, 4.0)"
```

- Hay que hacer notar que no es posible llamar a un método mutador
sobre una constante de un tipo estructura:

```swift
let puntoFijo = Punto(x: 3.0, y: 3.0)
puntoFijo.incrementa(incX: 2.0, incY: 3.0)
// esto provocará un error
```

---

### Asignación a `self` en un método mutador

- Los métodos mutadores pueden asignar una nueva instancia
  completamente nueva a la propiedad `self`

```swift
struct Punto {
    var x = 0.0, y = 0.0
    mutating func incrementa(incX: Double, incY: Double) {
        self = Punto(x: x + incX, y: y + incY)
    }
}
```

- El resutado final de llamar a esta versión alternativa será
  exactamente el mismo que llamar a la versión anterior (aunque con
  una pequeña penalización de eficiencia por tener que crear una
  nueva instancia.
  
- Podemos definir un método mutador en una enumeración y usar `self`
  para modificar la propia constante de la instancia:

```swift
enum InterruptorTriEstado {
    case apagado, medio, alto
    mutating func siguiente() {
        switch self {
        case .apagado:
            self = .medio
        case .medio:
            self = .alto
        case .alto:
            self = .apagado
        }
    }
}
var luzHorno = InterruptorTriEstado.medio
luzHorno.siguiente()
// luzHorno es ahora .alto
luzHorno.siguiente()
// luzHorno es ahora .apagado
```

---

### Métodos del tipo

- Es posible también definir métodos que se llaman en el propio tipo,
  llamados _métodos del tipo_.
- Se define escribiendo la palabra clave `static` antes de la palabra
  clave `func` del método. 

```swift
class NuevaClase {
    static func unMetodoDelTipo() {
        print("Hola desde el tipo")
    }
}
NuevaClase.unMetodoDelTipo()
```

- Podemos añadir a la clase `Ventana` una propiedad
y método de clase con la que almacenar instancias de ventanas. Inicialmente
guardamos un array vacío.


```swift
class Ventana {

    // Propiedades
    

    static var ventanas: [Ventana] = []
    static func registrar(ventana: Ventana) {
        ventanas.append(ventana)
    }
}
```

Cada vez que creamos una ventana podemos llamar al método `registrar`
de la clase para añadirlo a la colección de ventanas de la clase:

```swift
let v1 = Ventana()
Ventana.registrar(ventana: v1)
print("Se han registrado \(Ventana.ventanas.count) ventanas")
// Imprime "Se han registrado 1 ventanas"
```

---
### Inicialización
---

- _Inicialización_ es el proceso de preparar para su uso una instancia
  de una clase, estructura o enumeración. 
- Este proceso incluye la asignación de un valor inicial para cada
  propiedad almacenada y la ejecución de cualquier otra operación de
  inicialización que se necesite para que la nueva instancia esté
  lista para usarse.
- Para implementar este proceso de inicialización hay que definir
  _inicializadores_, métodos especiales que pueden
  llamarse para crear una nueva instancia de un tipo particular. 
- Los inicializadores en Swift no devuelven un valor.

---

### Inicializadores por defecto y _memberwise_ ###

- Ya hemos visto que es posible inicializar clases y estructuras
definiendo valores por defecto a todas sus propiedades (con la posible
excepción de las que tienen un tipo opcional). 

```swift
struct Punto2D {
    var x = 0.0
    var y = 0.0
}
class Segmento {
    var p1 = Punto2D()
    var p2 = Punto2D()
}

var s = Segmento()
```

- También es posible en las estructuras utilizar el inicializador
_memberwise_, en el que especificamos todos los valores de las
propiedades:


```swift
var p = Punto2D(x: 10.0, y: 10.0)
```

- Los inicializadores por defecto y _memberwise_ desaparecen en el
momento en que definimos algún inicializador con la palabra
`init`. Veamos cómo definir inicializadores.

---

### Inicialización de propiedades almacenadas

- Las clases y estructuras deben definir todas sus propiedades
  almacenadas a un valor inicial en el tiempo en la instancia se crea.
- Las propiedades almacenadas no pueden dejarse en un estado
  indeterminado (a no ser que se declaren como opcionales, en cuyo
  caso si no se inicializan su valor será `nil`)
- Podemos definir el valor inicial para una propiedad en un
  inicializador o asignándole un valor por defecto como parte de la
  definición de la propiedad.

Un _inicializador_, en su forma más simple, es como un método de la
instancia sin parámetros, escrito con la palabra clave `init`:


```swift
init() {
    // realizar alguna inicialización aquí
}
```

Ejemplo:

```swift
struct Fahrenheit {
    var temperatura: Double
    init() {
        temperatura = 32.0
    }
}
var f = Fahrenheit()
print("La temperatura por defecto es \(f.temperatura) Fahrenheit")
// Imprime "La temperatura por defecto es 32.0° Fahrenheit"
```

- También es posible inicializar la variable `temperatura`
  directamente en la propiedad. Es equivalente a lo anterior y es
  preferible por ser más claro:

```swift
struct Fahrenheit {
    var temperatura = 32.0
}
```

---

### Inicializadores personalizados

- Podemos proporcionar parámetros de inicialización como parte de la
definición de un inicializador, para definir los tipos y los nombres
de los valores que personalizan el proceso de inicialización. 
- Los parámetros de inicialización tienen las mismas capacidades y
sintaxis que los parámetros de funciones y métodos.

```swift
struct Celsius {
    var temperaturaEnCelsius: Double
    init(desdeFahrenheit fahrenheit: Double) {
        temperaturaEnCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(desdeKelvin kelvin: Double) {
        temperaturaEnCelsius = kelvin - 273.15
    }
}

let puntoDeEbullicionDelAgua = Celsius(desdeFahrenheit: 212.0)
// puntoDeEbullicionDelAgua.temperaturaEnCelsius es 100.0
let puntoDeCongelacionDelAgua = Celsius(desdeKelvin: 273.15)
// puntoDeCongelacionDelAgua.temperaturaEnCelsius is 0.0
```

- En los inicializadores es obligatorio proporcionar los nombres de
todos los parámetros:

```swift
struct Color {
    let rojo, verde, azul: Double
    init(rojo: Double, verde: Double, azul: Double) {
        self.rojo   = rojo
        self.verde = verde
        self.azul  = azul
    }
    init(blanco: Double) {
        rojo  = blanco
        verde = blanco
        azul  = blanco
    }
}
let magenta = Color(rojo: 1.0, verde: 0.0, azul: 1.0)
let medioGris = Color(blanco: 0.5)
```

- Podemos evitar proporcionar nombres externos usando un
  subrayado. Ejemplo:

```swift
struct Celsius {
   var temperaturaEnCelsius: Double
   init(desdeFahrenheit fahrenheit: Double) {
      temperaturaEnCelsius = (fahrenheit - 32.0) / 1.8
   }
   init(desdeKelvin kelvin: Double) {
      temperaturaEnCelsius = kelvin - 273.15
   }
   init(_ celsius: Double) {
      temperaturaEnCelsius = celsius
   }
}

let temperaturaCuerpo = Celsius(37.0)
// temperaturaCuerpo.temperaturaEnCelsius es 37.0
```

- Es posible dejar sin inicializar propiedades opcionales, el valor
  que toma es `nil`. 

Ejemplo:

```swift
class PreguntaEncuesta {
    let texto: String
    var respuesta: String?
    init(texto: String) {
        self.texto = texto
    }
    func pregunta() {
        print(texto)
    }
}
let preguntaQueso = PreguntaEncuesta(texto: "¿Te gusta el queso?")
preguntaQueso.pregunta()
// Imprime "¿Te gusta el queso?
preguntaQueso.respuesta = "Sí, me gusta el queso."
```

- Por último, es posible definir valores por defecto a los
  inicializadores que sean sobreescritos por otros inicializadores,
  así como invocar a otros inicializadores más básicos en otros:

```swift
struct Rectangulo {
    var origen = Punto()
    var tamaño = Tamaño()
    init() {}
    init(origen: Punto, tamaño: Tamaño) {
        self.origen = origen
        self.tamaño = tamaño
    }
    init(centro: Punto, tamaño: Tamaño) {
        let origenX = centro.x - (tamaño.ancho / 2)
        let origenY = centro.y - (tamaño.ancho / 2)
        self.init(origen: Punto(x: origenX, y: origenY), tamaño: tamaño)
    }
}
let basicRectangulo = Rectangulo()
// el origen de basicRectangulo es (0.0, 0.0) y su tamaño (0.0, 0.0)
let origenRectangulo = Rectangulo(origen: Punto(x: 2.0, y: 2.0),
                        tamaño: Tamaño(ancho: 5.0, alto: 5.0))
// el origne de origenRectangulo es (2.0, 2.0) y su tamaño (5.0, 5.0)
let centroRectangulo = Rectangulo(centro: Punto(x: 4.0, y: 4.0),
                        tamaño: Tamaño(ancho: 3.0, alto: 3.0))
// el origen de centroRectangulo es (2.5, 2.5) y su tamaño (3.0, 3.0)
```

---
### Herencia
---

- Una clase puede _heredar_ métodos, propiedades y otras
  características de otra clase. 
- Cuando una clase hereda de otra, la clase que hereda se denomina
  _subclase_, y la clase de la que se hereda se denomina su
  _superclase_.
- Las clases en Swift pueden llamar y acceder a métodos y propiedades
  que pertenecen a su superclase y pueden proporcionar sus propias
  versiones que sobreescriben esos métodos y propiedades. 
- Para sobreescribir un método o una propiedad es necesario cumplir
  con la definición proporcionada por la superclase.
- Las clases también pueden añadir observadores (veremos después) a
  las propiedades heredadas para ser notificadas cuando cambia el
  valor de una propiedad. 

---

### Definición de una clase base

- Una clase que no hereda de ninguna otra se denomina una _clase base_
  (_base class_). A diferencia de otros lenguajes orientados a
  objetos, **las clases en Swift no heredan de una clase base universal**.
- También a diferencia de otros lenguajes orientados a objetos **Swift
  no permite definir clases _abstractas_** que no permiten crear
  instancias. Cualquier clase en Swift puede ser instanciada.

Ejemplo:

```swift
class Vehiculo {
    var velocidadActual = 0.0
    var descripcion: String {
        return "viajando a \(velocidadActual) kilómetros por hora"
    }
    func hazRuido() -> String {
        // devuelve una cadena vacía - un vehículo arbitrario no hace
        // ruido necesariamente
        return ""
    }
}
```

- Creamos una instancia nueva de `Vehiculo` y accedemos a su
  descripción:

```swift
let unVehiculo = Vehiculo()
print("Vehículo: \(unVehiculo.descripcion)")
// Vehículo: viajando a 0.0 kilómetros por hora
```

- La clase `Vehiculo` define características comunes para un vehículo
  arbitrario, pero no es de mucha utilidad por si misma. 
- Para hacerla más útil, tenemos que **refinarla** para describir
  tipos de vehículos más específicos.

---

### Construcción de subclases

- La construcción de una subclase (_subclassing_) es la acción de
  basar una nueva clase en una clase existente. 
- La subclase hereda características de la clase existente, que
  después podemos refinar. 
- También podemos añadir nuevas características a la subclase.

Sintaxis:

```swift
class UnaSubclase: UnaSuperClase {
    // definición de la subclase
}
```

- Por ejemplo podemos definir una subclase `Bicicleta`:

```swift
class Bicicleta: Vehiculo {
    var tieneCesta = false
}
```

- Por defecto, cualquier instancia nueva de `Bicicleta` no tendrá una
  cesta. 
- Podemos establecer la propiedad `tieneCesta` a `true` para una
  instancia particular de `Bicicleta` después de crearla:

```swift
let bicicleta = Bicicleta()
bicicleta.tieneCesta = true
```

- Podemos también modificar la propiedad heredada `velocidadActual` y
  preguntar por la propiedad `descripcion`:

```swift
bicicleta.velocidadActual = 10.0
print("Bicicleta: \(bicicleta.descripcion)")
// Bicicleta: viajando a 10.0 kilómetros por hora
```

- Podemos construir subclases a partir de otras subclases. 
- Por ejemplo creamos una subclase de `Bicicleta` que representa una
  bicicleta de dos sillines (un "tandem"):

```swift
class Tandem: Bicicleta {
    var numeroActualDePasajeros = 0
}
```

- `Tandem` hereda todas las propiedades y métodos de `Bicicleta`, que
  a su vez hereda todas sus propiedades y métodos de `Vehiculo`. 
- La subclase `Tandem` también añade una nueva propiedad almacenada
  llamada `numeroActualDePasajeros`, con un valor por defecto de 0.
- Si creamos una instancia de `Tandem` podremos trabajar con
  cualquiera de sus propiedades nuevas y heredadas, y preguntar a la
  descripción de solo lectura que hereda de `Vehiculo`:

```swift
let tandem = Tandem()
tandem.tieneCesta = true
tandem.numeroActualDePasajeros = 2
tandem.velocidadActual = 18.0
print("Tandem: \(tandem.descripcion)")
// Tandem: viajando a 18.0 kilómetros por hora
```

---

### Sobreescritura

- Una subclase puede proporcionar su propia implementación de un
  método de la instancia, método del tipo, propiedad de la instancia o
  propiedad del tipo que hereda de su superclase. Esto se conoce como
  _sobreescritura_ (_overriding_).
- Para sobreescribir una característica que sería de otra forma heredada
  debemos usar el prefijo `override`.
- Cuando proporcionamos una sobreescritura puede ser útil acceder a
  los valores proporcionados por la clase padre. Para acceder a ellos
  podemos usar el prefijo `super`.

Ejemplo:

```swift
class Tren: Vehiculo {
    override func hazRuido() -> String {
        return "Chuu Chuu"
    }
}
```

- Si creamos una nueva instancia de `Tren` y llamamos al método
  `hazRuido` podemos comprobar que se llama a la versión del método de
  la subclase:

```swift
let tren = Tren()
print(tren.hazRuido())
// Imprime "Chuu Chuu"
```

- Podemos sobreescribir cualquier propiedad heredada del tipo o de la
  instancia y proporcionar nuestros propios _getters_ y _setters_ para
  esa propiedad.
- Podemos proporcionar un _getter_ (o _setter_, si es apropiado) para
  sobreescribir cualquier propiedad heredada, independientemente de si
  se trata de una propiedad almacenada o calculada.
  
Por ejemplo, podemos definir un coche con marchas:

```swift
class Coche: Vehiculo {
    var marcha = 1
    override var descripcion: String {
        return super.descripcion + " con la marcha \(marcha)"
    }
}
```

Podemos ver el funcionamiento en el siguiente ejemplo:

```swift
let coche = Coche()
coche.velocidadActual = 50.0
coche.marcha = 3
print("Coche: \(coche.descripcion)")
// Coche: viajando a 50.0 kilómetros por hora con la marcha 3
```

- Por último, podemos añadir observadores a propiedades heredadas. 
- Esto nos permite ser notificados cuando el valor de una propiedad
  heredada cambia, independientemente de si esa propiedad se ha
  implementado en la subclase o en la superclase.

Por ejemplo, la clase `CocheAutomatico` representa un coche con una
caja de cambios automática, que selecciona automáticamente la marcha
basándose en la velocidad actual:

```swift
class CocheAutomatico: Coche {
    override var velocidadActual: Double {
        didSet {
            marcha = min(Int(velocidadActual / 25.0) + 1, 5)
        }
    }
}
```

- En cualquier momento que se modifica la propiedad `velocidadActual`
  de una instancia de `CocheAutomatico`, el observador `didSet`
  establece la propiedad `marcha` a un valor apropiado para la nueva
  velocidad. 
- Un ejemplo de ejecución:

```swift
let automatico = CocheAutomatico()
automatico.velocidadActual = 100.0
print("CocheAutomatico: \(automatico.descripcion)")
// CocheAutomatico: viajando a 100.0 kilómetros por hora con la marcha 5
```

---

### Inicialización ###

- Supongamos que añadimos un inicializador a la clase base `Vehiculo`:

```swift
class Vehiculo {
    var velocidadActual = 0.0
    
    // Resto de código de la clase
    
    init(velocidad: Double) {
        self.velocidadActual = velocidad
    }
}
```

- Automáticamente las subclases heredan este inicializador y dejan de
tener el inicializador por defecto:

```swift
// Error: let miBici = Bicicleta()
let miBic = Bicicleta(velocidad: 5)
```

- Podemos definir inicializadores propios en las subclases que
inicialicen sus atributos, pero siempre es necesario inicializar la
clase base llamando a su inicializador con `super`:

```swift
class Bicicleta: Vehiculo {
    var tieneCesta = false
    
    init(tieneCesta: Bool, velocidad: Double) {
        self.tieneCesta = tieneCesta
        super.init(velocidad: velocidad)
    }
}
```

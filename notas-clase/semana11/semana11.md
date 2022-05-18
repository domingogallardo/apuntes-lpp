## Tema 7: Programación Orientada a Objetos con Swift (2)

### Contenidos

- 1. Introducción, historia y características
- 2. Clases y estructuras
- 3. Propiedades
- 4. Métodos
- 5. Herencia
- 6. Inicialización
- **7. Funciones operadoras**
- **8. Protocolos**
- **9. Casting de tipos**
- **10. Genéricos**
- **11. Extensiones**


----

### Bibliografía

- Swift Language Guide
    - [Protocolos](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID267)
    - [Casting de tipos](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html#//apple_ref/doc/uid/TP40014097-CH22-ID338)
    - [Extensiones](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html#//apple_ref/doc/uid/TP40014097-CH24-ID151)
    - [Funciones operador](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html#//apple_ref/doc/uid/TP40014097-CH27-ID28)
    - [Genéricos](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)

---
### 7. Funciones operadoras
---

- Las clases y las estructuras pueden proporcionar sus propias
  implementaciones de operadores existentes. Esto se conoce como
  _sobrecarga_ de los operadores existentes.

Por ejemplo, podemos implementar el operador de suma (`+`) para una
estructura `Vector2D`:


```swift
struct Vector2D {
    var x = 0.0, y = 0.0
    static func + (izquierdo: Vector2D, derecho: Vector2D) -> Vector2D {
        return Vector2D(x: izquierdo.x + derecho.x, y: izquierdo.y + derecho.y)
    }
}
```

- La función operador se define como una función estática con un nombre
  de función que empareja con el operador a sobrecargar (`+`). 
- La función toma dos parámetros de entrada de tipo `Vector2D` y
  devuelve un único valor de salida, también de tipo `Vector2D`.
- La función se define globalmente, más que como un método en la
  estructura `Vector2D`, para que pueda usarse como un operador infijo
  entre instancias existentes de `Vector2D`:


```swift
let vector = Vector2D(x: 3.0, y: 1.0)
let otroVector = Vector2D(x: 2.0, y: 4.0)
let vectorSuma = vector + otroVector
// vectorSuma es una instancia de Vector2D con valores de (5.0, 5.0)
```

---

### Operadores prefijos y postfijos

- Las clases y las estructuras pueden también proporcionar
  implementaciones de los operadores unarios estándar. 
- Los operadores unarios operan sobre un único objetivo. Son prefijos
  se preceden el objetivo (como `-a`) y postfijos si siguen su
  objetivo (como en `b!`).
- Para implementar un operador unario prefijo o postfijo se debe
  escribir el modificador `prefix` o `postfix` antes de la palabra
  clave `func` en la declaración de la función operador:

Por ejemplo, implementamos el operador unario negación (`-a`) para
instancias de `Vector2D`:


```swift
struct Vector2D {
   ...
   static prefix func - (vector: Vector2D) -> Vector2D {
       return Vector2D(x: -vector.x, y: -vector.y)
   }
}
```

Ejemplo de uso:

```swift
let positivo = Vector2D(x: 3.0, y: 4.0)
let negativo = -positivo
// negativo es una instancia de Vector2D con valores de (-3.0, -4.0)
let tambienPositivo = -negativo
// tambienPositivo es una instancia de Vector2D con valores de (3.0, 4.0)
```

---
### 8. Protocolos
---

- Un _protocolo_ (_protocol_) define un esquema de métodos,
  propiedades y otros requisitos (sin implementación).
- El protocolo puede luego ser _adoptado_ (_adopted_) por una clase,
  estructura o enumeración para proporcionar una implementación real de
  esos requisitos. 
- Cualquier tipo que satisface los requerimientos de un protocolo se
  dice que _se ajusta_ o cumple (_conform_) ese protocolo.
- Podemos considerar los protocolos como una construcción de Swift que
  amplía la idea de las _interfaces_ de Java. 
  
---

### Sintaxis

- Similar a las clases, estructuras y enumeraciones:

```swift
protocol UnProtocolo {
    // definición del protocolo
}
```

- Una estructura que se ajusta a dos protocolos:

```swift
struct UnStruct: PrimerProtocolo, OtroProtocolo {
    // definición del struct
}
```

- Una clase que hereda de una superclase y se ajusta a dos protocolos:

```swift
class UnaClase: UnaSuperClase, PrimerProtocolo, OtroProtocolo {
    // definición de la clase
}
```

---

### Requisitos relacionados con las propiedades

- Un protocolo puede requerir que se proporcione una propiedad de
  instancia o de tipo con un nombre y tipo particular, sin especificar
  si es una propiedad calculada o almacenada,
  sólo especifica el nombre y el tipo de la propiedad requerida. 
- También especifica si la propiedad debe ser de lectura y
  escritura o sólo de lectura.
- Si el protocolo sólo requiere que la propiedad sea de lectura, el
  requisito puede ser satisfecho por cualquier tipo de propiedad, y es
  válido que la propiedad sea también de escritura si es útil para
  nuestro propio código (el requisito de ser de lectura se cumpliría).

```swift
protocol UnProtocolo {
    var debeSerEscribible: Int { get set }
    var noTienePorQueSerEscribible: Int { get }
}
```

- Para definir una propiedad de tipo hay que precederla en el
  protocolo con la palabra clave `static`:

```swift
protocol OtroProtocolo {
    static var unaPropiedadDeTipo: Int { get set }
}
```

Ejemplo:

```swift
protocol TieneNombre {
    var nombreCompleto: String { get }
}
```

- Un ejemplo de una sencilla estructura que adopta el protocolo:

```swift
struct Persona: TieneNombre {
    var edad: Int
    var nombreCompleto: String
}

let john = Persona(edad: 35, nombreCompleto: "John Appleseed")
// john.nombreCompleto es "John Appleseed"
```

- Otro ejemplo de una clase más compleja, que también adopta el
  protocolo:

```swift
class NaveEstelar: TieneNombre {
    var prefijo: String?
    var nombre: String
    init(nombre: String, prefijo: String? = nil) {
        self.nombre = nombre
        self.prefijo = prefijo
    }
    var nombreCompleto: String {
        return (prefijo != nil ? prefijo! + " " : "") + nombre
    }
}
var ncc1701 = NaveEstelar(nombre: "Enterprise", prefijo: "USS")
// ncc1701.nombreCompleto es "USS Enterprise"
```

---

### Requisitos de métodos

- Los protocolos pueden requerir que los tipos que se ajusten a ellos
  implementen métodos de instancia y de tipos específicos. 

```swift
protocol UnProtocolo {
    func unMetodo() -> Int
}
```

- Los métodos del tipo en el protocolo deben indicarse con la palabra
  clave `static`:

```swift
protocol UnProtocolo {
    static func unMetodoDelTipo()
}
```

Ejemplo:

```swift
protocol GeneradorNumerosAleatorios {
    func random() -> Double
}
```

- Una implementación de una clase que adopta el protocolo:

```swift
class GeneradorLinealCongruente: GeneradorNumerosAleatorios {
    var ultimoRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        let number = ultimoRandom * a + c
        ultimoRandom = number.truncatingRemainder(dividingBy: m)
        return ultimoRandom / m
    }
}
let generador = GeneradorLinealCongruente()
print("Un número aleatorio: \(generador.random())")
// Imprime "Un número aleatorio: 0.37464991998171"
print("Y otro: \(generador.random())")
// Imprime "Y otro: 0.729023776863283"
```

---

### Requisito de método `mutating`

- Si definimos un protocolo con un requisito de método de instancia
  que pretenda mutar las instancias del tipo que adopte el protocolo,
  se debe marcar el método con la palabra `mutating`. 
- Esto permite a las estructuras y enumeraciones que adopten el
  protocolo definir ese método como `mutating`. 
- No es necesario hacerlo con las clases, porque la palabra `mutating`
  solo es necesaria en estructuras y enumeraciones.

Un ejemplo:

```swift
protocol Conmutable {
    mutating func conmutar()
}

enum Interruptor: Conmutable {
    case apagado, encendido
    mutating func conmutar() {
        switch self {
        case .apagado:
            self = .encendido
        case .encendido:
            self = .apagado
        }
    }
}

var interruptorLampara = Interruptor.apagado
interruptorLampara.conmutar()
// interruptorLampara es ahora igual a .encendido
```

---

### Protocolos como tipos

- Los protocolos no implementan realmente ninguna funcionalidad por
  ellos mismos. 
- Sin embargo, cualquier protocolo que definamos se convierte
  automáticamente en un tipo con todas sus propiedades que podemos
  usar en nuestro código. Podemos entonces usar el protocolo en
  cualquier sitio donde permitamos otros tipos, incluyendo:
    - El tipo de un parámetro de una función, método o inicializador o
      de sus valores devueltos.
    - El tipo de una constante, variable o propiedad.
    - El tipo de los ítems de un array, diccionario u otro contenedor.

Ejemplo:

```swift
class Dado {
    let caras: Int
    let generador: GeneradorNumerosAleatorios
    init(caras: Int, generador: GeneradorNumerosAleatorios) {
        self.caras = caras
        self.generador = generador
    }
    func tirar() -> Int {
        return Int(generador.random() * Double(caras)) + 1
    }
}
```

- La propiedad `generador` es del tipo
  `GeneradorNumerosAleatorios`. Podemos asignarle una instancia de
  **cualquier tipo** que adopte el protocolo `GeneradorNumerosAleatorios`.
- El inicializador tiene un parámetro llamado `generador`, que también
  es del tipo `GeneradorNumerosAleatorios`. Podemos pasarle un valor
  de cualquier instancia que se ajuste a este tipo. 
- El método `tirar` llama al método `random()` del generador para
  crear un nuevo número aleatorio. Debido a que sabemos que el
  generador se ajusta al protocolo `GeneradorNumerosAleatorios`
  tenemos la garantía de que va a existir un método `random()` al que
  llamar.

Un ejemplo de uso del código:

```swift
var d6 = Dado(caras: 6, generador: GeneradorLinealCongruente())
for _ in 1...5 {
    print("La tirada del dado es \(d6.tirar())")
}
// La tirada del dado es 3
// La tirada del dado es 5
// La tirada del dado es 4
// La tirada del dado es 5
// La tirada del dado es 4
```

---

### Colecciones de tipos protocolo

- Un protocolo puede usarse como el tipo que se almacena un una
  colección (array, diccionario, etc.)

Ejemplo:

```swift
var peterParker = Persona(edad: 24, nombreCompleto: "Peter Parker")
var ncc1701 = NaveEstelar(nombre: "Enterprise", prefijo: "USS")

let cosasConNombre: [TieneNombre] = [peterParker, ncc1701]

for cosa in cosasConNombre {
   print(cosa.nombreCompleto)
}
// Peter Parker
// USS Enterprise
```

- El iterador `cosa` que va recorriendo los valores del array es de
tipo `TieneNombre`, no es de tipo `Persona` ni de tipo `NaveEstelar`.
- Por ser de tipo `TieneNombre` sabemos que tiene una propiedad
  `nombreCompleto` (declarada por el protocolo) que usamos en la
  sentencia con la llamada a `print`.

- En el bucle podría interesarnos también acceder a las propiedades
`edad` o `prefijo` dependiendo de si tenemos una `Persona` o una
`NaveEstelar`. Veremos más adelante como hacerlo cuando hablemos de
_Casting de tipos_.


---

### Protocolo `Equatable`

- En la [biblioteca estándar de Swift](https://developer.apple.com/documentation/swift) se definen distintos protocolos
  como `Collection` y `Equatable` que describen abstracciones
  comunes. 
- Muchos de estos protocolos incorporan implementaciones por defecto
  de algunos de sus métodos mediante extensiones definidas en la
  propia biblioteca estándar.
- Ejemplo del protocolo
  [`Equatable`](https://developer.apple.com/documentation/swift/equatable)
  en el que se define las operaciones igual `==` y distinto `!=`. La
  primera debemos implementarla nosotros. La segunda ya tiene una
  implementación por defecto.
  
```swift
class Punto3D: Equatable {
    let x, y, z: Double

    init(x: Double, y: Double, z: Double) {
        self.x = x 
        self.y = y 
        self.z = z 
    }

    static func == (izquierda: Punto3D, derecha: Punto3D) -> Bool {
        return
            izquierda.x == derecha.x &&
            izquierda.y == derecha.y &&
            izquierda.z == derecha.z
    }
}

let p1 = Punto3D(x: 0.0, y: 0.0, z: 0.0)
let p2 = Punto3D(x: 0.0, y: 0.0, z: 0.0)

print(p1 == p2)
// Imprime true
print(p1 != p2)
// Imprime false
```

- El operador `==` se define en la propia clase, con un método
  estático tal y como vimos en el apartado anterior sobre funciones
  operadoras.
- El operador `!=` que se usa en la última instrucción se define en una
  implementación por defecto proporcionada por Swift.

- En **las estructuras y enumeraciones** el compilador define una
implementación automática del operador `==` al añadir el protocolo
`Equatable`, siempre que las propiedades almacenadas y los valores
asociados cumplan ese protocolo.
  
- Por ejemplo, si en lugar de una clase definimos un `struct Punto3D`
el código quedaría como sigue (no es necesario definir ni el
inicializador por defecto ni el operador `==`):

```swift
struct Punto3D: Equatable {
    let x, y, z: Double
}

let p1 = Punto3D(x: 0.0, y: 0.0, z: 0.0)
let p2 = Punto3D(x: 0.0, y: 0.0, z: 0.0)

print(p1 == p2)
// Imprime true
print(p1 != p2)
// Imprime false
```

---

### Herencia en protocolos


- Un protocolo puede heredar uno o más protocolos y puede añadir
requisitos adicionales sobre los requisitos que hereda. 

- Sintaxis:

```swift
protocol ProtocoloQueHereda: UnProtocolo, OtroProtocolo {
    // definición del protocolo
}
```

- Por ejemplo, recordemos el protocolo `TieneNombre`:

```swift
protocol TieneNombre {
    var nombreCompleto: String { get }
}
```

- Podemos definir el protocolo `TieneEdad`, que hereda del protocolo
anterior y que obliga a definir una propiedad de lectura `edad` de
tipo `Int`:

```swift
protocol TieneEdad: TieneNombre {
    var edad: Int { get }
}
```

- Si un tipo se ajusta al protocolo `TieneEdad` debe cumplir sus
  restricciones y las de `TieneNombre`:

```swift
struct Persona: TieneEdad {
    var nombre: String
    var apellidos: String
    var nombreCompleto: String {
        return nombre + " " + apellidos
    }
    var edad: Int
}
```

- Ejemplo:

```swift
let persona = Persona(nombre:"Pedro", apellidos: "García Pérez", edad: 23)
print(persona.edad)
var algoConEdad: TieneEdad = persona
print(algoConEdad.edad)
// Imprime 23
var algoConNombre: TieneNombre = persona
print(algoConNombre.nombreCompleto) 
// Imprime "Pedro García Pérez"
```

- Otro ejemplo de la librería de Swift es `Comparable` y
`Equatable`. El protocolo `Comparable` hereda de
`Equatable`. Cumpliendo el protocolo `Comparable` también se debe
cumplir el protocolo `Equatable`.

- En el caso de los structs, Swift crea automáticamente el operador `==`
y nosotros solo tendríamos que definir el operador `<`. 

```swift
struct CoordPantalla : Comparable {
    var x: Int 
    var y: Int 
    static func < (primero: CoordPantalla, segundo: CoordPantalla) -> Bool { 
        return primero.x < segundo.x || 
               (primero.x == segundo.x && primero.y < segundo.y) 
    } 
}
```

- Automáticamente el compilador genera a partir de los operadores `<` y
`==` los operadores `>`, `<=`, etc.:

```swift
var c1 = CoordPantalla(x: 0, y: 0)
var c2 = CoordPantalla(x: 10, y: 10)
c1 < c2 // true
c1 > c2 // false
c1.x = 10
c1.y = 10
c1 == c2 // true
```


---
### 9. Casting de tipos
---

- El _casting_ de tipos es una forma de comprobar el tipo de una
  instancia o de tratar esa instancia como de una superclase distinta.
- La forma de implementarlo es utilizando los operadores `is` y `as`.
- También se puede usar el _casting_ de tipos para comprobar si un
  tipo se ajusta a un protocolo.

---

### Una jerarquía de clases para el casting de tipos

- Vamos a construir una jerarquía de clases y subclases con las que
  trabajar.
- Utilizaremos el _casting_ de tipos para comprobar el tipo de una
  instancia particular de una clase y para convertir esa instancia en
  otra clase dentro de la misma jerarquía.

Por ejemplo, supongamos que estamos diseñando un programa para
trabajar con una biblioteca de medios digitales (libros, películas,
música, etc.).

- La clase `MediaItem` proporciona la funcionalidad básica de
cualquier tipo de ítem que aparece en una biblioteca de medios
digitales. 

```swift
class MediaItem {
    var nombre: String
    init(nombre: String) {
        self.nombre = nombre
    }
}
```

- Las siguientes clases definen dos subclases de `MediaItem`:
`Pelicula` y `Cancion`:

```swift
class Pelicula: MediaItem {
    var director: String
    init(nombre: String, director: String) {
        self.director = director
        super.init(nombre: nombre)
    }
}

class Cancion: MediaItem {
    var artista: String
    init(nombre: String, artista: String) {
        self.artista = artista
        super.init(nombre: nombre)
    }
}
```

- Por último, creamos un array constante llamado `biblioteca`, que
contienen dos instancias de `Pelicula` y tres instancias de
`Cancion`. 

```swift
let biblioteca: [MediaItem] = [
    Pelicula(nombre: "El Señor de los Anillos", director: "Peter Jackson"),
    Cancion(nombre: "Child in Time", artista: "Deep Purple"),
    Pelicula(nombre: "El Puente de los Espías", director: "Steven Spielberg"),
    Cancion(nombre: "I Wish You Were Here", artista: "Pink Floyd"),
    Cancion(nombre: "Yellow", artista: "Coldplay")
]
```

- Los ítems almacenados en la biblioteca son todavía instancias de
  `Pelicula` y `Cancion`. 
- Sin embargo, el array es del tipo `[MediaItem]`. Si iteramos sobre
  los contenidos de este array, los ítems que recibiremos tendrán el
  tipo `MediaItem`.
- Para trabajar con ellos como su tipo nativo, debemos chequear su
  tipo, y hacer un _downcast_ a su tipo concreto.

- En el ejemplo anterior se puede dejar que el compilador infiera el
tipo del array:

```swift
let biblioteca = [
    Pelicula(nombre: "El Señor de los Anillos", director: "Peter Jackson"),
    Cancion(nombre: "Yellow", artista: "Coldplay")
]
```

- Sucede igual en el ejemplo visto anteriormente en el que se guardan
en un array de tipo `TieneNombre` (un protocolo) dos instancias de
estructuras distinas (una `Persona` y una `NaveEstelar`) que cumplen
el protocolo.

```swift
var peterParker = Persona(edad: 24, nombreCompleto: "Peter Parker")
var ncc1701 = NaveEstelar(nombre: "Enterprise", prefijo: "USS")

let cosasConNombre: [TieneNombre] = [peterParker, ncc1701]

for cosa in cosasConNombre {
   print(cosa.nombreCompleto)
}
// Peter Parker
// USS Enterprise
```

- También podemos aplicar los operadores de comprobación de tipo y de
_downcasting_ que veremos a continuación a este caso.


---

### Comprobación del tipo

- El _operador de comprobación_ (_check operator_) `is` permite
  comprobar si una instancia es de un cierto tipo subclase.
- Devuelve `true` si la instancia es del tipo de la subclase y `false`
  si no.

Ejemplo:

```swift
var contadorPeliculas = 0
var contadorCanciones = 0

for item in biblioteca {
    if item is Pelicula {
        contadorPeliculas += 1
    } else if item is Cancion {
        contadorCanciones += 1
    }
}

print("La biblioteca contiene \(contadorCanciones) películas y \(contadorPeliculas) canciones")
// Imprime "La biblioteca contiene 3 películas y 2 canciones"
```

---

### Downcasting

- Una constante o variable de un cierto tipo de clase puede referirse
  (contener) a una instancia de una subclase. 
- Podemos entonces hacer un _downcast_ al tipo de la subclase con
  un operador de _cast_ (`as?` o `as!`). 
- Como el _downcast_ puede fallar, la versión condicional, `as?`,
  devuelve un valor opcional del tipo al que estamos intentando hacer
  el _downcasting_. La versión forzosa, `as!`, intenta el _downcast_ y
  fuerza la desenvoltura del resultado.

Ejemplo:

```swift
for item in biblioteca {
    if let pelicula = item as? Pelicula {
        print("Película: \(pelicula.nombre), dir. \(pelicula.director)")
    } else if let cancion = item as? Cancion {
        print("Cancion: \(cancion.nombre), de \(cancion.artista)")
    }
}

// Película: El Señor de los Anillos, dir. Peter Jackson
// Cancion: Child in Time, de Deep Purple
// Película: El Puente de los Espías, dir. Steven Spielberg
// Cancion: I Wish You Were Here, de Pink Floyd
// Cancion: Yellow, de Coldplay
```

- Otra forma de hacer el _downcasting_ es usando un operador `switch as`
en el que se definen los distintos tipos posibles que puede tener la
variable y se asignan a una variable del tipo correspondiente con un
operador `case let`. Por ejemplo, el siguiente código es equivalente
al anterior:

```swift
for item in biblioteca {
    switch item {
    case let pelicula as Pelicula:
        print("Película: \(pelicula.nombre), dir. \(pelicula.director)")
    case let cancion as Cancion:
        print("Cancion: \(cancion.nombre), de \(cancion.artista)")
    default:
        break
    }
}
```

---

### El tipo `Any`

- El tipo `Any` puede representar una instancia de cualquier tipo,
incluyendo tipos función:

Ejemplo:

```swift
var array = [Any]()

array.append(0)
array.append(0.0)
array.append(42)
array.append(3.14159)
array.append("hola")
array.append((3.0, 5.0))
array.append(Pelicula(nombre: "Ghostbusters", director: "Ivan Reitman"))
array.append({ (name: String) -> String in "Hola, \(name)" })
```

- El array contiene dos valores `Int`, dos valores `Double`, un valor
  `String`, una tupla del tipo `(Double, Double)`, la película
  "Ghostbusters", y una clausura que toma un `String` y devuelve otro
  `String`.
- Podemos usar los operadores `is` y `as` en una sentencia `switch`
  para descubrir en tiempo de ejecución el tipo específico de una
  constante o variable de la que sólo se sabe que es de tipo `Any`:

```swift
for item in array {
    switch item {
    case 0 as Int:
        print("cero como un Int")
    case 0 as Double:
        print("cero como un Double")
    case let someInt as Int:
        print("un valor entero de \(someInt)")
    case let unDouble as Double where unDouble > 0:
        print("a valor positivo de \(unDouble)")
    case is Double:
        print("algún otro valor double que no quier imprimir")
    case let someString as String:
        print("una cadena con valor de \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("un punto (x, y) en \(x), \(y)")
    case let pelicula as Pelicula:
        print("una película: \(pelicula.nombre), dir. \(pelicula.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("alguna otra cosa")
    }
}

// cero como un Int
// cero como un Double
// un valor entero de 42
// a valor positivo de 3.14159
// una cadena con valor de "hola"
// un punto (x, y) en 3.0, 5.0
// una película: Ghostbusters, dir. Ivan Reitman
// Hola, Michael
```

---

### Comprobación de ajustarse a un protocolo

- Podemos usar también los operadores anteriores `is` y `as` (y `as?`
  y `as!`) para comprobar si una instancia se ajusta a un protocolo y
  para hacer un _cast_ a un protocolo específico.

Ejemplo:

```swift
protocol TieneArea {
    var area: Double { get }
}
```

- Definimos dos clases `Circulo` y `Pais` que se ajustan ambos al protocolo: 

```swift
class Circulo: TieneArea {
    let pi = 3.1415927
    var radio: Double
    var area: Double { return pi * radio * radio }
    init(radio: Double) { self.radio = radio }
}

class Pais: TieneArea {
    var area: Double
    init(area: Double) { self.area = area }
}
```

- La clase `Circulo` implementa el requisito como una propiedad
  calculada, basada en la propiedad almacenada `radio`. 
- La clase `Pais` implementa el requisito directamente como una
  propiedad almacenada. 
- Ambas clases se ajustan correctamente al
  protocolo `TieneArea`.

Definimos una clase `Animal` que no se ajusta al protocolo:

```swift
class Animal {
    var patas: Int
    init(patas: Int) { self.patas = patas }
}
```

- Las clases `Circulo`, `Pais` y `Animal` no tienen ninguna clase base
  compartida. Sin embargo, todas son clases, por lo que las instancias
  de los tres tipos pueden usarse para inicializar un array que
  almacena valores de tipo `Any`:

```swift
let objetos: [Any] = [
    Circulo(radio: 2.0),
    Pais(area: 243_610),
    Animal(patas: 4)
]
```

- Y ahora podemos iterar sobre el array de objetos, comprobando para
  cada ítem si la instancia se ajusta al protocolo `TieneArea`:

```swift
for objecto in objetos {
    if let objetoConArea = objecto as? TieneArea {
        print("El área es \(objetoConArea.area)")
    } else {
        print("Algo que no tiene un área")
    }
}

// El área es 12.5663708
// El área es 243610.0
// Algo que no tiene un área
```

- Cuando un objeto en el array se ajusta al protocolo `TieneArea`, el
  valor opcional devuelto por el operador `as?` se desenvuelve con un
  ligado opcional en una constante llamada `objetoConArea`. 
- Esta constante tiene el tipo `TieneArea`, por lo que su propiedad
  `area` podrá ser accedida e impresa.


---
###  10. Genéricos
---

- Veamos cómo podemos utilizar los genéricos con clases y estructuras.
- Vamos a utilizar como ejemplo un tipo de dato muy sencillo: una pila
  (_stack_) en la que se podrán añadir (_push_) y retirar (_pop_)
  elementos.

Versión no genérica: 

```swift
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
```

Versión usando genéricos:

```swift
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
```

- El parámetro del tipo `Element` define un tipo genérico que se utiliza
  como _placeholder_ del tipo real del que se declare la
  estructura. 
- Se utiliza en la definición de los distintos elementos de la
  estructura. Por ejemplo, el array de ítems es un array de
  `Element`s. Y los ítems añadidos y retirados de la pila son también
  objetos de tipo `Element`.

Por ejemplo, podemos crear una pila de cadenas:

```swift
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// la pila contiene ahora 4 cadenas
```

Y podemos retirar la última cadena de la pila:

```swift
let fromTheTop = stackOfStrings.pop()
```

---

### Restricciones en los tipos genéricos ###

- Es posible definir una restricción en el tipo genérico, indicando que
debe heredar de una clase o cumplir un protocolo.

- Sintaxis:

```swift
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}
```

- Por ejemplo, supongamos una función que busca una cadena en un array
de cadenas y devuelve el índice en el que se encuentra:

```swift
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
```

- Uso:

```swift
let cadenas = ["gato", "perro", "llama", "kanguro", "colibrí"]
if let indiceEncontrado = findIndex(ofString: "llama", in: cadenas) {
    print("El índice de la llama es \(indiceEncontrado)")
}
// Imprime: "El índice de la llama es 2"
```

- La función anterior busca en un array de cadenas. ¿Podríamos
generalizarla para que buscara en un array de cualquier tipo? Vamos a
probarlo: 

```swift
func findIndex<T>(ofString valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
```

- Error:

```
error: binary operator '==' cannot be applied to two 'T' operands
        if value == valueToFind {
           ~~~~~ ^  ~~~~~~~~~~~
```

Debemos restringir el tipo genérico al protocolo `Equatable`:

```swift
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
```

- Ahora ya podemos usar en la función `find` cualquier tipo que cumpla
`Equatable`, como `Double`:

```swift
let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25, 9.3])
// devuelve Int? 2
```


---
### 11. Extensiones
---

- Las _extensiones_ añaden nueva funcionalidad a una clase,
  estructura, enumeración. 
- Esto incluye la posibilidad de extender tipos para los que no
  tenemos acceso al código fuente original (esto se conoce como
  _modelado retroactivo_).
- Es posible incluso extender estructuras de las librerías estándar de
  Swift, como Int, Double, Array, etc.

Entre otras cosas, las extensiones pueden: 

- Añadir propiedades calculadas de instancia y de tipo
- Definir métodos de instancia y de tipo
- Proporcionar nuevos inicializadores


---

### Sintaxis

- Para declarar una extensión hay que usar la palabra clave
  `extension`
- El tipo `UnTipo` sobre el que se realiza la extensión debe existir previamente.

```swift
extension UnTipo {
    // nueva funcionalidad para añadir a UnTipo
}
```

---

### Propiedades calculadas

- Las extensiones pueden añadir propiedades calculadas de instancias y
  de tipos. 

Ejemplo:

```swift
extension Persona {
   var mayorEdad: Bool {
      return edad >= 18
   }
}
```

- Una vez definida esta extensión, hemos ampliado la clase con esta
  nueva propiedad, sin tocar el código de la clase.
- Podemos preguntar si una persona es mayor de edad:

```swift
var p = Persona(edad: 15, nombreCompleto: "Lucía")
p.mayorEdad // false
```

---

### Inicializadores

- Las extensiones pueden añadir nuevos inicializadores a tipos
  existentes. 
- Esto nos permite extender otros tipos para aceptar nuestros propios
  tipos como parámetros de la inicialización, o para proporcionar
  opciones adicionales que no estaban incluidos en la implementación
  original del tipo.

Ejemplo:

```swift
struct Tamaño {
    var ancho = 0.0, alto = 0.0
}
struct Punto {
    var x = 0.0, y = 0.0
}
struct Rectangulo {
    var origen = Punto()
    var tamaño = Tamaño()
}
```

- Debido a que la estructura `Rectangulo` proporciona valores por
  defecto para todas sus propiedades, tiene un inicializador por
  defecto que puede utilizarse para crear nuevas instancias.
- También podemos inicializarlo asignando todas sus propieades:

```swift
let rectanguloPorDefecto = Rectangulo()
let rectanguloInicializado = Rectangulo(origen: Punto(x: 2.0, y: 2.0),
                                tamaño: Tamaño(ancho: 5.0, alto: 5.0))
```

- Podemos extender la estructura `Rectangulo` para proporcionar un
  inicializador adicional que toma un punto específico del centro y un
  tamaño:

```swift
extension Rectangulo {
    init(centro: Punto, tamaño: Tamaño) {
        let origenX = centro.x - (tamaño.ancho / 2)
        let origenY = centro.y - (tamaño.alto / 2)
        self.init(origen: Punto(x: origenX, y: origenY), tamaño: tamaño)
    }
 }
```

- Ahora podemos inicializar un rectángulo a partir de su punto central
y de un tamaño:

```swift
 let rectanguloCentro = Rectangulo(centro: Punto(x: 4.0, y: 4.0),
                           tamaño: Tamaño(ancho: 3.0, alto: 3.0))
 // el origen del rectanguloCentro es is (2.5, 2.5) y su tamaño es (3.0, 3.0)
```

---

### Métodos

- Las extensiones pueden añadir también nuevos métodos de instancia y
nuevos métodos del tipo. 

- Por ejemplo, podemos añadir el método `descripcion()` a la
  estructura `Persona`:

```swift
extension Persona {
    func descripcion() -> String {
        return "Me llamo \(nombreCompleto) y tengo \(edad) años"
    }
}

let reedRichards = Persona(edad: 40, nombreCompleto: "Reed Richards")
print(reedRichards.descripcion())
```

Ejemplo, en el que se añade un nuevo método de instancia llamado
`repeticiones` al tipo `Int`:

```swift
extension Int {
    func repeticiones(_ tarea: () -> Void) {
        for _ in 0..<self {
            tarea()
        }
    }
}
```

- El método `repeticiones(_:)` toma un único argumento de tipo `() ->
  Void` (una función que no tiene parámetros y no devuelve ningún
  valor)
- Ahora podemos llamar al método `repeticiones(_:)` en cualquier
  número entero para ejecutar una tarea un cierto número de veces:


```swift
3.repeticiones({
   print("Hola!")
})
// Hola!
// Hola!
// Hola!
```

- Usando clausuras por la cola podemos hacer la llamada más concisa:

```swift
3.repeticiones {
   print("Adios!")
}
// Adios!
// Adios!
// Adios!
```

- Otro ejemplo, para extender el tipo estándar `String`.

- En Swift es algo complicado devolver el carácter situado
en una posición de una cadena porque el índice que se utiliza para el
acceso a la posición no es de tipo `Int`, sino un valor del tipo
`String.Index`:

```swift
let cadena = "Hola"
let posicion = 2
let index = cadena.index(cadena.startIndex, offsetBy: posicion)
cadena[index] // Devuelve "l"
```

- Para simplificar el acceso a una posición de un `String` podemos
definir una extensión que añada esa funcionalidad a la estructura:

```swift
extension String {
    func at(_ pos: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: pos)
        return self[index]
    }
}
```

- Incluso Swift permite definir un método con la palabra clave
`subscript` para después usar la notación típica de corchetes para
acceder a un componente:

```swift
extension String {
    subscript (pos: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: pos)
        return self[index]
    }
}
"Hola"[3] // devuelve "a"
```



## Tema 6: Programación Funcional con Swift (semana 2)

### Contenidos

- 1. Introducción
- 2. Inmutabilidad
- 3. Funciones
- 4. Recursión
- 5. Tipos función
- 6. Tipos
- 7. Enumeraciones
- 8. Enumeraciones instanciables
- **9. Opcionales**
- **10. Clausuras**
- **11. Funciones de orden superior**
- **12. Genéricos**

----

### Bibliografía

- [Seminario de Swift](https://domingogallardo.github.io/apuntes-lpp/seminarios/seminario2-swift/seminario2-swift.html)
- [Biblioteca estándar de Swift](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/)
- Swift Language Guide
    - [The Basics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)
    - [Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)
    - [Generics](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)


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

---
### Clausuras
---

- Veremos dos puntos principales:
   - Se puede definir funciones que se pasan como parámetro de forma
     compacta usando _expresiones de clausuras_.
   - Las clausuras capturan las variables definidas en el ámbito de la
     función principal que las crea.

---

### Expresiones de clausura ###


- Swift permite definir expresiones compactas con las que construir
  funciones anónimas que se pasan como parámetro de otras funciones. 
- Similares a las **_expresiones lambda_** en Scheme. En Swift se
  denominan **_expresiones de clausura_** (_closure expressions_).

---

### El método `sorted(by:)`

- La biblioteca stándar de Swift define un método `sorted()` que
  devuelve los elementos ordenados de un
  [Array](https://developer.apple.com/reference/swift/array). 
- El array original no se modifica. 
- La comparación entre los elementos se realiza usando el comparador
  `<`.
- El array original no se modifica, sino que la ordenación construye
un nuevo array (existe una función alternativa mutable que se denomina
`sort()`).

```
let estudiantes = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
let ordenados = estudiantes.sorted()
print(ordenados)
// Imprime "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"
```

- Lo interesante relacionado con las clausuras está en la función
  `sorted(by:)`. 
- En esta función se utiliza una clausura como parámetro para
  modificar la comparación entre elementos y resultar en una
  ordenación distinta. 

```
func sorted(by areInIncreasingOrder: (Element, Element) -> Bool)
```

- Por ejemplo, podríamos ordenar un array de cadenas en orden
  alfabético inverso.

```swift
func primeroMayor(s1: String, s2: String) -> Bool {
    return s1 > s2
}
let alreves = estudiantes.sorted(by: primeroMayor)
print(alreves)
// Imprime ["Peter", "Kweku", "Kofi", "Akosua", "Abena"]
```

- Sería mucho más expresivo definir la función de ordenación _inline_,
  sin necesidad de crear una función auxiliar como `primeroMayor`.
- Se puede hacer usando una expresión de clausura.

---

### Sintaxis de las expresiones de clausura

- La sintaxis de las expresiones de clausura tiene la siguiente forma
general:

```text
{ ( <parametros>) -> <tipo devuelto> in
   <sentencias>
}
```

- Si aplicamos esta sintaxis al ejemplo anterior:

```swift
let alreves = estudiantes.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

- Hay que hacer notar que la declaración de los parámetros y el tipo
  devuelto por esta clausura _inline_ es idéntica a la declaración de
  la función `primeroMayor(s1:s2:)`. En ambos casos, se escribe como
  `(s1: String, s2: String) -> Bool`. Sin embargo, en la expresión de
  clausura los parámetros y el tipo devuelto se escribe dentro de las
  llaves, no fuera.
- El comienzo del cuerpo de la clausura se introduce por la palabra
  clave `in`. 
- Como el cuerpo de la clausura es corto, podemos incluso escribirlo
  en una única línea:

```swift
let alreves = estudiantes.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
```

- Veamos ahora que es posible aplicar bastantes simplificaciones y
  hacer mucho más compacta la expresión de clausura.
  
---

### Inferencia del tipo por el contexto

- Swift puede inferir los tipos de sus parámetros y el tipo del valor
  que devuelve a partir de la declaración del argumento de la función
  `sorted(by:)`.
- Debido a que todos los tipos pueden ser inferidos, la flecha del
  tipo devuelto y los paréntesis alrededor de los nombres de los
  parámetros también pueden omitirse:

```swift
let alreves = estudiantes.sorted(by: { s1, s2 in return s1 > s2 } )
```

---

### Devoluciones implícitas en clausuras con una única expresión

- En clausuras con una única expresión podemos omitir también la
  palabra clave `return`:

```swift
let alreves = estudiantes.sorted(by: { s1, s2 in s1 > s2 } )
```

---

### Abreviaturas en los nombres de los argumentos

- Swift proporciona automáticamente abreviaturas para los nombres de
  argumentos de las clausuras _inline_ que pueden usarse para
  referirse a los valores de los argumentos de la clausura usando los
  nombres `$0`, `$1`, `$2`, etc.
- Si se usa estos argumentos abreviados, se puede omitir la definición
  de la lista de los argumentos:

```swift
let alreves = estudiantes.sorted(by: { $0 > $1 } )
```

---

### Funciones operadoras

- Swift define una implementación específica de cadenas del operador
  mayor-que (`>`) como una función que tiene dos parámetros de tipo
  `String` y devuelve un `Bool`. 
- Esto es exactamente lo que necesita el método `sorted(by:)`. 

```swift
let alreves = estudiantes.sorted(by: >)
```
---

### Clausuras al final

- Si la clausura se pasa como último argumento, se puede escribir como
  una clausura al final (_trailing closure_). 
- Una clausura al final es una expresión de clausura que se escribe
  fuera de (y después de) los paréntesis de la función a la que se le
  pasa como parámetro.
- No es necesario el nombre del parámetro.

```swift
let alreves = estudiantes.sorted() { $0 > $1 }
```

- Cuando se proporciona una expresión de clausura como único argumento
  de una función o método y se pasa como una clausura al final, no es
  necesario escribir los paréntesis tras el nombre de la función.

```swift
let alreves = estudiantes.sorted { $0 > $1 }
```

- Las clausuras al final son útiles sobre todo cuando la clausura es
  suficientemente larga que no es posible escribirla _inline_ en una
  única línea. 

---

### Valores capturados

- Igual que en Scheme, una clausura puede capturar constantes y
  variables del contexto en el que se define.
- La clausura puede referirse y modificar esos valores dentro de su
  cuerpo, incluso si ya no existe el ámbito (_scope_) original en el
  que se definieron estas constantes y variables.
- En Swift, la forma más sencilla de una clausura que captura valores
  es una función anidada (_nested function_) escrita en el cuerpo de
  otra función. Una función anidada puede capturar cualquiera de los
  argumentos de su función exterior y también puede capturar cualquier
  constante y variable definida dentro de la función exterior.

- Veamos un ejemplo similar al que vimos en Scheme. 

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

- La función `construyeIncrementador` contiene una función anidada
  llamada `incrementador`. Esta función captura dos valores de su
  contexto: `totalAcumulado` y `cantidad`. 
- Después de capturar estos valores, `incrementador` es devuelto por
  `construyeIncrementador` como una clausura que incrementa
  `totalAcumulado` en `cantidad` cada vez que se llama.
- El tipo devuelto de `construyeIncrementador` es `() -> Int`. Esto
  significa que devuelve una función que no tiene parámetros y que
  devuelve un `Int` cada vez que es llamada.

```swift
func incrementador() -> Int {
    totalAcumulado += cantidad
    return totalAcumulado
}
```

- Si consideramos aislada la función anidada `incrementador()`, vemos
  que función no tiene ningún parámetro, y que utiliza en su cuerpo
  las variables `totalAcumulado` y `cantidad` en su cuerpo.
- Lo puede hacer porque ha capturado una referencia a estas variables
  de la función de alrededor. Al capturar estas referencias las
  variables no desaparecen cuando termina la llamada a
  `construyeIncrementador`; estarán disponibles la próxima vez que se
  llame la función `incrementador`.


Ejemplo:

```swift
let incrementaDiez = construyeIncrementador(incremento: 10)
incrementaDiez()
// devuelve 10
incrementaDiez()
// devuelve 20
incrementaDiez()
// devuelve 30
```

- Si creamos un segundo incrementador, tendrá sus propias referencias
  a un variable `totalAcumulado` nueva, distinta de la anterior:


```swift
let incrementaSiete = construyeIncrementador(incremento: 7)
incrementaSiete()
// devuelve 7
```

- Si llamamos a la función `incrementador` original (`incrementaDiez`)
  vemos que sigue incrementando su propia variable `totalAcumulado` y
  que no se ve afectada por la variable capturada por
  `incrementaSiete`:

```swift
incrementaDiez()
// devuelve 40
```

---

### Mutación de variables capturadas ###

- Las clausuras también pueden modificar el valor de las variables capturadas.

```swift

var x = 1

func construyeFunc() -> (Int) -> Int {
    var x = 10

    func prueba(_ a: Int) -> Int {
        x = a + x
        return x
    }
    return prueba
}

let f = construyeFunc()
print(f(10)) // Imprime 20
print(f(10)) // Imprime 30
let g = construyeFunc()
print(g(10)) // Imprime 20
print(x) // Imprime 1
```

- La clausura `prueba` **captura la variable `x` definida en el ámbito
  de `construyeFunc`** y la utiliza en su cuerpo.
- La variable capturada queda ligada a la clausura y es utilizada cada
  vez que la clausura se invoca.
- En la primera invocación a la clausura se pasa como parámetro `a` el
  valor 10, que se suma a la variable capturada. De esta forma la
  variable capturada pasa a valer 20.
- En la segunda invocación a la clausura el valor de `x` será 20, por
  lo que devolverá 30.
- La segunda vez que llamamos a `construyeFunc` se crea un nuevo
  ámbito local con una nueva variable `x` que se inicializa
  a 10. Esa nueva variable es el que captura la nueva clausura que se
  devuelve. Por eso al invocarla (en la llamada `g(10)`) se devuelve 20.


---

### Las clausuras son tipos de referencia

- Siempre que asignamos una función o una clausura a una constante o
  una variable, estamos realmente estableciendo que la constante o
  variable es una referencia a la función o la clausura. 
- Si asignamos una clausura a dos constantes o variables distintas,
  ambas constantes o variables se referirán a la misma clausura:

```swift
let tambienIncrementaDiez = incrementaDiez
tambienIncrementaDiez()
// devuelve 50
```


---
### Funciones de orden superior
---


- Una de las características funcionales que más hemos usado para
  trabajar con listas en Scheme son las funciones de orden superior
  como `map`, `filter` o `fold-right`. 
- Swift tiene definidas funciones equivalentes para trabajar con
  colecciones. 
- Se denominan `map`, `filter` y `reduce`. Todas ellas aceptan
  expresiones de clausura como argumento.

---

### Map

- El método `map` se define en el protocolo
  [`CollectionType`](https://developer.apple.com/library/ios/documentation/Swift/Reference/Swift_CollectionType_Protocol/index.html#//apple_ref/swift/intfm/CollectionType/s:FEsPs14CollectionType3mapurFzFzWx9Generator7Element_qd__GSaqd___)
  y es adoptado por múltiples estructuras como `Array`, `Dictionary`,
  `Set` o `String.CharacterView`.
- Recibe como parámetro una función unaria `transform` del tipo de los
  elementos de la colección y que devuelve otro elemento (puede ser
  del mismo o de distinto tipo que los elementos de la
  colección). 
- Devuelve un array que contiene el resultado de aplicar `transform` a
  cada elemento del array original.

Ejemplo:

```swift
let numeros = [Int](0...5)
numeros.map {$0 * $0}
// devuelve [0, 1, 4, 9, 16, 25]
```

- Estamos usando la notación de _clausura al final_.

- Otro ejemplo, en el que usamos `map` para implementar la función
  `sumaParejas(parejas: [(Int, Int)]) -> [Int]`:

```swift
func suma(parejas: [(Int, Int)]) -> [Int] {
   return parejas.map({(pareja: (Int, Int)) -> Int in
                        return pareja.0 + pareja.1})
}
suma(parejas:[(1, 1), (2, 2), (3, 3), (4, 4)])
// devuelve [2, 4, 6, 8]
```

- Podemos usar en el cuerpo de la expresión de clausura de `map` una
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
- La versión abreviada de la expresión de clausura es:

```swift
func incrementa(valores: [Int], con: Int) -> [Int] {
   return valores.map {$0 + con}
}
incrementa(valores: [10, 20, 30], con: 5)
// devuelve [15, 25, 35]
```

---

### Filter

- La función `filter` recibe una clausura de un argumento que devuelve
  un booleano.
- La función devuelve una colección con los elementos de la colección
  para los que la clausura devuelve _true_.
  
Ejemplo:

```swift
let numeros = [Int](0...10)
numeros.filter {$0 % 2 == 0}
// devuelve [0, 2, 4, 6, 8, 10]
```

---

### Reduce 

- Similar al _fold_ de Scheme:

```swift
let numeros = [Int](0...10)
numeros.reduce(0, +)
```

- La clausura que se pasa combina los elementos de la colección. 
- Recibe dos parámetros: el primero es el resultado de la combinación
  y el segundo se coge de la colección. 
  
Ejemplo:


```swift
let cadenas = ["Patatas", "Arroz", "Huevos"]
cadenas.reduce(0, {(i: Int, c: String) -> Int in c.count + i })
// devuelve 18
```

- En versión más compacta:

```swift
cadenas.reduce(0, {$1.count + $0})
```

- También se puede utilizar la notación de clausura al final:

```swift
cadenas.reduce(0) {$1.count + $0}
```

- La combinación se hace de izquierda a derecha:

```swift
let cadenas = ["Patatas", "Arroz", "Huevos"]
cadenas.reduce("", +)
// devuelve "PatatasArrozHuevos"
```

---
### Genéricos
---

### Ejemplo inicial: función `intercambia` (no genérica)

- Empecemos con un ejemplo sencillo. 
- Supongamos la siguiente función `intercambia(_:)` que recibe una
  tupla `(Int, String)` y devuelve una tupla `(String, Int)` con los
  valores intercambiados.

```swift
func intercambia(_ tupla: (Int, String)) -> (String, Int) {
   let tuplaNueva = (tupla.1, tupla.0)
   return tuplaNueva
}

let tupla = (10, "Hola")
intercambia(tupla)
// devuelve ("Hola", 10)
```

- Supongamos que queremos hacer la misma función para intercambiar
  elementos de una tupla `(Int, Int)`. Tendríamos que usar el mismo
  código, pero cambiando los tipos:

```swift
func intercambia(_ tupla: (Int, Int)) -> (Int, Int) {
   let tuplaNueva = (tupla.1, tupla.0)
   return tuplaNueva
}

let tupla2 = (10, 20)
intercambia(tupla2)
// devuelve (20, 10)
```

- El código es el mismo, lo único distinto son los tipos. 
- ¿Podríamos **generalizar** las funciones anteriores para hacer que
  el código pueda trabajar con cualquier tipo? 
  
---

### Función `intercambia` genérica
  
- La respuesta es sí, usando **función genérica**:

```swift
func intercambia<A,B>(_ tupla: (A, B)) -> (B, A) {
   let tuplaNueva = (tupla.1, tupla.0)
   return tuplaNueva
}
```

- La sintaxis es similar a Java.
- En la versión genérica se usan *placeholders* (los símbolos `A` y
  `B`) en lugar de tipos concretos. Son tipos genéricos, que se
  definen usando un identificador entre símbolos de `<` y `>`. 
- Los tipos reales que se van a usar en la función se determinan en
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

- En el primer ejemplo, los tipos `A` y `B` se infieren como `Int` y
  `String`. En el segundo ejemplo como `Int` e `Int`. Y en el tercero
  como `Bool` y `Double`.

- Los tipos genéricos se pueden usar en la definición de todos los
  elementos de Swift: funciones, enums, estructuras, clases,
  protocolos o extensiones. 

--- 

### Ejemplo final: lista genérica

- Terminamos con un ejemplo en el que incluimos muchos conceptos
  vistos en este tema. 
- Se trata de la implementación en Swift de listas al estilo Scheme,
  con las funciones `car`, `cdr` y `vacia` usando un enum recursivo
  con un tipo genérico que permite generalizar el tipo de elementos de
  la lista.

```swift
indirect enum Lista<T> {
     case vacia
     case cons(T, Lista<T>)
}

func car<T>(_ lista: Lista<T>) -> T? {
   switch lista {
      case let .cons(primero, _):
         return primero
      case .vacia:
         return nil
   }
}

func cdr<T>(_ lista: Lista<T>) -> Lista<T>? {
   switch lista {
      case let .cons(_, resto):
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

let lista : Lista = .cons(20, .cons(30, .cons(40, .vacia)))

print(car(lista)!) // Imprime 20
print(car(cdr(lista)!)!) // Imprime 30
print(car(cdr(cdr(lista)!)!)!) // Imprime 40
print(vacia(cdr(cdr(cdr(lista)!)!)!)) // Imprime true
```

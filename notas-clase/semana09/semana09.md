
## Tema 6: Programación Funcional con Swift

### Contenidos

- Introducción
- Funciones
- Tipos función
- Recursión
- Tipos
- **Opcionales**
- **Inmutabilidad**
- **Clausuras**
- **Funciones de orden superior**
- **Genéricos**

----

### Bibliografía

- [Seminario de Swift](https://domingogallardo.github.io/apuntes-lpp/seminarios/seminario2-swift/seminario2-swift.html)
- [Biblioteca estándar de Swift](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/)
- Swift Language Guide
    - [The Basics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)
    - [Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)
    - [Generics](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)


----
### Repaso de opcionales
----

Un tipo opcional permite asignar `nil`:

```swift
var intOpcional: Int? = 10
intOpcional = nil
```

Un opcional no se puede usar como el tipo original, hay que
desenvolverlo (_unwrap_):

```swift
// error let x = intOpcional + 20
let x = intOpcional! + 20
```

Antes de desenvolver un opcional siempre hay que comprobar si el valor
que contiene no es `nil`:

```swift
if (intOpcional != nil) {
   print(intOpcional! + 20)
}
else {
   // intOpcional es nil
}
```

Una forma más sencilla de hacer lo anterior es el llamado _ligado
opcional_ (_optional binding_) la construcción `if
let`:

```swift
if let x = intOpcional {
   print(x + 20)
}
else {
   // intOpcional es nil
}

```

### Operador _nil-coalescing_ ###

El operador _nil-coalescing_ (`??`) permite asignar un valor por defecto si
un opcional es nil:

```swift
let a: Int? = nil
let b: Int? = 10
let x = a ?? -1
let y = b ?? -1
print("Resultado: \(x), \(y)")
// Imprime Resultado: -1, 10
```

### Encadenamiento de opcionales ###

El encadenamiento de opcionales (_optional chaining_) permite llamar a
un método de una variable que contiene un opcional. Si la variable no
es `nil`, se ejecuta el método y se devuelve su valor. Si la variable
es `nil` se devuelve `nil`.

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

----
### Inmutabilidad
---

Una de las características funcionales importantes de Swift es el
énfasis en la inmutabilidad para reforzar la seguridad del
lenguaje. Veamos algunas características relacionadas con esto.

---

### Palabra clave let

- La palabra clave `let` permite definir constantes. Si se intenta
  modificar el valor el compilador da un error.
- El valor asignado puede no conocerse en tiempo de compilación:

```swift
let maximoNumeroDeIntentosDeLogin = 10
let respuesta: String = respuestaUsuario.respuesta()
```

- Si una variable no se modifica es conveniente declararla como
  `let`. El compilador de Swift da una aviso para ello.

---

### Semántica de copia en estructuras

- Una forma de evitar los efectos laterales es definir una semántica
  de copia en la asignación.
- En Swift la semántica de una asignación depende del tipo de objeto.
- Las estructuras (_structs_) tienen **semántica de copia**. Veremos
  más adelante que las clases tienen una **semántica de referencia**.
- La mayor parte de tipos definidos el la
[biblioteca estándar de Swift](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html#//apple_ref/doc/uid/TP40014608)
son estructuras. Tipos como `Int`, `Double`, `Bool`, `String`,
`Array`, `Dictionary`, etc. son todos ellos estructuras y, por tanto,
tienen semántica de copia.

```swift
var str1 = "Hola"
var str2 = str1
str1.append("Adios")
print(str1) // Imprime "HolaAdios"
print(str2) // Imprime "Hola"
```

- Los arrays también son estructuras y, por tanto, también tienen
  semántica de copia:

```swift
var array1 = [1, 2, 3, 4]
var array2 = array1
array1[0] = 10
print(array1) // [10, 2, 3, 4]
print(array2) // [1, 2, 3, 4]
```

- A diferencia de otros lenguajes como Java, los parámetros de una
  función siempre son inmutables y se pasan por copia. Por ejemplo, el
  siguiente código sería un error:

```
func concat(_ str1: String, con str2: String) -> String {
  // str1.append(str2) -> error
  return str1
}
```

---

### Estructuras mutables y `let`

- Si definimos un valor de una estructura con un `let` ese valor será
  inmutable y no podrá modificarse, a pesar de que el `Struct` tenga
  métodos que mutan sus valores.
- Por ejemplo, hemos visto que el método `append(_:)` de un `String`
  modifica la propia cadena. Si definimos una cadena con `let` no
  podremos modificarla:

```swift
var cadenaMutable = "Hola"
let cadenaInmutable = "Adios"
cadenaMutable.append(cadenaInmutable) // cadenaMutable es "HolaAdios"
// cadenaInmutable.append("Adios")
// La sentencia anterior genera un error:
// "cannot use mutating member on immutable value: 'cadenaInmutable' is a 'let' constant"
```

---

### Tipos valor y tipos referencia

- Un **tipo valor** es un tipo que tiene semántica de copia en las
  asignaciones y cuando se pasan como parámetro en llamadas a
  funciones.
- Un **tipo de referencia** es aquel en los que los valores se asignan
  a variables con una semántica de referencia. Cuando se realizan
  varias asignaciones de una misma instancia a distintas variables
  todas ellas guardan una referencia a la misma instancia.
- En Java los tipos simples (`int`, `double`, etc.) son tipos valor y
  las clases son tipos de referencia.
- En Swift las estructuras son tipos valor y las clases tipos de
  referencia. Comentaremos más diferencias en el tema de programación
  orientada a objetos.
- Los tipos valor son muy útiles porque evitan los efectos laterales
  en los programas y simplifican el comportamiento del compilador en
  la gestión de memoria. 


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

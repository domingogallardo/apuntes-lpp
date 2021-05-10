
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
### 9. Opcionales
----

### Swift es un lenguaje seguro ###

- En Swift el valor nulo se representa con `nil` (equivalente a `null`
  en Java). 
- El concepto de _null_ es un concepto peligroso, como lo saben bien los
desarrolladores Java. En Java, si intentamos usar una variable que
contiene _null_ se produce la típica excepción _null pointer
exception_ y la aplicación se rompe. 
- En Swift, para evitar estos problemas, No podemos asignar `nil` a
  una variable de un tipo dado:

```swift
// La siguiente línea daría un error en tiempo de compilación
// let cadena: String = nil
```
- Si queremos utilizar `nil` debemos declarar la variable usando lo que
se denomina **tipo opcional**:

```swift
var cadena: String? = "Hola"
cadena = nil
```

---

### ¿Cuándo usar opcionales? ###

- El uso de opcionales es necesario en situaciones en las que podemos
obtener un valor desconocido. 

- Por ejemplo, en estructuras de datos en las que hacemos búsquedas
que pueden no devolver ningún valor, como en un diccionario:

```swift
var edades = [
    "Raquel": 30,
    "Pedro": 22,
]
let edad1 = edades["Raquel"]
let edad2 = edades["Ana"] // devuelve nil
```
- La variable `edad2` será de tipo `Int?` (`Int` opcional) y contendrá
un `nil`.

---

### Cómo usar valores opcionales ###

- Un valor opcional no puede ser usado directamente. Primero debemos
comprobar si el valor es distinto de `nil` y sólo después podremos
usarlo.

- Por ejemplo, el siguiente código produce un error de compilación
porque intentamos usar un opcional sin desenvolverlo:

```swift
var x: Int? = 10
let y = x + 10 
// error: value of optional type 'Int?' must be unwrapped to a value of type 'Int'
```

- Swift _esconde_ o _envuelve_ (_wrap_) el valor real del opcional y
obliga a llamar al operador `!` para _desenvolverlo_ (_unwrap_) y
usarlo. Este operador se denomina de **desenvoltura forzosa** (_forced
unwrapping_).

```swift
var x: Int? = 10
let y = x! + 10 
print(y)
// Imprime "20"
```

---

### Funciones que devuelven un opcional ###

- Podemos definir como opcional variables, parámetros
o valores devueltos por funciones de cualquier tipo, añadiéndoles la
interrogación al final.

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

---

### Inicialización de opcional ###

- Una variable opcional sin asignar ningún valor se inicializa
automáticamente a `nil`:

```swift
var respuestaEncuesta: String?
// respuestaEncuesta es inicializado automáticamente a nil
```

---

### Error fatal al desenvolver un nil ###

- Si se aplica el operador `!` a un valor `nil` se produce un error en
tiempo de ejecución y la aplicación se rompe:

```swift
var respuestaEncuesta: String?
print(respuestaEncuesta!)
// Fatal error: Unexpectedly found nil while unwrapping an Optional value
```

----

### Ligado opcional

- Para comprobar si un valor opcional es `nil` podemos usar un
`if`. Es obligado hacerlo si desconocemos el valor que nos llega. Por
ejemplo, supongamos que la función `leerRespuesta()` lee una respuesta
del usuario y devuelve un `String?`. Para usar esta función deberíamos
comprobar si el valor devuelto es distinto de `nil`:

```swift
let respuestaEncuesta = leerRespuesta()
if respuestaEncuesta != nil {
    let respuesta = respuestaEncuesta!
    print("Respuesta: " + respuesta)
}
```

- Como es muy habitual hacer lo anterior, en Swift es posible comprobar
si un opcional tiene valor y asignar su valor a otra variable al mismo
tiempo con una construcción llamada _ligado opcional_ (_optional
binding_):

```swift
let respuestaEncuesta = leerRespuesta()
if let respuesta = respuestaEncuesta {
    print ("Respuesta: " + respuesta)
}
```

---

### Ejemplo de `sumaValores` con opcional ###

- Otro ejemplo, el método `first` de un array devuelve un opcional que
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

---

### If let con múltiples variables ###

- Si tenemos varios opcionales es posible comprobar que todos ellos son
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

----

### Operador _nil-coalescing_ ###

- El operador _nil-coalescing_ (`??`) permite definir un valor por
defecto en una asignación si un opcional es nil.

```swift
let a: Int? = nil
let b: Int? = 10
let x = a ?? -1
let y = b ?? -1
print("Resultado: \(x), \(y)")
// Imprime Resultado: -1, 10
```

---

### Encadenamiento de opcionales ###

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

---

### Ejemplo de `Lista` con opcional

- Veamos como último ejemplo una segunda versión del enum `Lista`, en el que
utilizamos un único `case`, pero dando la posibilidad de que el resto
de la lista sea `nil` haciéndolo opcional.

```swift
indirect enum Lista{
	case nodo(Int, Lista?)
}
```

- La función `suma(lista:)` quedaría así:

```
func suma(lista: Lista) -> Int {
	switch lista {
		case let .nodo(car, cdr):
		if (cdr == nil) {
			return car
		} else {
			return car + suma(lista: cdr!)
		}
	}
}

let z: Lista = .nodo(20, .nodo(10, nil))
print(suma(lista: z))
/// Devuelve 30
```

---
### 10. Clausuras
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

### Variables capturadas

!!! Note "Cuidado"
    Los ejemplos que vamos a ver a continuación no usan programación
    funcional, porque la variable capturada por la clausura es una
    variable **mutable** (se ha definido con `var` y no con `let`). Por
    eso las funciones resultantes no son funciones puras, sino que
    devuelven un valor distinto cada vez que son invocadas. Son 
    funciones con estado local mutable.

- Igual que en Scheme, una clausura puede capturar constantes y
  variables del contexto en el que se define.
- La clausura puede referirse y modificar esos valores dentro de su
  cuerpo, incluso si ya no existe el ámbito (_scope_) original en el
  que se definieron estas constantes y variables.
- En Swift, la forma más sencilla de una clausura que captura variables
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
  llamada `incrementador`. Esta función captura dos variables de su
  contexto: `totalAcumulado` y `cantidad`. 
- Después de capturar estas variables `incrementador` es devuelto por
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

### Clausuras con expresiones de clausura ###

- En el ejemplo anterior hemos usado una definición interna de una
función para definir la clausura que se devuelve. Lo hemos hecho por
claridad, pero no es necesario. Es posible escribir un código más
compacto usando expresiones de clausura.

- Por ejemplo, la función que vimos la semana pasada `construyeSumador()` 

```swift
func construyeSumador10() -> (Int) -> Int {
  func suma10(x: Int) -> Int {return x+10}
  return suma10
}
```

- Una versión de esta misma función usando una expresión de clausura es
la siguiente:

```swift
func construyeSumador10() -> (Int) -> Int {
    return {$0 + 10}
}

var f = construyeSumador10()
print(f(20))
// Imprime "30"
```

Y lo mismo con la función `constryeIncrementador(incremento:)`:

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

---

### Variables capturadas por clausuras y variables del ámbito de invocación ###

- Las clasuras usan los valores capturados y no los valores declarados
en el ámbito en el que se invoca a la clausura. Vamos a explicarlo con un ejemplo.

```swift
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
```

- La función `usaFunc` definida en la línea 13 recibe una función `f`
sin parámetros que devuelve un entero. En el ámbito local de `usaFunc`
se define una variable local `x` que tiene el valor `10` antes de
invocar a la función `f` recibida.

- La función recibida ha capturado una variable que también se llama
`x`. Esta es la variable que va a usar el código de la clausura y no
la otra `x`. 

- Si ejecutamos el código veremos que la expresión devuelve 3. O sea
que las clausuras usan siempre las variables capturadas.

- Podemos comprobarlo también en el siguiente ejemplo, en el que la
clausura que se pasa es una expresión de clausura que captura la
variable `x` definida en la línea anterior. Por eso cuando se ejecuta
la sentencia se imprime el valor `110` y no el valor `20`.

```swift
var x = 100
print(usaFunc {return x + 10}) // -> 110
```

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
### 11. Funciones de orden superior
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
  y es adoptado por múltiples estructuras como `Array`, `Dictionary` o
  `Set`.

- El perfil del método `map` es el siguiente:

```swift
func map<T>(_ transform: (Element) -> T) -> [T]
```

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

- La función es igual que la de Scheme: devuelve una colección con los
  elementos de la colección para los que la clausura que se pasa
  devuelve _true_.

- Su perfil:

```swift
func filter(_ isIncluded: (Element) -> Bool) -> [Element]
```

- Ejemplo:

```swift
let numeros = [Int](0...10)
numeros.filter {$0 % 2 == 0}
// devuelve [0, 2, 4, 6, 8, 10]
```

---

### Reduce 

- Similar al _fold_ de Scheme.

- Su perfil:

```swift
func reduce<Result>(_ initialResult: Result, 
                    _ nextPartialResult: (Result, Element) -> Result) -> Result
```

- La función que se le pasa `nextPartialResult` es la función de
  plegado que combina los elementos de la colección. Recibe dos
  parámetros: el primero es el resultado de la combinación y el
  segundo se coge de la colección.

- Ejemplo:

```swift
let numeros = [Int](0...10)
numeros.reduce(0, +)
```

- Otro ejemplo:

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

### Combinación de funciones de orden superior

- Cuando el resultado de aplicar una función de orden superior a una
colección es otra colección es posible aplicar otra función de
orden superior a este resultado.

- Por ejemplo, la siguiente sentencia devuelve todos los números pares
del array inicial elevados al cuadrado:


```swift
let numeros = [1,2,3,4,5,6,7,8,9,10]
numeros.filter{$0 % 2 == 0}.map{$0*$0}
// Devuelve el array [4,16,36,64,100]
```

- Y la siguiente devuelve la suma números mayores de 100:

```swift
let numeros = [103, 2, 330, 42, 532, 6, 125]
numeros.filter{$0 >= 100}.reduce(0,+)
// Devuelve 1090
```

---
### 12. Genéricos
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
     case nodo(T, Lista<T>)
}

func car<T>(_ lista: Lista<T>) -> T? {
   switch lista {
      case let .nodo(primero, _):
         return primero
      case .vacia:
         return nil
   }
}

func cdr<T>(_ lista: Lista<T>) -> Lista<T>? {
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

print(car(lista)!) // Imprime 20
print(car(cdr(lista)!)!) // Imprime 30
print(car(cdr(cdr(lista)!)!)!) // Imprime 40
print(vacia(cdr(cdr(cdr(lista)!)!)!)) // Imprime true
```

# Práctica 9: Programación funcional en Swift (1)

## Antes de la clase de prácticas

- Los siguientes ejercicios están basados en los conceptos de teoría
vistos la semana pasada. Antes de la clase de prácticas debes repasar
todos los conceptos y **probar en con el compilador de Swift** todos
los ejemplos de los siguientes apartados del tema 5 [_Programación
funcional con Swift_](../../teoria/tema05-programacion-funcional-swift/tema05-programacion-funcional-swift.html#9-opcionales)

- Opcionales
- Clausuras
- Funciones de orden superior
- Genéricos

## Ejercicios

### Ejercicio 1 ###

a) Define la función `maxOpt(_ x: Int?, _ y: Int?) -> Int?` que
devuelve el máximo de dos enteros opcionales. En el caso en que ambos
sean `nil` se devolverá `nil`. En el caso en que uno sea `nil` y el
otro no se devolverá el entero que no es `nil`. En el caso en que
ningún parámetro sea `nil` se devolverá el mayor.

Ejemplo:

```swift
let res1 = maxOpt(nil, nil) 
let res2 = maxOpt(10, nil)
let res3 = maxOpt(-10, 30)
print("res1 = \(String(describing: res1))")
print("res2 = \(String(describing: res2))")
print("res3 = \(String(describing: res3))")
// Imprime:
// res1 = nil
// res2 = Optional(10)
// res3 = Optional(30)

```

b1) Escribe una nueva versión del ejercicio 1b) de la práctica 9 que
permita recibir números negativos y que devuelva una pareja de `(Int?,
Int?)` con `nil` en la parte izquierda y/o derecha si no hay número
impares o pares.

Ejemplo:

```swift
let numeros = [-10, 202, 12, 100, 204, 2]
print("\n******\n1b1) Función parejaMayorParImpar2(numeros:)\n******")
print(parejaMayorParImpar2(numeros: numeros))
// Imprime:
// parejaMayorParImpar2(numeros: [-10, 202, 12, 100, 204, 2])
// (nil, Optional(204))
```

b2) Escribe la función `sumaMaxParesImpares(numeros: [Int]) -> Int`
que llama a la función anterior y devuelve la suma del máximo de los
pares y el máximo de los impares. En el caso en que se pase un array
vacío deberá devolver un 0.

```swift
print("sumaMaxParesImpares(numeros: \(numeros2))")
print(sumaMaxParesImpares(numeros: numeros2))
// Imprime:
// sumaMaxParesImpares(numeros: [-10, 202, 12, 100, 204, 2])
// 204
```

b3) Escribe una nueva versión de la función del ejercicio b1) en la que se devuelva
`nil` en el caso en que se le pase como parámetro un array
vacío. ¿Cómo se debería cambiar la declaración de la función? Escribe
también una nueva versión de la función del ejercicio b2) en la que se
llame a la función anterior.

### Ejercicio 2 ###

a) Indica qué devuelven las siguientes expresiones:

a.1)
```swift
let nums = [1,2,3,4,5,6,7,8,9,10]
nums.filter{$0 % 3 == 0}.count
```

a.2)
```swift
let nums2 = [1,2,3,4,5,6,7,8,9,10]
nums2.map{$0+100}.filter{$0 % 5 == 0}.reduce(0,+)
```

a.3)
```swift
let cadenas = ["En", "un", "lugar", "de", "La", "Mancha"]
cadenas.sorted{$0.count < $1.count}.map{$0.count}
```


a.4)
```swift
let cadenas2 = ["En", "un", "lugar", "de", "La", "Mancha"]
cadenas2.reduce([]) {
    (res: [(String, Int)], c: String) -> [(String, Int)] in
        res + [(c, c.count)]}.sorted(by: {$0.1 < $1.1})
```


b) Explica qué hacen las siguientes funciones y pon un ejemplo de su funcionamiento:

b.1)
```swift
func f(nums: [Int], n: Int) -> Int {
    return nums.filter{$0 == n}.count
}
```


b.2)
```swift
func g(nums: [Int]) -> [Int] {
    return nums.reduce([], {
        (res: [Int], n: Int) -> [Int] in
            if !res.contains(n) {
                return res + [n]
            } else {
                return res
            }
    })
}
```


b.3)
```swift
func h(nums: [Int], n: Int) -> ([Int], [Int]) {
   return nums.reduce(([],[]), {
       (res: ([Int],[Int]), num: Int ) -> ([Int],[Int]) in
           if (num >= n) {
               return (res.0, res.1 + [num])
           } else {
               return ((res.0 + [num], res.1))
           }
   })
}
```

c) Implementa las siguientes funciones con funciones de orden superior.

c.1) Función `suma(palabras:contienen:)`:

```swift
suma(palabras: [String], contienen: Character) -> Int
```

que recibe una array de cadenas y devuelve la suma de las longitudes
de las cadenas que contiene el carácter que se pasa como parámetro.


c.2) Función `sumaMenoresMayores(nums:pivote:)`:

```swift
sumaMenoresMayores(nums: [Int], pivote: Int) -> (Int, Int)
```

que recibe un array de números y un número pivote y
devuelve una tupla con la suma de los números menores y mayores o
iguales que el pivote.


d) (Ejercicio sobre variables capturadas por clausuras) Reflexiona
sobre el siguiente código y completa el hueco para obtener el
resultado esperado.

```swift
func bar(f: (Int) -> Int) {
  print(f(__________))
}

func foo() -> (Int) -> Int {
  var x = 3
  return {
    x += $0 + 2
    return x
  }
}

var x = 5
let g = foo()
bar(f: g)   // => 9
bar(f: g)   // => 15
```

### Ejercicio 3


Define un tipo enumerado con un árbol genérico, tal y como hicimos en
el último ejercicio de la práctica anterior, que tenga como genérico
el tipo de dato que contiene.

En el siguiente ejemplo vemos cómo debería poderse definir con el
mismo tipo genérico un árbol de enteros y un árbol de cadenas:

```swift
let arbolInt: Arbol = .nodo(53, 
                            [.nodo(13, []), 
                             .nodo(32, []), 
                             .nodo(41, 
                                   [.nodo(36, []), 
                                    .nodo(39, [])
                                   ])
                            ])
let arbolString: Arbol = .nodo("Zamora", 
                               [.nodo("Buendía", 
                                      [.nodo("Albeza", []), 
                                       .nodo("Berenguer", []), 
                                       .nodo("Bolardo", [])
                                      ]), 
                                .nodo("Galván", [])
                               ])
```


Define las funciones genéricas `toArray` y `toArrayFOS` que devuelvan un array con todos
los componentes del árbol usando un recorrido _preorden_ (primero la
raíz y después los hijos). La primera la debes implementar con
recursión mutua y la segunda usando funciones de orden superior.

Ejemplo:

```swift
print(toArray(arbol: arbolInt))
// Imprime: [53, 13, 32, 41, 36, 39]
print(toArrayFOS(arbol: arbolString))
// Imprime: ["Zamora", "Buendía", "Albeza", "Berenguer", "Bolardo", "Galván"]
```


### Ejercicio 4

Implementa en Swift la función `imprimirListadosNotas(alumnos:)` que
recibe un array de tuplas, en donde cada tupla contiene información de
la evaluación de un alumno de LPP (nombreAlumno, notaParcial1,
notaParcial2, notaParcial3, añosMatriculacion) y que debe imprimir por pantalla los
siguientes listados: 

- listado 1: array ordenado por nombre del alumno (orden alfabético
creciente) 
- listado 2: array ordenado por la nota del parcial 1 (orden
decreciente de nota) 
- listado 3: array ordenado por la nota del parcial 2 (orden creciente
de nota) 
- listado 4: array ordenado por año de matriculación y nota del
  parcial 3 (orden decreciente de año y nota) 
- listado 5: array ordenado por nota final (media de los tres
parciales, ponderados en: 0,34, 0,33, 0,33) (orden decreciente de nota final)
 
Las ordenaciones hay que realizarlas usando la función `sorted`.

!!! Note "Nota"
    Para que los listados se muestren formateados con espacios, puedes usar la siguiente
    función (para ello también debes incluir el import que se indica)
 
    ```swift

    import Foundation

    func imprimirListadoAlumnos(_ alumnos: [(String, Double, Double, Double, Int)]) {
        print("Alumno   Parcial1   Parcial2   Parcial3  Años")
        for alu in alumnos {
            alu.0.withCString {
                print(String(format:"%-10s %5.2f      %5.2f    %5.2f  %3d", $0, alu.1,alu.2,alu.3,alu.4))
            }
        }
    }
    ```

 
Ejemplo:

```swift
let listaAlumnos = [("Pepe", 8.45, 3.75, 6.05, 1), 
                    ("Maria", 9.1, 7.5, 8.18, 1), 
                    ("Jose", 8.0, 6.65, 7.96, 1),
                    ("Carmen", 6.25, 1.2, 5.41, 2), 
                    ("Felipe", 5.65, 0.25, 3.16, 3), 
                    ("Carla", 6.25, 1.25, 4.23, 2), 
                    ("Luis", 6.75, 0.25, 4.63, 2), 
                    ("Loli", 3.0, 1.25, 2.19, 3)]
imprimirListadosNotas(listaAlumnos)
```
 
Algunos de los listados que se deben mostrar serían los siguientes:

```txt
LISTADO ORIGINAL
Alumno   Parcial1   Parcial2   Parcial3  Años
Pepe        8.45       3.75     6.05    1
Maria       9.10       7.50     8.18    1
Jose        8.00       6.65     7.96    1
Carmen      6.25       1.20     5.41    2
Felipe      5.65       0.25     3.16    3
Carla       6.25       1.25     4.23    2
Luis        6.75       0.25     4.63    2
Loli        3.00       1.25     2.19    3

LISTADO ORDENADO por Parcial1 (decreciente)
Alumno   Parcial1   Parcial2   Parcial3  Años
Loli        3.00       1.25     2.19    3
Felipe      5.65       0.25     3.16    3
Carmen      6.25       1.20     5.41    2
Carla       6.25       1.25     4.23    2
Luis        6.75       0.25     4.63    2
Jose        8.00       6.65     7.96    1
Pepe        8.45       3.75     6.05    1
Maria       9.10       7.50     8.18    1
```


### Ejercicio 5

Dado el array `listaAlumnos` del ejercicio anterior, utiliza funciones
de orden superior para obtener los datos requeridos en cada caso.

A) Número de alumnos que han aprobado primer parcial y suspendido el segundo

```swift
print(listaAlumnos. ________________________________ )
// Resultado: 5
```

B) Alumnos que han aprobado la asignatura (tienen una nota final >= 5)

```swift
print(listaAlumnos._______________________________ )

// Resultado: ["Pepe", "Maria", "Jose"]
```

C) Nota media de todos los alumnos en forma de tupla `(media_p1, media_p2, media_p3)`

```swift
var tupla = listaAlumnos._____________________________________ )
tupla = (tupla.0 / Double(listaAlumnos.count), tupla.1 / Double(listaAlumnos.count), tupla.2 / Double(listaAlumnos.count))
print(tupla)
// Resultado: (6.6812499999999995, 2.7624999999999997, 5.2262500000000003)
```

### Ejercicio 6 ###


Implementa la función `construye` con el siguiente perfil:

```swift
func construye(operador: Character) -> (Int, Int) -> Int
```

La función recibe un operador que puede ser uno de los siguientes
caracteres: `+`, `-`, `*`, `/` y debe devolver una clausura que reciba
dos argumentos y realice la operación indicada sobre ellos.

Ejemplo:

```swift
var f = construye(operador: "+")
print(f(2,3))
// Imprime 5
f = construye(operador: "-")
print(f(2,3))
// Imprime -1
```

----

Lenguajes y Paradigmas de Programación, curso 2021-22  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

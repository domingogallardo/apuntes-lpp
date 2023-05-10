# Práctica 9: Seminario de Swift y Programación Funcional en Swift (1)

## Ejercicios

### Ejercicio 1 ###

Comienza por leer y probar el [seminario de
Swift](https://domingogallardo.github.io/apuntes-lpp/seminarios/seminario2-swift/seminario2-swift.html),
hasta el apartado _Funciones y clausuras_ (incluido).

1. Para instalar el comando `swift` en tu ordenador sigue las
   instrucciones del seminario. 
   
2. Tal y como se indica en el seminario, puedes ejecutar también
   programas Swift usando el entorno on-line
   [http://online.swiftplayground.run](http://online.swiftplayground.run). 
   Pero debes tener en cuenta que esta opción tiene
   algunos problemas: se requiere conexión a Internet, el editor es
   muy limitado y es posible que en alguna ocasión el servidor esté
   caído.

3. Crea el fichero `practica09.swift` con una instrucción _Hola mundo_
   que imprima esa cadena. Ejecútalo en el entorno que hayas instalado
   y comprueba que todo funciona correctamente:

    ```
    $ swift practica09.swift
    Hola, mundo
    ```
4. Lee el seminario, copiando y modificando (siempre que sea posible)
    el código de los ejemplos en el fichero `practica09.swift`. Lee
    bien el apartado correspondiente antes de probar cada ejemplo. Es
    conveniente que **copies el código sin hacer _copy-paste_**, para
    que te acostumbres a la sintaxis del nuevo lenguaje.

    Incluye en la práctica todos los experimentos indicados, hasta el
    `Experimento 9`. Antes de cada experimento pon un comentario
    indicando el experimento.


### Ejercicio 2 ###

a) Implementa en Swift la función recursiva
`prefijos(prefijo:palabras:)` que recibe una cadena y un array de
palabras. Devuelve un array de `Bool` con los booleanos resultantes de
comprobar si la cadena es prefijo de cada una de las palabras de la
lista.

Puedes usar el método `hasPrefix()` de `String` para comprobar si una
cadena es prefijo de otra:

```swift
let miCadena = "Hola"
miCadena.hasPrefix("Ho") // Devuelve true
miCadena.hasPrefix("la") // Devuelve false
```

Ejemplo:

```swift
let array = ["anterior", "antígona", "antena"]
let prefijo = "ante"
print("\n******\n2a) Función prefijos(prefijo:palabras:)\n******")
print(prefijos(prefijo: prefijo, palabras: array))
// Imprime: [true, false, true]
```

b) Implementa en Swift la función recursiva `parejaMayorParImpar(numeros:)` que
recibe un array de enteros positivos y devuelve una pareja con dos
enteros: el primero es el mayor número impar y el segundo el mayor
número par. Si no hay ningún número par o impar se devolverá un 0.

```swift
let numeros = [10, 201, 12, 103, 204, 2]
print("\n******\n2b) Función parejaMayorParImpar(numeros:)\n******")
print(parejaMayorParImpar(numeros: numeros))
// Imprime: (201, 204)
```

### Ejercicio 3 ###

a) Implementa en Swift la **función recursiva**
`compruebaParejas(_:funcion:)` con el siguiente tipo:

```
([Int], (Int) -> Int) -> [(Int, Int)]
```

La función recibe dos parámetros: un `Array` de enteros y una función
que recibe un entero y devuelve un entero. La función devolverá un
array de tuplas que contiene las tuplas formadas por aquellos números
contiguos del primer array que cumplan que el número es el resultado
de aplicar la función al número situado en la posición anterior.

Ejemplo:

```swift
func cuadrado(x: Int) -> Int {
   return x * x
}
print(compruebaParejas([2, 4, 16, 5, 10, 100, 105], funcion: cuadrado))
// Imprime [(2,4), (4,16), (10,100)]
```

b) Implementa en Swift la **función recursiva**
`coinciden(parejas: [(Int,Int)], funcion: (Int)->Int)` que devuelve
un array de booleanos que indica si el resultado de aplicar la función
al primer número de cada pareja coincide con el segundo.

    
```swift
let array = [(2,4), (4,14), (4,16), (5,25), (10,100)]
print(coinciden(parejas: array, funcion: cuadrado))
// Imprime: [true, false, true, true, true]
```


### Ejercicio 4 ###

Supongamos que estamos escribiendo un programa que debe tratar
movimientos de cuentas bancarias. Define un enumerado `Movimiento `
con valores asociados con el que podamos representar:

- Depósito (valor asociado: `(Double)`)
- Cargo de un recibo (valor asociado: `(String, Double)`)
- Cajero (valor asociado: `(Double)`)

Y define la función `aplica(movimientos:[Movimiento])` que reciba un
array de movimientos y devuelva una pareja con el dinero resultante de acumular todos
los movimientos y un array de Strings con todos los cargos realizados.

Ejemplo:


```swift
let movimientos: [Movimiento] = [.deposito(830.0), .cargoRecibo("Gimnasio", 45.0), .deposito(400.0), .cajero(100.0), .cargoRecibo("Fnac", 38.70)]
print(aplica(movimientos: movimientos))
//Imprime (1046.3, ["Gimnasio", "Fnac"])
```


### Ejercicio 5 ###

Implementa en Swift un tipo enumerado recursivo que permita construir
árboles binarios de enteros. El enumerado debe tener 

- un caso en el que guardar tres valores: un `Int` y dos árboles
binarios (el hijo izquierdo y el hijo derecho)
- otro caso constante: un árbol binario vacío 

Llamaremos al tipo `ArbolBinario` y a los casos `nodo` y `vacio`.

Impleméntalo de forma que el siguiente ejemplo funcione correctamente:

```swift
let arbol: ArbolBinario = .nodo(8, 
                                .nodo(2, .vacio, .vacio), 
                                .nodo(12, .vacio, .vacio))
```

Implementa también la función `suma(arbolb:)` que reciba una instancia de
árbol binario y devuelva la suma de todos sus nodos:

```swift
print(suma(arbolb: arbol))
// Imprime: 22
```


### Ejercicio 6 ###

Implementa en Swift un tipo enumerado recursivo que permita construir
árboles de enteros usando el mismo enfoque que en Scheme: un nodo está
formado por un dato (un `Int`) y una colección de árboles
hijos. Llamaremos al tipo `Arbol`.

Impleméntalo de forma que el siguiente ejemplo funcione correctamente:

```swift

/*
Definimos el árbol

    10
   / | \
  3  5  8
  |
  1

*/

let arbol1 = Arbol.nodo(1, [])
let arbol3 = Arbol.nodo(3, [arbol1])
let arbol5 = Arbol.nodo(5, [])
let arbol8 = Arbol.nodo(8, [])
let arbol10 = Arbol.nodo(10, [arbol3, arbol5, arbol8])
```

Implementa también la función `suma(arbol:cumplen:)` que reciba una instancia de
árbol y una función `(Int) -> Bool` que comprueba una
condición sobre el nodo. La función debe devolver la suma de todos los
nodos del árbol que cumplan la condición. 

Implementa la función usando la misma estrategia que ya utilizamos en
Scheme de definir una función auxiliar `suma(bosque:cumplen:)` y una recursión
mutua.

```swift
func esPar(x: Int) -> Bool {
    return x % 2 == 0
}

print("La suma del árbol es: \(suma(arbol: arbol10, cumplen: esPar))")
// Imprime: La suma del árbol genérico es: 18
```

----

Lenguajes y Paradigmas de Programación, curso 2022-23  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

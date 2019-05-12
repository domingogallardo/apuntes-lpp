# Práctica 10: Programación Orientada a Objetos en Swift 1

## Entrega de la práctica

Para entregar la práctica debes subir a Moodle el fichero
`practica10.swift` con una cabecera inicial con tu nombre y apellidos,
y las soluciones de cada ejercicio separadas por comentarios.


### Ejercicio 1 ###

a) ¿Qué se imprime al ejecutar el siguiente programa? Reflexiona sobre el
funcionamiento del código, compruébalo con el compilador y experimenta
haciendo cambios y comprobando el resultado.


```swift
var x = 0

func construye() -> () -> Int {
  var x = 10
  return {
    x = x + 5
    return x
  }
}


func usa(funcion: () -> Int) {
  var x = 20
  print(funcion())
}

let g = construye()
usa(funcion: g)
usa(funcion: g)
```

b) El siguiente código tiene errores, pero los comentarios indican
correctamente su intención, pero éste tiene errores. Indica cuáles son
y qué se imprimirá al ejecutarlo. Después compruébalo con el
compilador y experimenta haciendo cambios y comprobando el resultado.

```swift
let x = 0
var almacen: [() -> Int] = []

func construye() -> () -> Int {
  var x = 10
  return {
    x = x + 5
    return x
  }
}

func usa(funcion: () -> Int) {
  var x = 20
  almacen.append(funcion)
}

let g = construye()
usa(funcion: g)

// Obtenemos la clausura guardada en almacen
let f = almacen[0]()
// Invocamos a la clausura
print(f)
print(f)
```


c) El siguiente código usa observadores de propiedades y una variable
del tipo (estática). 

¿Qué se imprime al final de su ejecución? Reflexiona sobre el
funcionamiento del código, compruébalo con el compilador y experimenta
haciendo cambios y comprobando el resultado.

```swift
struct Valor {
    var valor: Int = 0 {
        willSet {
            Valor.z += newValue
        }        
        didSet {
            if valor > 10 {
                valor = 10
            }
        }
    }
    static var z = 0
}

var c1 = Valor()
var c2 = Valor()
c1.valor = 20
c2.valor = 8
print(c1.valor + c2.valor + Valor.z)
```




### Ejercicio 2 ###

Supongamos la siguiente clase `MisPalabras`:


```swift
class MisPalabras {
    var guardadas: [String] = []
    func guarda(palabra: String) {
        guardadas = guardadas + [palabra]
    }
}

let palabras = MisPalabras()
palabras.guarda(palabra: "Hola")
palabras.guarda(palabra: "me")
palabras.guarda(palabra: "llamo")
palabras.guarda(palabra: "Yolanda")
print(palabras.guardadas)
// ["Hola", "me", "llamo", "Yolanda"]
```

Debes añadir una **propiedad calculada** `logitud` que devuelva la suma de las
longitudes de todas las palabras guardadas (usa una función de orden
superior para calcular esta suma). 

Haz también que sea una **propiedad modificable** de la siguiente forma:

- Si se intenta asignar un valor mayor o igual que la longitud de las cadenas
  guardadas, o un número negativo, no se hace nada.
- Si se asigna un valor menor que la longitud de las cadenas se deben
  dejar guardadas sólo las palabras que suman esa longitud, recortando la última
  de ellas si es necesario.

Ejemplo:

```swift

print(palabras.longitud)
// 18
palabras.longitud = 10
print(palabras.guardadas)
// ["Hola", "me", "llam"]
```

!!! Nota "Ayuda"
    Puedes utilizar la siguiente función `recorta` para recortar una palabra:

```swift
func recorta(_ palabra: String, hasta: Int) -> String {
    if hasta >= palabra.count {
        return palabra
    } else {
       let start = palabra.startIndex
       let end =  palabra.index(start, offsetBy: hasta)
       return String(palabra[start..<end])
    }
}
print(recorta("Hola", hasta: 2))
// Ho
print(recorta("Hola", hasta: 3))
// Hol
print(recorta("Hola", hasta: 4))
// Hola
print(recorta("Hola", hasta: 5))
// Hola
```

### Ejercicio 3

En este ejercicio vamos a trabajar con estructuras y clases
geométricas: `Punto`, `Tamaño`, `Rectangulo` y `Circulo`. Vamos a
definir propiedades almacenadas y propiedades calculadas para todas
las figuras geométricas.

- Para usar la función `sqrt` debes importar la librería `Foundation`:

```swift
import Foundation
```

- El valor de la constante matemática _pi_ lo puedes obtener con la
  propiedad `Double.pi`.

**Estructuras `Punto` y `Tamaño`**

Las debes declarar tal y como aparecen en los apuntes.

**Estructura `Rectangulo`**

- Propiedades de instancia almacenadas: 
    - `origen` (`Punto`) que contiene las coordenadas de la esquina
      inferior izquierda del rectángulo.
    - `tamaño` (`Tamaño`) que contiene las dimensiones del rectángulo. 
    - Ambas propiedades se inicializan en un inicializador.
- Propiedades de instancia calculadas: 
    - `centro` (`Punto`, de lectura y escritura) que devuelve el
      centro del rectángulo. El `setter` modifica la posición del
      rectángulo manteniendo fijo su tamaño.
    - `area` (`Double`, sólo lectura ) que devuelve el área del rectángulo. 

**Estructura `Circulo`**

- Propiedades de instancia almacenadas:
    - `centro` (`Punto`) que contiene las coordenadas del centro del
      círculo.
    - `radio` (`Double`) que contiene la longitud del radio.
    - Ambas propiedades se inicializan en un inicializador.
- Propiedades de instancia calculadas:
    - `area` (`Double`, de lectura y escritura) que devuelve el área
      del círculo. El `setter` modifica el tamaño del círculo (su
      radio), manteniéndolo en la misma posición.

**Estructura `AlmacenFiguras`**

- Propiedades almacenadas:
    - `rectangulos` y `circulos` que contienen respectivamente arrays
      de rectángulos y círculos inicializados a arrays vacíos.
- Propiedades calculadas:
    - `numFiguras` (`Int`) que devuelve el número total de figuras creadas.
    - `areaTotal` (`Double`) que devuelve la suma total de las áreas
      de todas las figuras creadas.
- Métodos:
    - `añade(rectangulo:)` y `añade(circulo:)` que añaden un
      rectángulo y un círculo al array correspondiente.

!!!Note "Nota"
    La definición anterior del almacén de figuras no es demasiado correcta,
    porque se utiliza una variable distinta para cada tipo de figura, sin
    generalizar. En la práctica de la semana que viene veremos cómo
    mejorarlo utilizando protocolos.

Implementa las estructuras anteriores y escribe algún ejemplo de
código en el que se creen al menos un rectángulo y un círculo, se
prueben sus propiedades, se añadan al almacén de figuras y se prueben
sus métodos.

----

Lenguajes y Paradigmas de Programación, curso 2018-19  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez


# Buenas prácticas de programación funcional

En este documento iremos incluyendo semana a semana una guía sobre buenas
prácticas de programación funcional. Son consejos que te ayudarán a escribir
programas legibles, concisos, abstractos que siguen el paradigma de programación
funcional y que usamos también en todos los ejemplos de código de la asignatura.

### Nombres de funciones y variables

- Los nombres de funciones y variables deben ser descriptivos y tener un
  significado que ayude a explicar qué hace la función que estamos
  definiendo. Al ser Scheme un lenguaje débilmente tipado, nombres de parámetros
  como `car`, `palabra`, `lista-numeros` nos ayudan a entender cuál debe ser el
  tipo del parámetro y cómo debemos llamar a la función.
  
    Buenos ejemplos: `(entre-dos-puntos? p1 p2 p3)`, `(distancia punto1 punto2)`,
    `(veces car palabra)`

    Malos ejemplos: `(aux1 x1 x2)`, `(mi-func x y z)`

- Los nombres de las funciones y parámetros siempre empiezan en
  minúscula. Cuando el nombre de una función o un parámetro sea compuesto,
  usaremos un guión para dividir las palabras.
  
    Buenos ejemplos: `suma-cuadrados`, `tiempo-impacto`, `conduce-vehiculo`.
    
    Malos ejemplos: `sumaCuadrados`, `Tiempo-Impacto`, `conduce_vehiculo`.
  
- Los nombres de los predicados (funciones que devuelven `#t` o `#f`) siempre
  terminan con el símbolo `?`.
  
    Ejemplos: `equal?`, `number?`, `(entre? p1 p2 p3)`
  
----
Lenguajes y Paradigmas de Programación, curso 2023-24  
© Departamento Ciencia de la Computación e Inteligencia Artificial, Universidad de Alicante  
Domingo Gallardo, Cristina Pomares, Antonio Botía, Francisco Martínez

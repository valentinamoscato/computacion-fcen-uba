# Teórica 0 - 16 de Agosto

# **Introducción a la Programación Funcional**

## Definición

La programación funcional se basa en definir y aplicar funciones para procesar información. Las funciones son verdaderamente funciones matemáticas, sin efectos secundarios y con salidas consistentes para las mismas entradas.

## **Características**

- **Inmutabilidad**: Las estructuras de datos no cambian.
- Funciones como datos: Las funciones pueden ser pasadas como parámetros, devueltas como resultados y formar parte de estructuras de datos.

### Ejemplo

Un programa funcional se define mediante ecuaciones, como la función longitud que calcula la longitud de una lista.

## Expresiones

Las expresiones pueden ser constructores, variables o aplicaciones de funciones a datos.

## Tipos

Los tipos especifican el invariante de un dato o función.

Por ejemplo, `99 :: Int` indica que 99 es un entero. Los tipos ayudan a asegurar que las expresiones sean bien formadas y tengan sentido.

## Modelo de cómputo

Evaluar una expresión consiste en buscar subexpresiones que coincidan con el lado izquierdo de una ecuación y reemplazarlas por el lado derecho.

La evaluación se detiene cuando se alcanza un constructor, una función parcialmente aplicada o un estado de error.

## Funciones de orden superior

Estas funciones toman otras funciones como argumentos o devuelven funciones como resultado.

Ejemplos incluyen `map`, que aplica una función a cada elemento de una lista, y `filter`, que selecciona elementos de una lista según un predicado.

## Funciones *lambda*

### Definición

Las funciones lambda son funciones anónimas, es decir, no tienen un nombre explícito.

Se definen usando la notación `\` seguida de los parámetros y el cuerpo de la función.

### Sintaxis

La sintaxis general es `\param1 param2 -> expresión`.

Por ejemplo, \x y -> x + y es una función lambda que suma dos números.

### Uso

Se utilizan comúnmente en programación funcional para pasar funciones como argumentos a otras funciones.

Por ejemplo, en Haskell, `map (\x -> x * 2) [1, 2, 3]` aplica la función *lambda* `\x -> x * 2` a cada elemento de la lista `[1, 2, 3]`.

### Composición

Las funciones lambda pueden ser utilizadas para definir otras funciones.

Por ejemplo, `(.) :: (b -> c) -> (a -> b) -> a -> c; g . f = \x -> g (f x)` define la composición de funciones.

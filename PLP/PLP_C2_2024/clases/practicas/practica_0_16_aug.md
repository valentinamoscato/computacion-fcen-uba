**Repaso de Haskell**

**Definición de funciones**

Ejemplo: `f x = x + 1`

**Ejercicios de funciones**
   - **Promedio**: `promedio a b = (a + b) / 2`
   - **Máximo**: `maximo a b = if a > b then a else b`
   - **Factorial**: `factorial n = if n == 0 then 1 else n * factorial (n - 1)`

**Recursión**
   - Ejemplo: `factorial 0 = 1; factorial n = n * factorial (n - 1)`

**Listas**
   - Descripción por extensión: `[1, 2, 3, 4, 5]`
   - Descripción recursiva: `1 : (2 : (3 : (4 : (5 : []))))`

**Tipos de datos algebraicos**
   - Ejemplo: `data Bool = True | False`
   - Función: `inverso :: Float -> Maybe Float`

**Variables de tipo**

   - Ejemplo: `[] :: [a]`, `id :: a -> a`, `head :: [a] -> a`, `tail :: [a] -> [a]`, `const :: a -> b -> a`, y `length :: [a] -> Int`

**Tipo de funciones**

   - Ejemplo: `f1 :: Int -> (Int -> Int)`, `f2 :: (Int -> Int) -> Int`, y `f3 :: Int -> Int -> Int`

**Convenciones de precedencia y asociatividad**

En Haskell, los tipos tienen asociatividad a derecha y la aplicación tiene asociatividad a izquierda. 

   - `a -> b -> c = a -> (b -> c) = ̸= (a -> b) -> c`

   - `f x y = (f x) y = ̸= f (x y)`

La aplicación tiene mayor precedencia que los operadores binarios

   `f x + y = (f x) + y = ̸= f (x + y)`

Los operadores binarios pueden usarse como funciones y viceversa.

   `x + y = (+) x y`

Las funciones se pueden usar como operadores binarios.

   `f x y = x ‘f‘ y`

**Tipos de datos algebraicos**

   - **Bool**: Representa valores booleanos con dos posibles valores: `True` y `False`.
   - **Maybe**: Encapsula un valor opcional. Puede ser `Nothing` (ausencia de valor) o `Just a` (contiene un valor de tipo `a`).
   - **Either**: Representa un valor que puede ser de dos tipos diferentes. Puede ser `Left a` (contiene un valor de tipo `a`) o `Right b` (contiene un valor de tipo `b`).

   - **Ejemplos**
     - **inverso**: `Float -> Maybe Float` devuelve el inverso multiplicativo de un número si está definido, o `Nothing` en caso contrario.
         `
            inverso :: Float -> Maybe Float
            inverso 0 = Nothing
            inverso x = Just (1/x)
         `
     - **aEntero**: `Either Int Bool -> Int` convierte una expresión que puede ser booleana o entera a un entero (0 para `False` y 1 para `True`).
         `
            aEntero :: Either Int Bool -> Int
            aEntero (Left x) = x
            aEntero (Right True) = 1
            aEntero (Right False) = 0
         `

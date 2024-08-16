-- Ejercicio 4
-- Definir las siguientes funciones sobre listas:
-- a. limpiar :: String → String → String, que elimina todas las apariciones de cualquier carácter de la primera
-- cadena en la segunda. Por ejemplo, limpiar ``susto'' ``puerta'' evalúa a ``pera''. Nota: String es un
-- renombre de [Char]. La notación ``hola'' es equivalente a [`h',`o',`l',`a'] y a `h':`o':`l':`a':[].
-- b. difPromedio :: [Float] → [Float] que dada una lista de números devuelve la diferencia de cada uno con el
-- promedio general. Por ejemplo, difPromedio [2, 3, 4] evalúa a [-1, 0, 1].
-- c. todosIguales :: [Int] → Bool que indica si una lista de enteros tiene todos sus elementos iguales.

-- a. limpiar :: String → String → String, que elimina todas las apariciones de cualquier carácter de la primera cadena en la segunda. Por ejemplo, limpiar ``susto'' ``puerta'' evalúa a ``pera''. Nota: String es un renombre de [Char]. La notación ``hola'' es equivalente a [`h',`o',`l',`a'] y a `h':`o':`l':`a':[].

limpiar :: String -> String -> String
limpiar "" ys = ys
limpiar (x:xs) ys = limpiar xs (filter (/= x) ys)

-- b. difPromedio :: [Float] → [Float] que dada una lista de números devuelve la diferencia de cada uno con el promedio general. Por ejemplo, difPromedio [2, 3, 4] evalúa a [-1, 0, 1].
promedio :: [Float] -> Float
promedio xs = sum xs / fromIntegral (length xs)

difPromedio :: [Float] -> [Float]
difPromedio xs = map (\x -> x - promedio xs) xs

-- c. todosIguales :: [Int] → Bool que indica si una lista de enteros tiene todos sus elementos iguales.

todosIguales :: [Int] -> Bool
todosIguales xs = not (any (/= head xs) xs)

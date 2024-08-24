
-- ejercicio 8

mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f)

-- toma una función currificada de dos parámetros
-- y una lista de pares, y devuelve una lista
-- con los resultados de aplicar la función a cada par

armarPares :: [a] -> [b] -> [(a, b)]
armarPares [] _ = []
armarPares _ [] = []
armarPares (x:xs) (y:ys) = (x, y) : armarPares xs ys

-- toma dos listas y devuelve una lista de pares
-- con los elementos de las listas
-- en el orden en que aparecen en las listas originales
-- si una de las listas es más corta, se truncan los elementos

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)

-- toma una función currificada de dos parámetros
-- y dos listas, y devuelve una lista
-- con los resultados de aplicar la función a cada par
-- de elementos de las listas en el mismo índice

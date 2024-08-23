-- ejercicio 4

permutaciones :: [a] -> [[a]]
permutaciones [] = [[]]
permutaciones (x:xs) = concatMap (insertarEnTodasLasPosiciones x) (permutaciones xs)
  where
    insertarEnTodasLasPosiciones elem lista = [ take i lista ++ [elem] ++ drop i lista | i <- [0..length lista] ]

-- dada una lista, devuelve todas las permutaciones posibles de la lista
-- recorriendo recursivamente la lista y aplicando la función insertarEnTodasLasPosiciones
-- que inserta un elemento en todas las posiciones posibles de una lista
-- y concatena los resultados

-- no logre implementar la función permutaciones con foldr :(

partes :: [a] -> [[a]]
partes = foldr (\x acc -> acc ++ map (x:) acc) [[]]

-- recorre la lista de derecha a izquierda,
-- concatenando la lista acumulada
-- con el elemento actual agregado a cada una de sus sublistas
-- el acumulador comienza en [[]]
-- devuelve todas las partes posibles de la lista

prefijos :: [a] -> [[a]]
prefijos = foldr (\x acc -> [] : map (x:) acc) [[]]

-- recorre la lista de derecha a izquierda,
-- construyendo la lista de prefijos agregando x al frente
-- de cada lista en el acumulador
-- y agregando [] al principio del acumulador, ya que cada nuevo prefijo comienza con la lista vacía
-- el acumulador comienza en [[]]
-- devuelve todos los posibles prefijos de la lista

sublistas :: [a] -> [[a]]
sublistas = foldr (\x acc -> acc ++ map (x:) acc) [[]]

-- sublistas ESTA MAL porque retorna lo mismo que partes

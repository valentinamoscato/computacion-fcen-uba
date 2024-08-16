-- Ejercicio 1
-- Dar el tipo y describir el comportamiento de las siguientes funciones del módulo Prelude de Haskell:
-- null head tail init last take drop (++) concat reverse elem

-- null :: [a] -> Bool
-- null xs = if xs == [] then True else False
-- Retorna True si la lista es vacía, False en caso contrario.

-- head :: [a] -> a
-- head (x:xs) = x
-- Retorna el primer elemento de la lista.

-- tail :: [a] -> [a]
-- tail (x:xs) = xs
-- Retorna la lista sin el primer elemento.

-- init :: [a] -> [a]
-- init [x] = []
-- Retorna la lista sin el último elemento.

-- last :: [a] -> a
-- last [x] = x
-- Retorna el último elemento de la lista.

-- take :: Int -> [a] -> [a]
-- take 0 xs = []
-- take n (x:xs) = x : take (n-1) xs
-- Retorna los primeros n elementos de la lista.

-- drop :: Int -> [a] -> [a]
-- drop 0 xs = xs
-- drop n (x:xs) = drop (n-1) xs
-- Retorna la lista sin los primeros n elementos.

-- (++) :: [a] -> [a] -> [a]
-- [] ++ ys = ys
-- (x:xs) ++ ys = x : (xs ++ ys)
-- Concatena dos listas.

-- concat :: [[a]] -> [a]
-- concat [] = []
-- concat (xs:xss) = xs ++ concat xss
-- Concatena una lista de listas.

-- reverse :: [a] -> [a]
-- reverse [] = []
-- reverse (x:xs) = reverse xs ++ [x]
-- Invierte una lista.

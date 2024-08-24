-- ejercicio 6

-- El siguiente esquema captura la recursión primitiva sobre listas
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna x = recr (\y ys r -> if x == y then ys else y : r) [] -- r es el acumulador
-- si x == y, se saca el elemento y de la lista, si no, se deja y en la lista

-- foldr no funciona para sacarUna porque no se puede acceder al resto de la lista en la función de plegado

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado x = recr (\y ys r -> if x <= y then x : y : ys else y : r) [x]

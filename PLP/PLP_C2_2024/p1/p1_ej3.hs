-- ejercicio 3
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use concat" #-}
{-# HLINT ignore "Use map" #-}

sumConFoldr :: [Int] -> Int
-- sumConFoldr [] = 0
-- sumConFoldr (x:xs) = foldr (\y acc -> y + acc) x xs
-- sumConFoldr (x:xs) = foldr (+) x xs
sumConFoldr = foldr (+) 0

-- recorre la lista de derecha a izquierda, sumando los elementos de la lista
-- a un acumulador que comienza en 0

elemConFoldr :: Eq a => a -> [a] -> Bool
elemConFoldr x = foldr (\y acc -> y == x || acc) False

-- recorre la lista de derecha a izquierda, comparando cada elemento con x
-- foldr recibe como argumento una función lambda que compara el elemento actual
-- con x y el acumulador, si el elemento actual es igual a x, devuelve True, si no
-- devuelve el acumulador, inicializado en False

concatConFoldr :: [[a]] -> [a]
concatConFoldr = foldr (++) []

-- recorre la lista de derecha a izquierda,
-- aplicando la función (++) a cada elemento de la lista
-- y el acumulador, que comienza en []

filterConFoldr :: (a -> Bool) -> [a] -> [a]
filterConFoldr p = foldr (\x acc -> if p x then x:acc else acc) []

-- recorre la lista de derecha a izquierda,
-- si el elemento actual cumple con el predicado p, lo agrega a la lista
-- si no, no lo agrega y sigue con el siguiente elemento
-- el acumulador comienza en []

mapConFoldr :: (a -> b) -> [a] -> [b]
mapConFoldr f = foldr (\x acc -> f x : acc) []

-- recorre la lista de derecha a izquierda,
-- aplica la función f a cada elemento de la lista
-- y agrega el resultado a la lista acumulada
-- el acumulador comienza en []


mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f [x] = x
mejorSegun f (x:xs) = if f x (mejorSegun f xs) then x else mejorSegun f xs

mejorSegunConFoldr :: (a -> a -> Bool) -> [a] -> a
mejorSegunConFoldr f (x:xs) = foldr (\y acc -> if f y acc then y else acc) x xs

-- recorre la lista de derecha a izquierda,
-- compara el elemento actual con el acumulador, que comienza en el primer elemento de la lista
-- si el elemento actual es mejor que el acumulador, se reemplaza el acumulador por el elemento actual
-- si no, se deja el acumulador como está

sumasParciales :: Num a => [a] -> [a]
sumasParciales = tail . foldl (\acc x -> acc ++ [x + last acc]) [0]

-- recorre la lista de izquierda a derecha,
-- acumulando en una lista los resultados de sumar
-- el elemento actual con el último elemento de la lista acumulada
-- el acumulador comienza en [0]

sumaAlt :: (Num a) => [a] -> a
sumaAlt = foldr (-) 0

-- recorre la lista de derecha a izquierda,
-- restando el elemento actual al acumulador
-- el acumulador comienza en 0
-- devuelve la suma de los elementos en posiciones pares
-- menos la suma de los elementos en posiciones impares

sumaAltInversa :: (Num a) => [a] -> a
sumaAltInversa = (*) (-1) . sumaAlt

-- compone la función sumaAlt con (* (-1))
-- para obtener el resultado opuesto
-- es decir,
-- devuelve la suma de los elementos en posiciones impares
-- menos la suma de los elementos en posiciones pares

# Práctica 1 - 27 de Agosto

## Currificación y aplicación parcial

Las funciones en Haskell siempre toman un único argumento. *Currificar* consiste en convertir una función que toma un único argumento en forma de tupla en una que toma *varios* argumentos de forma secuencial.

`
    prodNoCurrificada :: (Int, Int) -> Int
    prodNoCurrificada (x,y) = x*y

    prodCurrificada :: Int -> Int -> Int
    prodCurrificada x y = x*y
    prodCurrificada x = \y -> x*y

    curry :: ((a,b) -> c) -> (a -> b -> c)
    curry f x y = f (x,y) -- pattern matching
    curry f = \x y -> f (x,y)

    uncurry :: (a -> b -> c) -> (a,b) -> c
    uncurry f = \(x,y) -> f x y

    triple :: Float -> Float
    triple = (*3)

    esMayorDeEdad :: Int -> Bool
    esMayorDeEdad = (>17)

    (.) :: (a -> b) -> (c -> a) -> (c -> b)
    (.) f g = \x -> f (g x)

    flip :: (a -> b -> c) -> (b -> a -> c)
    flip f x y = \x y -> f y x

    ($) :: (a -> b) -> a -> b
    ($) f = f

    const :: a -> b -> a
    const x _ = x
    const x = \_ -> x

    flip ($) 0 => espera una función para aplicársela a 0
    (==0) . (flip mod 2) => evalúa si un número es par

    mejorSegun :: (a -> a -> Bool) -> [a] -> a
    mejorSegun _ [x] = x
    mejorSegun p (x:xs) = if p x rec then x else rec
        where rec = mejorSegun p xs
    
    maximo :: Ord a => [a] -> a
    maximo = mejorSegun(>)

    minimo :: Ord a => [a] -> a
    minimo = mejorSegun(<)

    listaMasCorta = mejorSegun (\x rec -> length x < length rec)

    deLongitudN :: Int -> [[a]] -> [[a]]
    deLongitudN n = filter (\xs -> length xs == n)

    -- filter implementado con foldr
    filter :: (a -> Bool) -> [a] -> [a]
    filter p = foldr (\x rec -> if p x then x:rec else rec) []

    soloPuntosFijosEnN :: Int -> [Int -> Int] -> [Int -> Int]
    soloPuntosFijosEnN n = filter (\f -> f n == n)
    soloPuntosFijosEnN = filter ((==n) . ($n))

    -- map implementado con foldr
    map :: (a -> b) -> [a] -> [b]
    map f = foldr (\x rec -> f x : rec)

    reverseAnidado :: [[Char]] -> [[Char]]
    reverseAnidado xs = reverse (map reverse xs)

    paresCuadrados :: [Int] -> [Int]
    paresCuadrados = map (\x -> if even x then x*x else x)

    listaComp f xs p = map f $ filter p xs

    foldr1 :: (a -> a -> a) -> [a] -> a
    foldr1 _ [x] = x
    foldr1 f (x:xs) = f x (foldr1 f xs)

    -- mejorSegun usando foldr1
    mejorSegun p = foldr1 (\x rec -> if p x rec then x else rec)
`

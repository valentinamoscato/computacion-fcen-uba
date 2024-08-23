{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use sum" #-}
{-# HLINT ignore "Use concat" #-}
{-# HLINT ignore "Use map" #-}

-- ejercicio 1

-- Una función currificada es aquella que toma sus argumentos de a uno por vez,
-- en lugar de tomar una tupla con todos los argumentos

max2 :: (Float, Float) -> Float
max2 (x, y) | x >= y = x
            | otherwise = y
-- currificada

normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x^2 + y^2)
-- no currificada

normaVectorialCurrificada :: Float -> Float -> Float
normaVectorialCurrificada x y = sqrt (x^2 + y^2)
-- currificada

substract_ :: Float -> Float -> Float
substract_ = flip (-)
-- currificada

predecesor :: Float -> Float
predecesor = substract_ 1
-- currificada

evaluarEnCero :: (Float -> Float) -> Float
-- evaluarEnCero = \f -> f 0
evaluarEnCero f = f 0
-- currificada

dosVeces :: (a -> a) -> a -> a
-- dosVeces = \f -> f . f
dosVeces f = f . f
-- currificada

flipAll :: [a -> b -> c] -> [b -> a -> c]
flipAll = map flip
-- currificada

flipRaro :: b -> (a -> b -> c) -> a -> c
flipRaro = flip flip
-- currificada

-- ejercicio 2

curry' :: ((a,b) -> c) -> (a -> b -> c)
curry' f a b = f (a,b)

uncurry' :: (a -> b -> c) -> ((a,b) -> c)
uncurry' f (a,b) = f a b

curryN :: ([a] -> b) -> (a -> [a] -> b)
curryN f x xs = f (x:xs)


-- ejercicio 3

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

-- ejercicio 5

-- original
-- elementosEnPosicionesPares :: [a] -> [a]
-- elementosEnPosicionesPares [] = []
-- elementosEnPosicionesPares (x:xs) = if null xs
--                                         then [x]
--                                         else x : elementosEnPosicionesPares' (tail xs)

elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares = fst . foldr (\x (acc, skip) -> if skip then (acc, False) else (x:acc, True)) ([], True)

-- original
-- entrelazar :: [a] -> [a] -> [a]
-- entrelazar [] = id
-- entrelazar (x:xs) = \ys -> if null ys
                                -- then x : entrelazar xs []
                                -- else x : head ys : entrelazar xs (tail ys)

-- entrelazar no usa recursión estructural pues manipula la cola de la lista ys previamente a la llamada recursiva

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

-- ejercicio 7

genLista :: a -> (a -> a) -> Integer -> [a]
genLista _ _ 0 = []
genLista x f n = x : genLista (f x) f (n-1)

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta m n = genLista m (+1) (n-m+1)

-- ejercicio 8

mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f)

armarPares :: [a] -> [b] -> [(a, b)]
armarPares [] _ = []
armarPares _ [] = []
armarPares (x:xs) (y:ys) = (x, y) : armarPares xs ys

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)

-- ejercicio 10

generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs | stop xs = init xs
                          | otherwise = generateFrom stop next (xs ++ [next xs])

generateBase :: ([a] -> Bool) -> a -> (a -> a) -> [a]
generateBase stop current prox = generate stop (\list -> if null list then current else prox (last list))

factoriales :: Int -> [Int]
factoriales n = generate (\list -> length list == n) (\list -> if null list then 1 else last list * length list)

iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generate (\list -> length list == n) (\list -> if null list then x else f (last list))

generateFromV2 :: (a -> Bool) -> (a -> a) -> a -> [a]
generateFromV2 stop next x = takeWhile (not . stop) (iterate next x)

-- ejercicio 11

foldNat :: (Integer -> Integer) -> Integer -> Integer -> Integer
foldNat f z 0 = z
foldNat f z n = f (foldNat f z (n-1))

potencia :: Integer -> Integer -> Integer
potencia b e = foldNat (*b) 1 e

-- ejercicio 12

data Polinomio a = X
    | Cte a
    | Suma (Polinomio a) (Polinomio a)
    | Prod (Polinomio a) (Polinomio a)

evaluar :: Num a => a -> Polinomio a -> a
evaluar x p = case p of
    X -> x
    Cte n -> n
    Suma p1 p2 -> evaluar x p1 + evaluar x p2
    Prod p1 p2 -> evaluar x p1 * evaluar x p2

-- ejercicio 13

data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB fHoja fBin t = case t of
    Nil -> fHoja
    Bin t1 n t2 -> fBin (rec t1) n (rec t2)
    where rec = foldAB fHoja fBin

recAB :: b -> (b -> a -> b -> b) -> (AB a -> Bool) -> AB a -> b
recAB fHoja fBin isNil tree = rec tree
  where
    rec t = if isNil t
              then fHoja
              else fBin (rec (izq t)) (raiz t) (rec (der t))

    izq (Bin i _ _) = i
    izq Nil = Nil

    raiz (Bin _ v _) = v

    der (Bin _ _ d) = d
    der Nil = Nil

esNil :: AB a -> Bool
esNil Nil = True
esNil _ = False

altura :: AB a -> Int
altura = recAB 1 (\x _ y -> 1 + max x y) esNil

cantNodos :: AB a -> Int
cantNodos = recAB 1 (\x _ y -> 1 + x + y) esNil

mejorSegúnAB :: (a -> a -> Bool) -> AB a -> a
mejorSegúnAB f = recAB (error "No hay hojas en un árbol vacío") (\i r d -> if f r i then r else i) esNil

esABB :: Ord a => AB a -> Bool
esABB (Bin i r d) = mejorSegúnAB (>) i < r && r <= mejorSegúnAB (<=) d

-- ejercicio 14

ramas :: AB a -> Int
ramas = foldAB 0 (\x _ y -> 1 + max x y)

espejo :: AB a -> AB a
espejo t = foldAB Nil (\i r d -> Bin d r i) t

-- ejercicio 16

data RoseTree a = Rose a [RoseTree a]

foldRose :: [a] -> (a -> [[a]] -> [a]) -> RoseTree a -> [a]
-- foldRose :: b -> (a -> [b] -> b) -> RoseTree a -> b
foldRose fHoja fArbol t = case t of
    Rose x ts -> fArbol x (map rec ts)
    where rec = foldRose fHoja fArbol

hojasRose :: RoseTree a -> [a]
hojasRose (Rose x xs) = foldRose [x] (\x ts -> x : concat ts) (Rose x xs)

-- distancias :: RoseTree a -> [Int]
-- distancias (Rose x ts) = foldRose [0] (\x ts -> [1]) (Rose x ts)
distancias :: RoseTree a -> [Int]
distancias x = [0]

alturaRose :: RoseTree a -> Int
alturaRose t = 1 + maximum (distancias t)

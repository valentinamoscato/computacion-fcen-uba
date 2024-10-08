-- ejercicio 1
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
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
sumConFoldr = sum

elemConFoldr :: Eq a => a -> [a] -> Bool
elemConFoldr x = foldr (\y acc -> y == x || acc) False

concatConFoldr :: [[a]] -> [a]
concatConFoldr = concat

filterConFoldr :: (a -> Bool) -> [a] -> [a]
filterConFoldr p = foldr (\x acc -> if p x then x:acc else acc) []

mapConFoldr :: (a -> b) -> [a] -> [b]
mapConFoldr f = map f

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f [x] = x
mejorSegun f (x:xs) = if f x (mejorSegun f xs) then x else mejorSegun f xs

sumasParciales :: Num a => [a] -> [a]
sumasParciales = tail . foldl (\acc x -> acc ++ [x + last acc]) [0]

sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

sumaAltInversa :: Num a => [a] -> a
sumaAltInversa = foldl (-) 0

-- ejercicio 4

permutaciones :: [a] -> [[a]]
permutaciones [] = [[]]
permutaciones (x:xs) = concatMap (insertarEnTodasLasPosiciones x) (permutaciones xs)
  where
    insertarEnTodasLasPosiciones elem lista = [ take i lista ++ [elem] ++ drop i lista | i <- [0..length lista] ]

partes :: [a] -> [[a]]
partes = foldr (\x acc -> acc ++ map (x:) acc) [[]]

prefijos :: [a] -> [[a]]
prefijos = foldr (\x acc -> [x] : map (x:) acc) [[]]

sublistas :: [a] -> [[a]]
sublistas = foldr (\x acc -> acc ++ map (x:) acc) [[]]

-- ejercicio 5

elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares = foldr (\x acc -> if even (length acc) then x:acc else acc) []

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

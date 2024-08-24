{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use sum" #-}
{-# HLINT ignore "Use concat" #-}
{-# HLINT ignore "Use map" #-}

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

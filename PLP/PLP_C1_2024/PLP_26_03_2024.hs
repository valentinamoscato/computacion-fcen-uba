curry' :: ((a,b) -> c) -> (a -> b -> c)
curry' f a b = f (a,b)

uncurry' :: (a -> b -> c) -> ((a,b) -> c)
uncurry' f (a,b) = f a b

prod :: Int -> Int -> Int
prod x y = x * y

doble :: Int -> Int
doble = prod 2

-- doble :: Int -> Int
-- doble = prod 2 -- cambiando la definición de doble, el tipo queda igual

-- (+) 1 sumar 1

triple :: Float -> Float
triple = (*) 3

esMayorDeEdad :: Int -> Bool
esMayorDeEdad = (<) 18

dot' :: (b -> c) -> (a -> b) -> a -> c
dot' f g x = f (g x)

flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x

dollar' :: (a -> b) -> a -> b
dollar' f = f

const' :: a -> b -> a
const' x _ = x
-- otra definición de const: const x = \_ -> x

-- flip ($) 0 retorna 0
-- (==0) . (flip mod 2) = 2 mod x == 0 = esPar x

-- hoogle: buscador de funciones de haskell

-- Evaluación lazy: no se evalúa una expresión hasta que sea necesario

take' :: Int -> [a] -> [a]
take' 0 _ = []
take' _ [] = []
take' n (x:xs) = x : take (n-1) xs

infinitosUnos :: [Int]
infinitosUnos = 1 : infinitosUnos

nUnos :: Int -> [Int]
nUnos n = take n infinitosUnos

-- nUnos toma n elementos (todos 1) de la lista infinitosUnos

-- Si existe una reducción finita, la estrategia de reducción lazy termina

-- Funciones de alto orden

maximo :: Ord a => [a] -> a
maximo [x] = x
maximo (x:xs) = max x (maximo xs)

minimo :: Ord a => [a] -> a
minimo [x] = x
minimo (x:xs) = min x (minimo xs)

listaMasCorta :: [[a]] -> [a]
listaMasCorta [x] = x
listaMasCorta (x:xs) = if length x < length (listaMasCorta xs) then x else listaMasCorta xs

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f [x] = x
mejorSegun f (x:xs) = if f x (mejorSegun f xs) then x else mejorSegun f xs

-- reescribir las funciones anteriores utilizando mejorSegun

nuevoMaximo :: Ord a => [a] -> a
nuevoMaximo = mejorSegun (>)

nuevoMinimo :: Ord a => [a] -> a
nuevoMinimo = mejorSegun (<)

nuevoListaMasCorta :: [[a]] -> [a]
nuevoListaMasCorta = mejorSegun (\x y -> length x < length y)

-- definir utilizando filter

deLongitudN :: Int -> [[a]] -> [[a]]
deLongitudN n = filter (\x -> length x == n)

soloPuntosFijosEnN :: Int -> [Int->Int] -> [Int->Int] -- dados un numero n y una lista de funciones, deja las funciones que al aplicarlas a n dan n.
soloPuntosFijosEnN n = filter (\f -> f n == n)

-- definir utilizando map

reverseAnidado :: [[Char]] -> [[Char]]
reverseAnidado = map reverse . reverse

paresCuadrados :: [Int] -> [Int]
paresCuadrados = map (^ 2) . filter even

-- listaComp f xs p = [f x | x <- xs, p x] pero utilizando map y filter

listaComp :: (a -> b) -> [a] -> (a -> Bool) -> [b]
listaComp f xs p = map f . filter p $ xs

-- Para situaciones en las cuales no hay un caso base claro (ej: no
-- existe el neutro), tenemos las funciones: foldr1 y foldl1.
-- Permiten hacer recursion estructural sobre listas sin definir un caso base:
-- foldr1 toma como caso base el ultimo elemento de la lista.
-- foldl1 toma como caso base el primer elemento de la lista.
-- Para ambas, la lista no debe ser vacia, y el tipo del resultado debe
-- ser el de los elementos de la lista.

-- Definir mejorSegun :: (a -> a -> Bool) -> [a] -> a usando foldr1 o foldl1

nuevoMejorSegun :: (a -> a -> Bool) -> [a] -> a
nuevoMejorSegun f = foldr1 (\x y -> if f x y then x else y)

otroNuevoMejorSegun :: (a -> a -> Bool) -> [a] -> a
otroNuevoMejorSegun f = foldl1 (\x y -> if f x y then x else y)

-- Implementar las siguientes funciones utilizando esquemas de recursion

elem :: Eq a => a -> [a] -> Bool -- indica si un elemento pertenece o no a la lista
elem x = foldr (\y r -> y == x || r) False -- el parametro de la lista es implicito

sumaAlt :: Num a => [a] -> a -- realiza la suma alternada de los elementos de una lista. Es decir, da como resultado: el primer elemento, menos el segundo, mas el tercero, menos el cuarto, etc.
sumaAlt [] = 0
sumaAlt [x] = x
sumaAlt [x,y] = x - y
sumaAlt (x:y:xs) = x - y + sumaAlt xs
-- [1,2,3,4,5] -> 1 - 2 + 3 - 4 + 5 = 3

otroSumaAlt :: Num a => [a] -> a
otroSumaAlt = foldr (-) 0 -- dado en clase

sacarPrimera:: Eq a => a -> [a] -> [a] -- elimina la primera aparicion de un elemento en la lista.
sacarPrimera x (y:ys) = if x == y then ys else y : sacarPrimera x ys

-- Folds sobre estructuras nuevas

data AEB a = Hoja a | Bin (AEB a) a (AEB a)

foldAEB :: (a -> b) -> (b -> a -> b -> b) -> AEB a -> b
foldAEB fHoja fBin t = case t of
    Hoja n -> fHoja n
    Bin t1 n t2 -> fBin (rec t1) n (rec t2)
    where rec = foldAEB fHoja fBin

altura :: AEB a -> Int
altura = foldAEB (const 1) (\x _ y -> 1 + max x y)

ramas :: AEB a -> Int
ramas = foldAEB (const 0) (\x _ y -> 1 + max x y)

cantNodos :: AEB a -> Int
cantNodos = foldAEB (const 1) (\x _ y -> 1 + x + y)

cantHojas :: AEB a -> Int
cantHojas = foldAEB (const 1) (\x _ y -> x + y)

espejo :: AEB a -> AEB a
espejo = foldAEB Hoja (\x n y -> Bin y n x)

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

foldPolinomio :: a -> (a -> a) -> (a -> a -> a) -> (a -> a -> a) -> Polinomio a -> a
foldPolinomio fX fCte fSuma fProd p = case p of
    X -> fX
    Cte n -> fCte n
    Suma p1 p2 -> fSuma (rec p1) (rec p2)
    Prod p1 p2 -> fProd (rec p1) (rec p2)
    where rec = foldPolinomio fX fCte fSuma fProd

evaluarConFold :: Num a => a -> Polinomio a -> a
evaluarConFold x = foldPolinomio x id (+) (*)

data RoseTree a = Rose a [RoseTree a] -- arboles donde cada nodo tiene una cantidad indeterminada de hijos

hojasRose :: RoseTree a -> [a]
hojasRose (Rose x []) = [x]
hojasRose (Rose x ts) = concatMap hojasRose ts

ramasRose :: RoseTree a -> [[a]]
ramasRose (Rose x []) = [[x]]
ramasRose (Rose x ts) = map (x:) $ concatMap ramasRose ts

sizeRose :: RoseTree a -> Int
sizeRose (Rose x []) = 1
sizeRose (Rose x ts) = 1 + sum (map sizeRose ts)

alturaRose :: RoseTree a -> Int
alturaRose (Rose x []) = 1
alturaRose (Rose x ts) = 1 + maximum (map alturaRose ts)

{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use max" #-}
import Prelude hiding (maximum, elem)
{-# HLINT ignore "Redundant lambda" #-}
{-# HLINT ignore "Use foldr" #-}
doble :: Integer -> Integer
doble x = 2 * x

cuadrado :: Integer -> Integer
cuadrado x = x * x

-- QVQ doble 2 == cuadrado 2
-- doble 2 == 2 * 2 == 4 == cuadrado 2
curry . uncurry = id

-- curry :: ((a, b) -> c) -> (a -> b -> c)
-- curry f = (\x y -> f (x, y))
-- uncurry :: (a -> b -> c) -> ((a, b) -> c)
-- uncurry f = (\(x, y) -> f x y)
-- (.) :: (b -> c) -> (a -> b) -> (a -> c)
-- (f . g) x = f (g x)
-- id :: a -> a
-- id x = x

-- curry . uncurry $ f = curry (uncurry f) = f

-- igualdad de funciones:
-- dos funciones son iguales si para los mismos parametros devuelven el mismo resultado

-- principio de extensionalidad:
-- dadas f, g :: a -> b, probar f = g se reduce a probar:
-- ∀ x :: a . f x = g x

-- curry . uncurry = id 
-- curry (uncurry f) = f
-- curry (\(x, y) -> f x y) = f - prop2
-- \x y -> (\(x, y) -> f x y) (x, y) = f
-- \x y -> f x y = f -- prop3
-- f = f -- prop4

-- pares y union disjunta/tipo suma
-- ∀ p :: Either Int (Int, Int) . ∀ q :: Either Int (Int, Int) .
-- prod p q = prod q p

-- prod :: Either Int (Int, Int) -> Either Int (Int, Int) -> Either Int (Int, Int)
-- prod (Left x) (Left y) = Left (x * y)
-- prod (Left x) (Right (y, z)) = Right (x * y, x * z)
-- prod (Right (y, z)) (Left x) = Right (y * x, z * x)
-- prod (Right (w, x)) (Right (y, z)) = Left (w * y + x * z)

-- e :: Either a b
-- e = Left x, con x :: a | Right y, con y :: b

-- para todo e1 :: Either Int (Int, Int) . e2 :: Either Int (Int, Int)

--  QVQ prod q p = prod p q

-- p, q :: Either Int (Int, Int)
-- probamos todos los posibles casos:
-- p :: Left Int y p :: Right (Int, Int)
-- q :: Left Int y q :: Right (Int, Int)

-- CASO 1 (LEFT - LEFT)
-- p :: Left Int
-- q :: Left Int

-- prod (Left x) (Left y) = Left (x * y)
-- prod (Left y) (Left x) = Left (y * x) = Left (x * y) pues la multiplicación es conmutativa

-- prod (Left x) (Left y) = Left (x * y) = Left (y * x) = prod (Left y) (Left x)

-- CASO 2 (LEFT - RIGHT)
-- p :: Left Int
-- q :: Right (Int, Int)

-- prod (Left x) (Right (y, z)) =
    -- Right (x * y, x * z) =
    -- Right (y, z) * x =
    -- prod (Right (y, z)) (Left x)

-- CASO 3 (RIGHT - LEFT) - igual al caso 2

-- p :: Right (Int, Int)
-- q :: Left Int

-- prod (Right (y, z)) (Left x) =
    -- Right (y * x, z * x) =
    -- Right (x * y, x * z) =
    -- prod (Left x) (Right (y, z))

-- CASO 4 (RIGHT - RIGHT)

-- p :: Right (Int, Int)
-- q :: Right (Int, Int)

-- prod (Right (w, x)) (Right (y, z)) =
    -- Left (w * y + x * z) =
    -- Left (y * w + z * x) =
    -- prod (Right (y, z)) (Right (w, x))

-- nomenclatura:
-- p :: Either Int (Int, Int)
-- p = Left x, con x :: Int
-- p = Right (y, z), con y, z :: Int
-- q :: Either Int (Int, Int)
-- q = Left t, con t :: Int
-- q = Right (u, v), con u, v :: Int

-- funciones como estructuras de datos

type Conj a = (a -> Bool)

-- constante vacio :: Conj a
vacio :: a -> Bool
vacio = const False

agregar :: Eq a => a -> Conj a -> Conj a
agregar e c = \x -> c x || x == e
-- para un elemento e, el conjunto c,
-- si x pertenece a c o x es igual a e,
-- entonces x pertenece al conjunto
-- (recordar que un conjunto es una función que toma un elemento y devuelve un booleano)

interseccion :: Conj a -> Conj a -> Conj a
interseccion c1 c2 = \x -> c1 x && c2 x
-- para dos conjuntos c1 y c2,
-- si x pertenece a c1 y x pertenece a c2,
-- entonces x pertenece a la intersección de c1 y c2

union :: Conj a -> Conj a -> Conj a
union c1 c2 = \x -> c1 x || c2 x
-- para dos conjuntos c1 y c2,
-- si x pertenece a c1 o x pertenece a c2,
-- entonces x pertenece a la unión de c1 y c2

diferencia :: Conj a -> Conj a -> Conj a
diferencia c1 c2 = \x -> c1 x && not (c2 x)
-- para dos conjuntos c1 y c2,
-- si x pertenece a c1 y x no pertenece a c2,
-- entonces x pertenece a la diferencia de c1 y c2

-- ∀ c :: Conj a . ∀ d :: Conj a . 
-- interseccion d (diferencia c d) = vacio

-- interseccion d (diferencia c d) =
    -- interseccion d (\x -> c x && not (d x)) = - prop2
     -- \y -> d y && (\x -> c x && not (d x)) y = - prop2
        -- \y -> d y && (c y && not (d y)) =
            -- \y -> d y && c y && not (d y) =
                -- \y -> d y && c y && False =
                    -- False = vacio - prop3 y prop4
               
-- resuelto en clase
-- para todo x :: d
-- interseccion d (diferencia c d) x = vacio x
-- (\y -> d y && (c y && not (d y))) x = const False x
-- d x && (c x && not (d x)) = False
-- d x && c x && not (d x) = False
-- d x && c x && False = False
-- False = False

-- induccion sobre listas

length1 :: [a] -> Int
length1 [] = 0
length1 (_:xs) = 1 + length1 xs

length2 :: [a] -> Int
length2 = foldr (\_ n -> n + 1) 0

-- CASO BASE: p([])
-- CASO INDUCTIVO: p(xs) => p(x:xs)
-- HI: p(xs)

-- length1 [] = length2 []
-- 0 = foldr (\_ n -> n + 1) 0 []
-- 0 = 0

-- length1 (x:xs) = length2 (x:xs)
-- 1 + length1 xs = foldr (\_ n -> n + 1) 0 (x:xs)

-- ∀ e :: a . ∀ ys :: [a] . elem e ys => e <= maximum ys

elem :: Eq a => a -> [a] -> Bool
elem e [] = False
elem e (x:xs) = (e == x) || elem e xs

maximum :: Ord a => [a] -> a
maximum [x] = x
maximum (x:xs) = if x < maximum xs then maximum xs else x

-- elem e ys = False si ys = []
-- elem e ys = e == x || elem e xs si ys = x:xs

-- maximum ys = x si ys = [x]
-- maximum ys = if x < maximum xs then maximum xs else x si ys = x:xs

-- CONCEPTO
-- induccion estructural sobre ys: P(ys) : Ord a => para todo e :: a => (elem e ys => e <= maximum ys)
-- si e no pertenece a ys, entonces no me importa si e es menor o mayor que el máximo de ys
-- solo quiero ver los casos en los que e pertenece a ys
-- QVQ, si e pertenece a ys, entonces e es menor o igual al máximo de ys

-- CASO BASE: ys = [e], e pertenece a ys y e es el máximo de ys (caso trivial, caso base de maximum)

-- PASO INDUCTIVO:

-- HIPOTESIS INDUCTIVA: si e pertenece a ys, entonces e <= maximum ys
-- si e <= maximum ys, entonces

-- QVQ: e <= maximum (y:ys) para todo y :: a

-- las opciones son que y == maximum (y:ys) o y /= maximum (y:ys)
-- si y == maximum (y:ys), entonces (maximum ys <= y)
    -- pero e <= maximum ys (HI), luego e <= maximum ys <= y,
        -- por lo tanto e <= maximum (y:ys)
-- si y /= maximum (y:ys), entonces e <= maximum (y:ys) es equivalente a (e <= maximum ys) (HI)

-- resuelto en clase
-- CASO INDUCTIVO: p(ys) => p(y:ys), ∀ y :: a
-- HI: p(ys)

-- QVQ:
-- ∀ e :: a . elem e (y:ys) => e <= maximum (y:ys)
    -- (e == y) || elem e ys => e <= maximum (y:ys) - por definicion de elem
       
        -- ((e == y) || elem e ys) :: Bool = A - por extensionalidad de los Bool, pruebo A == False y A == True

            -- si A == False => queda probado

            -- si A == True =>
                -- o bien e == y, o bien elem e ys
                    -- CASO e == y
                        -- e == y => e <= maximum (y:ys) (*)
                        -- QVQ y <= maximum (y:ys)
                            -- o bien y es el máximo de ys, o bien no lo es
                                -- CASO 1: si y es el máximo de ys, entonces y <= maximum (y:ys)
                                -- CASO 2: si y no es el máximo de ys, entonces y <= maximum ys
                                    -- por HI, e <= maximum ys
                                    -- y e == y, entonces y <= maximum ys
                    -- CASO elem e ys (e /= y)
                        -- e <= maximum (y:ys)
                        -- QVQ e <= maximum (y:ys)
                            -- o bien e es el máximo de ys, o bien no lo es
                                -- CASO 1: si e es el máximo de (y:ys), entonces e == maximum (y:ys)
                                -- CASO 2: si e no es el máximo de (y:ys), entonces e < maximum (y:ys)

-- (*) e <= if x < maximum xs then maximum xs else x
    -- e <= maximum xs, por HI
    -- y maximum xs <= maximum (x:xs), por definición de maximum
    -- por lo tanto, e <= maximum (x:xs), por propiedad de cotas


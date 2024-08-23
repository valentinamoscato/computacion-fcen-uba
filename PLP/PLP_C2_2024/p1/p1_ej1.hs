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

-- ejercicio 10
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

foldNat :: (Integer -> Integer) -> Integer -> Integer -> Integer
foldNat f z 0 = z
foldNat f z n = f (foldNat f z (n-1))

-- foldNat aplica la función f n veces a z,
-- y retorna el resultado

potencia :: Integer -> Integer -> Integer
potencia b e = foldNat (*b) 1 e

-- potencia aplica la función (*b) e veces a 1,
-- retornando b^e

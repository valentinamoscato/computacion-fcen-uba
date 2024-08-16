-- Ejercicio 2
-- Definir las siguientes funciones:
-- a. valorAbsoluto :: Float → Float, que dado un número devuelve su valor absoluto.
-- b. bisiesto :: Int → Bool, que dado un número que representa un año, indica si el mismo es bisiesto.
-- c. factorial :: Int → Int, definida únicamente para enteros positivos, que computa el factorial.
-- d. cantDivisoresPrimos :: Int → Int, que dado un entero positivo devuelve la cantidad de divisores primos.

-- a. valorAbsoluto :: Float → Float, que dado un número devuelve su valor absoluto.
valorAbsoluto :: Float -> Float
valorAbsoluto x = if x < 0 then -x else x

-- b. bisiesto :: Int → Bool, que dado un número que representa un año, indica si el mismo es bisiesto.
bisiesto :: Int -> Bool
bisiesto x = (mod x 4 == 0 && mod x 100 /= 0) || mod x 400 == 0

-- c. factorial :: Int → Int, definida únicamente para enteros positivos, que computa el factorial.
factorial :: Int -> Int
factorial 0 = 1
factorial x = x * factorial (x-1)

-- d. cantDivisoresPrimos :: Int → Int, que dado un entero positivo devuelve la cantidad de divisores primos.
esPrimo :: Int -> Bool
esPrimo x = length [y | y <- [1..x], mod x y == 0] == 2

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos x = length [y | y <- [1..x], mod x y == 0, esPrimo y]

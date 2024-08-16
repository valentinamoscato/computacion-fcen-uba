-- Ejercicio 3
-- Contamos con los tipos Maybe y Either denidos como sigue:
-- data Maybe a = Nothing | Just a
-- data Either a b = Left a | Right b
-- a. Definir la función inverso :: Float → Maybe Float que dado un número devuelve su inverso multiplicativo
-- si está definido, o Nothing en caso contrario.
-- b. Definir la función aEntero :: Either Int Bool → Int que convierte a entero una expresión que puede ser
-- booleana o entera. En el caso de los booleanos, el entero que corresponde es 0 para False y 1 para True.

-- a. Definir la función inverso :: Float → Maybe Float que dado un número devuelve su inverso multiplicativo si está definido, o Nothing en caso contrario.

inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso x = Just (1/x)

-- b. Definir la función aEntero :: Either Int Bool → Int que convierte a entero una expresión que puede ser booleana o entera. En el caso de los booleanos, el entero que corresponde es 0 para False y 1 para True.

aEntero :: Either Int Bool -> Int
aEntero (Left x) = x
aEntero (Right True) = 1
aEntero (Right False) = 0

-- ejercicio 11

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

-- evaluar toma un valor x y un polinomio p,
-- y retorna el resultado de evaluar p en x
-- evaluando recursivamente las operaciones de suma y producto
-- que se encuentren en p
-- ejemplos:
-- evaluar 2 (Suma (Cte 3) (Prod X (Cte 2))) == 7
-- donde p = 3 + 2*x y x = 2

-- ejercicio 7

-- recursión primitiva sobre listas

genLista :: a -> (a -> a) -> Integer -> [a]
genLista _ _ 0 = []
genLista x f n = x : genLista (f x) f (n-1)

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta m n = genLista m (+1) (n-m+1)

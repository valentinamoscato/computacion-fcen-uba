-- ejercicio 15

data RoseTree a = Rose a [RoseTree a]

foldRose :: [a] -> (a -> [[a]] -> [a]) -> RoseTree a -> [a]
-- foldRose :: b -> (a -> [b] -> b) -> RoseTree a -> b
foldRose fHoja fArbol t = case t of
    Rose x ts -> fArbol x (map rec ts)
    where rec = foldRose fHoja fArbol

-- foldRose toma una lista de hojas, una función fArbol y un árbol t,
-- y retorna el resultado de aplicar fArbol a la raíz de t y los resultados
-- de aplicar rec a los hijos de t
-- donde rec es el resultado de aplicar foldRose a fHoja y fArbol

-- es decir, foldRose aplica recursivamente dos funciones a los hijos de t
-- y retorna el resultado

hojasRose :: RoseTree a -> [a]
hojasRose (Rose x xs) = foldRose [x] (\x ts -> x : concat ts) (Rose x xs)

-- hojasRose toma un árbol t, y retorna las hojas de t
-- aplicando foldRose con fHoja = [x], fArbol = (\x ts -> x : concat ts)
-- donde fArbol toma un valor x y una lista de listas de valores ts,
-- y retorna la lista que contiene a x y a todos los valores de ts

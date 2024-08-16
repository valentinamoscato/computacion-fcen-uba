-- Ejercicio 5
-- Dado el siguiente modelo para árboles binarios:
-- data AB a = Nil | Bin (AB a) a (AB a)
-- denir las siguientes funciones:
-- a. vacioAB :: AB a → Bool que indica si un árbol es vacío (i.e. no tiene nodos).
-- b. negacionAB :: AB Bool → AB Bool que dado un árbol de booleanos construye otro formado por la negación
-- de cada uno de los nodos.
-- c. productoAB :: AB Int → Int que calcula el producto de todos los nodos del árbol.

data AB a = Nil | Bin (AB a) a (AB a)

-- a. vacioAB :: AB a → Bool que indica si un árbol es vacío (i.e. no tiene nodos).
vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB _ = False

-- b. negacionAB :: AB Bool → AB Bool que dado un árbol de booleanos construye otro formado por la negación de cada uno de los nodos.
negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin izq x der) = Bin (negacionAB izq) (not x) (negacionAB der)

-- c. productoAB :: AB Int → Int que calcula el producto de todos los nodos del árbol.
productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin izq x der) = x * productoAB izq * productoAB der

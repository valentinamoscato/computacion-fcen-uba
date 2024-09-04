-- ejercicio 12
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

data AB a = Nil | Bin (AB a) a (AB a)

-- **recursión estructural**
-- (hace recursión sobre la estructura del árbol
-- pero sin acceder a sus valores ni a resultados de recursiones anteriores)

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB fHoja fBin t = case t of
    Nil -> fHoja
    Bin t1 n t2 -> fBin (rec t1) n (rec t2)
    where rec = foldAB fHoja fBin

-- foldAB toma una función fHoja, una función fBin y un árbol binario t,
-- y retorna el resultado de aplicar fHoja a Nil, y fBin a los resultados
-- de aplicar rec a los hijos izquierdo y derecho de t, respectivamente

-- **recursión primitiva**
-- (hace recursión sobre la estructura del árbol
-- y accede a sus valores pero no a resultados de recursiones anteriores)

recAB :: b -> (b -> a -> b -> b) -> (AB a -> Bool) -> AB a -> b
recAB fHoja fBin isNil tree = rec tree
  where
    rec t = if isNil t
              then fHoja
              else fBin (rec (izq t)) (raiz t) (rec (der t))

    izq (Bin i _ _) = i
    izq Nil = Nil

    raiz (Bin _ v _) = v

    der (Bin _ _ d) = d
    der Nil = Nil

-- recAB toma una función fHoja, una función fBin, una función isNil
-- y un árbol binario t,
-- y retorna el resultado de aplicar fHoja si t es Nil, y fBin a los resultados
-- de aplicar rec a los hijos izquierdo y derecho de t, respectivamente

esNil :: AB a -> Bool
esNil Nil = True
esNil _ = False

-- esNil toma un árbol binario t, y retorna True si t es Nil, y False en caso contrario

altura :: AB a -> Int
altura = recAB 1 (\x _ y -> 1 + max x y) esNil

-- altura toma un árbol binario t, y retorna la altura de t
-- (la longitud del camino más largo desde la raíz hasta una hoja)
-- aplicando recAB con fHoja = 1, fBin = (\x _ y -> 1 + max x y)
-- donde fBin toma dos alturas y retorna la mayor más uno

-- uso recAB y no foldAB porque necesito acceder a los valores de los nodos
-- para calcular la altura del árbol
-- con foldAB no podría acceder a los valores de los nodos para compararlos

cantNodos :: AB a -> Int
cantNodos = recAB 1 (\x _ y -> 1 + x + y) esNil

-- cantNodos toma un árbol binario t, y retorna la cantidad de nodos de t
-- aplicando recAB con fHoja = 1, fBin = (\x _ y -> 1 + x + y)
-- donde fBin toma dos cantidades de nodos y retorna la suma de sus valores más uno

-- uso recAB y no foldAB porque necesito acceder a los valores de los nodos
-- para sumarlos

mejorSegúnAB :: (a -> a -> Bool) -> AB a -> a
mejorSegúnAB f = recAB (error "No hay hojas en un árbol vacío") (\i r d -> if f r i then r else i) esNil

-- mejorSegúnAB toma una función f, un árbol binario t, y retorna el mejor valor de t
-- según f, aplicando recAB con fHoja = error "No hay hojas en un árbol vacío",
-- fBin = (\i r d -> if f r i then r else i)
-- donde fBin toma dos valores y retorna el mejor según f

-- uso recAB y no foldAB porque necesito acceder a los valores de los nodos
-- para compararlos

esABB :: Ord a => AB a -> Bool
esABB (Bin i r d) = mejorSegúnAB (>) i < r && r <= mejorSegúnAB (<=) d

-- esABB toma un árbol binario t, y retorna True si t es un árbol binario de búsqueda,
-- y False en caso contrario, aplicando mejorSegúnAB con f = (>), y luego con f = (<=)
-- para verificar que los valores de los hijos izquierdo y derecho de t sean menores y mayores
-- respectivamente que el valor de la raíz de t

-- ejercicio 13

ramas :: AB a -> Int
ramas = foldAB 0 (\x _ y -> 1 + max x y)

-- ramas toma un árbol binario t, y retorna la cantidad de ramas de t
-- (la cantidad de caminos desde la raíz hasta una hoja)
-- aplicando foldAB con fHoja = 0, fBin = (\x _ y -> 1 + max x y)
-- donde fBin toma dos cantidades de ramas y retorna la mayor más uno

-- uso foldAB y no recAB porque no necesito acceder a los valores de los nodos
-- para calcular la cantidad de ramas
-- podría haber usado recAB con fHoja = 0, fBin = (\x _ y -> 1 + max x y)?

espejo :: AB a -> AB a
espejo t = foldAB Nil (\i r d -> Bin d r i) t

-- espejo toma un árbol binario t, y retorna el árbol binario espejo de t
-- aplicando foldAB con fHoja = Nil, fBin = (\i r d -> Bin d r i)
-- donde fBin toma dos árboles y retorna un árbol con los hijos intercambiados

-- uso foldAB y no recAB porque no necesito acceder a los valores de los nodos
-- para intercambiar los hijos

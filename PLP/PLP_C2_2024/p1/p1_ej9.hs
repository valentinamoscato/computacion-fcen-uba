-- ejercicio 9

-- Escribir la función sumaMat, que representa la suma de matrices, usando zipWith. Representaremos una
-- matriz como la lista de sus filas. Esto quiere decir que cada matriz será una lista finita de listas finitas,
-- todas de la misma longitud, con elementos enteros. Recordamos que la suma de matrices se define como
-- la suma celda a celda. Asumir que las dos matrices a sumar están bien formadas y tienen las mismas
-- dimensiones.

sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = zipWith (zipWith (+))

-- toma dos matrices y devuelve la matriz que resulta de sumar
-- celda a celda los elementos de las matrices
-- el zipWith de afuera toma las filas de las matrices
-- y el zipWith de adentro toma los elementos de las filas
-- y los suma

-- Escribir la función trasponer, que, dada una matriz como las del ítem i, devuelva su traspuesta. Es decir,
-- en la posición i, j del resultado está el contenido de la posición j, i de la matriz original. Notar que si la
-- entrada es una lista de N listas, todas de longitud M, la salida debe tener M listas, todas de longitud N.

trasponer :: [[Int]] -> [[Int]]
trasponer = foldr (zipWith (:)) (repeat [])

-- foldr recorre las filas de la matriz
-- y zipWith (:), que es la función que se pasa a foldr,
-- va construyendo las columnas sobre la lista de columnas vacías
-- repeat [] es una lista infinita de listas vacías
-- que asegura que haya suficientes listas para todas las columnas

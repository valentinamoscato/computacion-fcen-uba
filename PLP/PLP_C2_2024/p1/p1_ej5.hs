-- ejercicio 5

-- original
-- elementosEnPosicionesPares :: [a] -> [a]
-- elementosEnPosicionesPares [] = []
-- elementosEnPosicionesPares (x:xs) = if null xs
--                                         then [x]
--                                         else x : elementosEnPosicionesPares' (tail xs)

elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares = fst . foldr (\x (acc, skip) -> if skip then (acc, False) else (x:acc, True)) ([], True)

-- original
-- entrelazar :: [a] -> [a] -> [a]
-- entrelazar [] = id
-- entrelazar (x:xs) = \ys -> if null ys
                                -- then x : entrelazar xs []
                                -- else x : head ys : entrelazar xs (tail ys)

-- entrelazar no usa recursión estructural pues manipula la cola de la lista ys previamente a la llamada recursiva

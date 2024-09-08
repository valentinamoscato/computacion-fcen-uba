{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use isJust" #-}
{-# HLINT ignore "Use list comprehension" #-}
module Proceso (Procesador, AT(Nil,Tern), RoseTree(Rose), Trie(TrieNodo), foldAT, foldRose, foldTrie, procVacio, procId, procCola, procHijosRose, procHijosAT, procRaizTrie, procSubTries, unoxuno, sufijos, inorder, preorder, postorder, preorderRose, hojasRose, ramasRose, caminos, palabras, ifProc,(++!), (.!)) where

import Test.HUnit


--Definiciones de tipos

type Procesador a b = a -> [b]


-- Árboles ternarios
data AT a = Nil | Tern a (AT a) (AT a) (AT a) deriving Eq
--E.g., at = Tern 1 (Tern 2 Nil Nil Nil) (Tern 3 Nil Nil Nil) (Tern 4 Nil Nil Nil)
--Es es árbol ternario con 1 en la raíz, y con sus tres hijos 2, 3 y 4.

-- RoseTrees
data RoseTree a = Rose a [RoseTree a] deriving Eq
--E.g., rt = Rose 1 [Rose 2 [], Rose 3 [], Rose 4 [], Rose 5 []] 
--es el RoseTree con 1 en la raíz y 4 hijos (2, 3, 4 y 5)

-- Tries
data Trie a = TrieNodo (Maybe a) [(Char, Trie a)] deriving Eq
-- E.g., t = TrieNodo (Just True) [('a', TrieNodo (Just True) []), ('b', TrieNodo Nothing [('a', TrieNodo (Just True) [('d', TrieNodo Nothing [])])]), ('c', TrieNodo (Just True) [])]
-- es el Trie Bool de que tiene True en la raíz, tres hijos (a, b, y c), y, a su vez, b tiene como hijo a d.


-- Definiciones de Show

instance Show a => Show (RoseTree a) where
    show = showRoseTree 0
      where
        showRoseTree :: Show a => Int -> RoseTree a -> String
        showRoseTree indent (Rose value children) =
            replicate indent ' ' ++ show value ++ "\n" ++
            concatMap (showRoseTree (indent + 2)) children

instance Show a => Show (AT a) where
    show = showAT 0
      where
        showAT :: Show a => Int -> AT a -> String
        showAT _ Nil = replicate 2 ' ' ++ "Nil"
        showAT indent (Tern value left middle right) =
            replicate indent ' ' ++ show value ++ "\n" ++
            showSubtree (indent + 2) left ++
            showSubtree (indent + 2) middle ++
            showSubtree (indent + 2) right

        showSubtree :: Show a => Int -> AT a -> String
        showSubtree indent subtree =
            case subtree of
                Nil -> replicate indent ' ' ++ "Nil\n"
                _   -> showAT indent subtree

instance Show a => Show (Trie a) where
    show = showTrie ""
      where
        showTrie :: Show a => String -> Trie a -> String
        showTrie indent (TrieNodo maybeValue children) =
            let valueLine = case maybeValue of
                                Nothing -> indent ++ "<vacío>\n"
                                Just v  -> indent ++ "Valor: " ++ show v ++ "\n"
                childrenLines = concatMap (\(c, t) -> showTrie (indent ++ "  " ++ [c] ++ ": ") t) children
            in valueLine ++ childrenLines


--Ejercicio 1
procVacio :: Procesador a b
procVacio _ = []

procId :: Procesador a a
procId x = [x]

procCola :: Procesador [a]  a
procCola [] = []
procCola xs = tail xs -- o (x:xs) = xs

procHijosRose :: Procesador (RoseTree a) (RoseTree a)
procHijosRose (Rose n hijos) = hijos

procHijosAT :: Procesador (AT a) (AT a)
procHijosAT Nil = []
procHijosAT (Tern n i m d) = [i, m, d]
-- o
-- procHijosAT t = case t of
        --Nil -> []
        --Tern n i m d  -> [i, m, d]

procRaizTrie :: Procesador (Trie a) (Maybe a)
procRaizTrie (TrieNodo n hijos) = [n]

procSubTries :: Procesador (Trie a) (Char, Trie a)
procSubTries (TrieNodo n hijos) = hijos

-- Ejercicio 2

foldAT :: b -> (a -> b -> b -> b -> b) -> AT a -> b
foldAT cNil cTern t = case t of
        Nil -> cNil
        Tern n i m d-> cTern n (rec i) (rec m) (rec d)
        where rec = foldAT cNil cTern


foldRose :: (a ->[b] -> b) -> RoseTree a -> b
foldRose cRose (Rose n hijos) = cRose n (map rec hijos)
                              where rec = foldRose cRose


foldTrie :: (Maybe a -> [(Char, b)] -> b) -> Trie a -> b
foldTrie cTrieNodo (TrieNodo n hijos) = cTrieNodo n (map (\(char, trie) -> (char, rec trie)) hijos)
                                       where rec = foldTrie cTrieNodo

--Ejercicio 3

unoxuno :: Procesador [a] [a]
unoxuno = map (\x -> [x])

sufijos :: Procesador [a] [a]
sufijos = foldr (\x rec -> (x : head rec) : rec) [[]]


--Ejercicio 4

preorder :: AT a -> [a]
preorder = foldAT [] (\x i m d -> x : (i ++ m ++ d))

postorder :: AT a -> [a]
postorder = foldAT [] (\x i m d -> i ++ m ++ d ++ [x])

inorder :: AT a -> [a]
inorder = foldAT [] (\x i m d -> i ++ m ++ [x] ++ d)

--Ejercicio 5

preorderRose :: Procesador (RoseTree a) a
preorderRose = foldRose (\n hijos -> n : concat hijos)
-- preorderRose coloca el valor del nodo n
-- y luego concatena la lista de hijos

hojasRose :: Procesador (RoseTree a) a
hojasRose = foldRose (\n hijos -> if null hijos then [n] else concat hijos)
-- hojasRose chequea si un nodo es hoja (si no tiene hijos),
-- en caso de que si, agrega el nodo a la lista de hojas
-- en caso de que no, concatena la lista de hijos

ramasRose :: Procesador (RoseTree a) [a]
ramasRose = foldRose (\n hijos -> if null hijos then [[n]] else map (n:) (concat hijos))
-- ramasRose chequea si un nodo es hoja,
-- en caso de que si, devuelve el camino que tiene solamente al nodo
-- en caso de que no, agrega el nodo a los caminos hacia cada uno de sus hijos

--Ejercicio 6

caminos :: Trie a -> [String]
caminos = foldTrie cTrieNodo
  where
    cTrieNodo _ hijos = "" : subcaminos
      where
        subcaminos = concatMap (\(c, cs) -> map (c:) cs) hijos

--Ejercicio 7

--palabras :: undefined
palabras = undefined


--Ejercicio 8
-- 8.a)
ifProc :: (a->Bool) -> Procesador a b -> Procesador a b -> Procesador a b
ifProc = undefined

-- 8.b)
(++!) :: Procesador a b -> Procesador a b -> Procesador a b
(++!) = undefined

-- 8.c)
(.!) :: Procesador b c -> Procesador a b -> Procesador a c
(.!) = undefined

--Ejercicio 9
-- Se recomienda poner la demostración en un documento aparte, por claridad y prolijidad, y, preferentemente, en algún formato de Markup o Latex, de forma de que su lectura no sea complicada.


{-Tests-}

main :: IO Counts
main = do runTestTT allTests

allTests = test [ -- Reemplazar los tests de prueba por tests propios
  "ejercicio1" ~: testsEj1,
  "ejercicio2" ~: testsEj2,
  "ejercicio3" ~: testsEj3,
  "ejercicio4" ~: testsEj4,
  "ejercicio5" ~: testsEj5,
  "ejercicio6" ~: testsEj6,
  "ejercicio7" ~: testsEj7,
  "ejercicio8a" ~: testsEj8a,
  "ejercicio8b" ~: testsEj8b,
  "ejercicio8c" ~: testsEj8c
  ]

testsEj1 = test [ -- Casos de test para el ejercicio 1
  0             -- Caso de test 1 - expresión a testear
    ~=? 0                                                               -- Caso de test 1 - resultado esperado
  ,
  1     -- Caso de test 2 - expresión a testear
    ~=? 1                                                               -- Caso de test 2 - resultado esperado
  ]

testsEj2 = test [ -- Casos de test para el ejercicio 2
  (0,0)       -- Caso de test 1 - expresión a testear
    ~=? (0,0)                   -- Caso de test 1 - resultado esperado
  ]

testsEj3 = test [ -- Casos de test para el ejercicio 3
  'a'      -- Caso de test 1 - expresión a testear
    ~=? 'a'            -- Caso de test 1 - resultado esperado
  ]

at :: AT Int
at = Tern 16
        (Tern 1
            (Tern 9 Nil Nil Nil)
            (Tern 7 Nil Nil Nil)
            (Tern 2 Nil Nil Nil))
        (Tern 14
            (Tern 0 Nil Nil Nil)
            (Tern 3 Nil Nil Nil)
            (Tern 6 Nil Nil Nil))
        (Tern 10
            (Tern 8 Nil Nil Nil)
            (Tern 5 Nil Nil Nil)
            (Tern 4 Nil Nil Nil))

testsEj4 = test [ -- Casos de test para el ejercicio 4
  preorder at       -- Caso de test 1 - preorder
    ~=? [16, 1, 9, 7, 2, 14, 0, 3, 6, 10, 8, 5, 4], -- Caso de test 1 - resultado esperado
  postorder at       -- Caso de test 2 - postorder
    ~=? [9, 7, 2, 1, 0, 3, 6, 14, 8, 5, 4, 10, 16], -- Caso de test 2 - resultado esperado
  inorder at       -- Caso de test 3 - inorder
    ~=? [9, 7, 1, 2, 0, 3, 14, 6, 16, 8, 5, 10, 4] -- Caso de test 3 - resultado esperado
  ]

rt :: RoseTree Int
rt = Rose 1 [Rose 2 [], Rose 3 [Rose 6 []], Rose 4 [], Rose 5 [Rose 7 [], Rose 8 []]]

testsEj5 :: Test
testsEj5 = test [ -- Casos de test para el ejercicio 5
  preorderRose rt       -- Caso de test 1 - preorderRose
    ~=? [1, 2, 3, 6, 4, 5, 7, 8], -- Caso de test 1 - resultado esperado
  hojasRose rt          -- Caso de test 2 - hojasRose
    ~=? [2, 6, 4, 7, 8], -- Caso de test 2 - resultado esperado
  ramasRose rt          -- Caso de test 3 - ramasRose
    ~=? [[1, 2], [1, 3, 6], [1, 4], [1, 5, 7], [1, 5, 8]] -- Caso de test 3 - resultado esperado
  ]

t :: Trie Bool
t = TrieNodo Nothing
      [ ('a', TrieNodo (Just True) [])
      , ('b', TrieNodo Nothing
          [ ('a', TrieNodo (Just True)
              [ ('d', TrieNodo Nothing [])
              ])
          ])
      , ('c', TrieNodo (Just True) [])
      ]

testsEj6 = test [ -- Casos de test para el ejercicio 6
  caminos t       -- Caso de test 1 - caminos
    ~=? ["", "a", "b", "ba", "bad", "c"] -- Caso de test 1 - resultado esperado
  ]

testsEj7 = test [ -- Casos de test para el ejercicio 7
  True         -- Caso de test 1 - expresión a testear
    ~=? True                                          -- Caso de test 1 - resultado esperado
  ]

testsEj8a = test [ -- Casos de test para el ejercicio 7
  True         -- Caso de test 1 - expresión a testear
    ~=? True                                          -- Caso de test 1 - resultado esperado
  ]
testsEj8b = test [ -- Casos de test para el ejercicio 7
  True         -- Caso de test 1 - expresión a testear
    ~=? True                                          -- Caso de test 1 - resultado esperado
  ]
testsEj8c = test [ -- Casos de test para el ejercicio 7
  True         -- Caso de test 1 - expresión a testear
    ~=? True                                          -- Caso de test 1 - resultado esperado
  ]

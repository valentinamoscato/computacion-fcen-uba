module Proceso (Procesador, AT(Nil,Tern), RoseTree(Rose), Trie(TrieNodo), foldAT, foldRose, foldTrie, procVacio, procId, procCola, procHijosRose, procHijosAT, procRaizTrie, procSubTries, unoxuno, sufijos, inorder, preorder, postorder, preorderRose, hojasRose, ramasRose, caminos, palabras, ifProc,(++!), (.!)) where

import Test.HUnit

--Definiciones de tipos
type Procesador a b = a -> [b]

-- Árboles ternarios
data AT a = Nil | Tern a (AT a) (AT a) (AT a) deriving Eq
-- RoseTrees
data RoseTree a = Rose a [RoseTree a] deriving Eq
-- Tries
data Trie a = TrieNodo (Maybe a) [(Char, Trie a)] deriving Eq


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

procRaizTrie :: Procesador (Trie a) (Maybe a)
procRaizTrie (TrieNodo n hijos) = [n]

procSubTries :: Procesador (Trie a) (Char, Trie a)
procSubTries (TrieNodo n hijos) = hijos


--Ejercicio 2

foldAT :: b -> (a -> b -> b -> b -> b) -> AT a -> b
foldAT cNil cTern t = case t of
        Nil -> cNil
        Tern n i m d-> cTern n (rec i) (rec m) (rec d)
        where rec = foldAT cNil cTern

foldRose :: (a ->[b] -> b) ->RoseTree a -> b
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
preorder = foldAT [] f
                where f = \v i m d -> [v] ++ i ++ m ++ d

postorder :: AT a -> [a]
postorder = foldAT [] g
                where g = \v i m d -> i ++ m ++ d ++ [v]

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

palabras :: Eq a => Trie a -> [String]
palabras = foldTrie cTrieNodo
    where
        cTrieNodo valor hijos = if valor /= Nothing then "" : subcaminos else subcaminos
            where
                subcaminos = concatMap (\(c, cs) -> map (c:) cs) hijos


--Ejercicio 8
-- 8.a)

ifProc :: (a->Bool) -> Procesador a b -> Procesador a b -> Procesador a b
ifProc p proc1 proc2 = \x -> if p x then proc1 x else proc2 x

-- 8.b)
(++!) :: Procesador a b -> Procesador a b -> Procesador a b
(++!) proc1 proc2 = \x -> proc1 x ++ proc2 x

-- 8.c)
(.!) :: Procesador b c -> Procesador a b -> Procesador a c
(.!) proc1 proc2 = \x -> foldr (\x rec -> proc1 x ++ rec) [] (proc2 x)
-- o (.!) proc1 proc2 x = foldr (\x rec -> proc1 x ++ rec) [] (proc2 x)


{-Tests-}

main :: IO Counts
main = do runTestTT allTests

allTests = test [
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

-- ATs de ejemplo

atVacio :: AT Int
atVacio = Nil

at1 :: AT Int
at1 = Tern 3 Nil Nil Nil

at3 :: AT Int
at3 = Tern 5
        (Tern 15
            (Tern 12 Nil Nil Nil)
            (Tern 11 Nil Nil Nil)
            Nil)
        (Tern 3
            (Tern 2 Nil Nil Nil)
            (Tern 8 Nil Nil Nil)
            Nil)
        (Tern 7
            (Tern 1 Nil Nil Nil)
            Nil
            Nil)

at2 :: AT Int
at2 = Tern 16
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

atChar :: AT Char
atChar = Tern 'A'
            (Tern 'B'
                (Tern 'D' Nil Nil Nil)
                (Tern 'E' Nil Nil Nil)
                (Tern 'F' Nil Nil Nil))
            (Tern 'C'
                (Tern 'G' Nil Nil Nil)
                (Tern 'H' Nil Nil Nil)
                (Tern 'I' Nil Nil Nil))
            (Tern 'J'
                (Tern 'K' Nil Nil Nil)
                (Tern 'L' Nil Nil Nil)
                (Tern 'M' Nil Nil Nil))


-- RoseTrees de ejemplo

roseTree1 :: RoseTree Int
roseTree1 = Rose 5 []

roseTree2 :: RoseTree Int
roseTree2 = Rose 1
                [Rose 2 [],
                 Rose 3
                    [Rose 6 []],
                 Rose 4 [],
                 Rose 5
                    [Rose 7 [],
                    Rose 8 []]]

roseTree3 :: RoseTree Int
roseTree3 = Rose 2
                [Rose 3
                    [Rose 10 [],
                     Rose 20 [],
                     Rose 30 []],
                 Rose 5
                    [Rose 1 []],
                 Rose 7 [],
                 Rose 8
                    [Rose 4 [],
                     Rose 6 []]]

roseTreeChar :: RoseTree Char
roseTreeChar = Rose 'A'
                [Rose 'B'
                    [Rose 'D' [],
                     Rose 'E' []],
                 Rose 'C'
                    [Rose 'F'
                        [Rose 'G' []],
                     Rose 'H' []]]

-- Tries de ejemplo

trieVacio :: Trie Bool
trieVacio = TrieNodo Nothing []

trie1 :: Trie Bool
trie1 = TrieNodo (Just True) [('a', TrieNodo (Just True) [])]

trie2 :: Trie Bool
trie2 = TrieNodo Nothing
      [ ('a', TrieNodo (Just True) [])
      , ('b', TrieNodo Nothing
          [ ('a', TrieNodo (Just True)
              [ ('d', TrieNodo Nothing [])
              ])
          ])
      , ('c', TrieNodo (Just True) [])
      ]

trie3 :: Trie Bool
trie3 = TrieNodo Nothing
        [('i', TrieNodo Nothing
            [('r', TrieNodo (Just True)
                [('e', TrieNodo (Just True) [])])]),
         ('c',TrieNodo Nothing
            [('a' ,TrieNodo Nothing
                [('s', TrieNodo Nothing
                    [('a' ,TrieNodo (Just True) []),
                     ('o' ,TrieNodo (Just True) [])])])])]

trieDicc :: Trie String
trieDicc = TrieNodo Nothing
        [('f', TrieNodo Nothing
            [('a', TrieNodo (Just "sus. m. Cuarta nota musical.")
                [('c', TrieNodo Nothing
                    [('i', TrieNodo Nothing
                        [('l', TrieNodo (Just "adj. Que se consigue, realiza o entiende sin mucho esfuerzo.") [])])])])]),
        ('g', TrieNodo Nothing
            [('a', TrieNodo Nothing
                [('t', TrieNodo Nothing
                    [('a', TrieNodo (Just "sus. f. animal que hace miau.") []),
                     ('o', TrieNodo (Just "sus. m. animal que hace miau.")
                        [('s', TrieNodo (Just "sus. m. p. animales que hacen miau.") [] )])]),
                 ('n', TrieNodo Nothing
                    [('a', TrieNodo Nothing
                        [('r', TrieNodo (Just "verb. Obtener algo como relustado de un esfuerzo.") [])])])])]),
        ('h', TrieNodo Nothing
            [('a', TrieNodo Nothing
                [('s', TrieNodo Nothing
                    [('k', TrieNodo Nothing
                        [('e', TrieNodo Nothing
                            [('l', TrieNodo Nothing
                                [('l', TrieNodo (Just "sus. Lenguaje de programación de tipo funcional.") [])])])])])])])]

listaVacia :: [Int]
listaVacia = []

lista1 :: [Char]
lista1 = ['A']

lista2 :: [Int]
lista2 = [1, 2, 3, 4]

lista3 :: [Bool]
lista3 = [False, True, True, False, True]



testsEj1 = test [
    -- a
    procVacio at1
        ~=? ([] :: [Int]),
    procVacio atChar
        ~=? ([] :: [String]),
    procVacio roseTree1
        ~=? ([] :: [Int]),

    -- b
    procId lista2
        ~=? [[1, 2, 3, 4]],
    procId at1
        ~=? [Tern 3 Nil Nil Nil],
    procId roseTree1
        ~=? [Rose 5 []],
    procId trie1
        ~=? [TrieNodo (Just True) [('a', TrieNodo (Just True) [])]],

    -- c
    procCola lista1
        ~=? [],
    procCola lista2
        ~=? [2, 3, 4],
    procCola listaVacia
        ~=? [],

    -- d
    procHijosRose roseTree1
        ~=? [],
    procHijosRose roseTree3
        ~=? [Rose 3
                [Rose 10 [],
                 Rose 20 [],
                 Rose 30 []],
             Rose 5
                [Rose 1 []],
             Rose 7 [],
             Rose 8
                [Rose 4 [],
                 Rose 6 []]],
    procHijosRose roseTreeChar
        ~=? [Rose 'B'
                [Rose 'D' [],
                 Rose 'E' []],
             Rose 'C'
                [Rose 'F'
                    [Rose 'G' []],
             Rose 'H' []]],
    procHijosRose roseTree2
        ~=? [Rose 2 [],
             Rose 3
                [Rose 6 []],
             Rose 4 [],
             Rose 5
                [Rose 7 [],
                Rose 8 []]],
 
    -- e
    procHijosAT atVacio
        ~=? [],
    procHijosAT at1
        ~=? [Nil, Nil, Nil],
    procHijosAT at2
        ~=? [Tern 1
                (Tern 9 Nil Nil Nil)
                (Tern 7 Nil Nil Nil)
                (Tern 2 Nil Nil Nil),
            Tern 14
                (Tern 0 Nil Nil Nil)
                (Tern 3 Nil Nil Nil)
                (Tern 6 Nil Nil Nil),
            Tern 10
                (Tern 8 Nil Nil Nil)
                (Tern 5 Nil Nil Nil)
                (Tern 4 Nil Nil Nil)],
    procHijosAT atChar
        ~=? [Tern 'B'
                (Tern 'D' Nil Nil Nil)
                (Tern 'E' Nil Nil Nil)
                (Tern 'F' Nil Nil Nil),
            Tern 'C'
                (Tern 'G' Nil Nil Nil)
                (Tern 'H' Nil Nil Nil)
                (Tern 'I' Nil Nil Nil),
            Tern 'J'
                (Tern 'K' Nil Nil Nil)
                (Tern 'L' Nil Nil Nil)
                (Tern 'M' Nil Nil Nil)],
    
    -- f
    procRaizTrie trieVacio
        ~=? [Nothing],
    procRaizTrie trie1
        ~=? [(Just True)],

    -- g
    procSubTries trieVacio
        ~=? [],
    procSubTries trie1
        ~=? [('a', TrieNodo (Just True) [])],
    procSubTries trie2
        ~=? [ ('a', TrieNodo (Just True) []),
              ('b', TrieNodo Nothing
                [ ('a', TrieNodo (Just True)
                    [ ('d', TrieNodo Nothing [])])]),
              ('c', TrieNodo (Just True) [])],
    procSubTries trieDicc
        ~=? [('f', TrieNodo Nothing
                [('a', TrieNodo (Just "sus. m. Cuarta nota musical.")
                    [('c', TrieNodo Nothing
                        [('i', TrieNodo Nothing
                            [('l', TrieNodo (Just "adj. Que se consigue, realiza o entiende sin mucho esfuerzo.") [])])])])]),
            ('g', TrieNodo Nothing
                [('a', TrieNodo Nothing
                    [('t', TrieNodo Nothing
                        [('a', TrieNodo (Just "sus. f. animal que hace miau.") []),
                         ('o', TrieNodo (Just "sus. m. animal que hace miau.")
                            [('s', TrieNodo (Just "sus. m. p. animales que hacen miau.") [] )])]),
                     ('n', TrieNodo Nothing
                        [('a', TrieNodo Nothing
                            [('r', TrieNodo (Just "verb. Obtener algo como relustado de un esfuerzo.") [])])])])]),
            ('h', TrieNodo Nothing
                [('a', TrieNodo Nothing
                    [('s', TrieNodo Nothing
                        [('k', TrieNodo Nothing
                            [('e', TrieNodo Nothing
                                [('l', TrieNodo Nothing
                                    [('l', TrieNodo (Just "sus. Lenguaje de programación de tipo funcional.") [])])])])])])])]
  ]

testsEj2 = test [
    -- foldAT
    -- Cantidad de nodos de un AT
    foldAT 0 (\_ i m d -> 1 + i + m + d) atVacio
        ~=? 0,
    foldAT 0 (\_ i m d -> 1 + i + m + d) at1
        ~=? 1,
    foldAT 0 (\_ i m d -> 1 + i + m + d) at2
        ~=? 13,
    -- Altura de un AT
    foldAT 0 (\_ i m d -> 1 + max i (max m d)) atVacio
        ~=? 0,
    foldAT 0 (\_ i m d -> 1 + max i (max m d)) at2
        ~=? 3,

    -- foldRose
    -- Cantidad de nodos de un RoseTree
    foldRose (\_ hijos -> 1 + sum hijos) roseTree1
        ~=? 1,
    foldRose (\_ hijos -> 1 + sum hijos) roseTree2
        ~=? 8,
    foldRose (\_ hijos -> 1 + sum hijos) roseTree3
        ~=? 11,
    -- Altura de un RoseTree
    foldRose (\_ hijos -> 1 + maximum (0 : hijos)) roseTree1
        ~=? 1,
    foldRose (\_ hijos -> 1 + maximum (0 : hijos)) roseTree2
        ~=? 3,
    foldRose (\_ hijos -> 1 + maximum (0 : hijos)) roseTreeChar
        ~=? 4,

    -- foldTrie
    -- Cantidad de nodos de un Trie
    foldTrie (\_ hijos -> 1 + sum (map snd hijos)) trie1
        ~=? 2,
    foldTrie (\_ hijos -> 1 + sum (map snd hijos)) trie2
        ~=? 6,
    -- Altura de un Trie
    foldTrie (\_ hijos -> 1 + maximum (0 : map snd hijos)) trie1
        ~=? 2,
    foldTrie (\_ hijos -> 1 + maximum (0 : map snd hijos)) trie2
        ~=? 4
  ]

testsEj3 = test [
    -- a
    unoxuno listaVacia
      ~=? [],
    unoxuno lista1
      ~=? [['A']],
    unoxuno lista2
      ~=? [[1], [2], [3], [4]],

    -- b
    sufijos listaVacia
      ~=? [[]],
    sufijos lista1
      ~=? ["A", ""],
    sufijos lista2
      ~=? [[1, 2, 3, 4], [2, 3, 4], [3, 4], [4], []]
  ]

testsEj4 = test [
    -- a
    preorder atVacio
        ~=? [],
    preorder at1
        ~=? [3],
    preorder at2
        ~=? [16, 1, 9, 7, 2, 14, 0, 3, 6, 10, 8, 5, 4],

    -- b
    postorder atVacio
        ~=? [],
    postorder at1
        ~=? [3],
    postorder at2
        ~=? [9, 7, 2, 1, 0, 3, 6, 14, 8, 5, 4, 10, 16],

    -- c
    inorder atVacio
        ~=? [],
    inorder at1
        ~=? [3],
    inorder at2
        ~=? [9, 7, 1, 2, 0, 3, 14, 6, 16, 8, 5, 10, 4]
  ]

testsEj5 = test [
    -- a
    preorderRose roseTree1
        ~=? [5],
    preorderRose roseTree2
        ~=? [1, 2, 3, 6, 4, 5, 7, 8],
    preorderRose roseTree3
        ~=? [2, 3, 10, 20, 30, 5, 1, 7, 8, 4, 6],

    -- b
    hojasRose roseTree1
        ~=? [5],
    hojasRose roseTree2
        ~=? [2, 6, 4, 7, 8],
    hojasRose roseTree3
        ~=? [10, 20, 30, 1, 7, 4, 6],

    -- c
    ramasRose roseTree1
        ~=? [[5]],
    ramasRose roseTree2
        ~=? [[1, 2], [1, 3, 6], [1, 4], [1, 5, 7], [1, 5, 8]],
    ramasRose roseTree3
        ~=? [[2, 3, 10], [2, 3, 20], [2, 3, 30], [2, 5, 1], [2, 7], [2, 8, 4], [2, 8, 6]]
  ]

testsEj6 = test [
    caminos trieVacio
        ~=? [""],
    caminos trie1
        ~=? ["","a"],
    caminos trie2
        ~=? ["","a","b","ba","bad","c"],
    caminos trieDicc
        ~=? ["","f","fa","fac","faci","facil","g","ga","gat","gata","gato","gatos","gan","gana","ganar","h","ha","has","hask","haske","haskel","haskell"]
  ]

testsEj7 = test [
    palabras trieVacio
        ~=? [],
    palabras trie1
        ~=? ["","a"],
    palabras trie3
        ~=? ["ir","ire","casa","caso"],
    palabras trieDicc
        ~=? ["fa","facil","gata","gato","gatos","ganar","haskell"]
  ]

testsEj8a = test [
    ifProc ((>4).length$) sufijos unoxuno listaVacia
        ~=? [],
    ifProc ((>4).length$) sufijos unoxuno lista2
        ~=? [[1], [2], [3], [4]],
    ifProc ((>4).length$) sufijos unoxuno lista3
        ~=? [[False, True, True, False, True], [True, True, False, True], [True, False, True], [False, True], [True], []]
  ]

testsEj8b = test [
    (hojasRose ++! preorderRose) roseTree2
        ~=? [2, 6, 4, 7, 8, 1, 2, 3, 6, 4, 5, 7, 8],
    (procId ++! unoxuno) lista2
        ~=? [[1, 2, 3, 4], [1], [2], [3], [4]],
    (preorder ++! postorder) at3
        ~=? [5, 15, 12, 11, 3, 2, 8, 7, 1, 12, 11, 15, 2, 8, 3, 1, 7, 5]
  ]

testsEj8c = test [
    (preorderRose  .! procHijosRose) roseTree2
        ~=? [2, 3, 6, 4, 5, 7, 8],
    (inorder   .! procHijosAT ) at3
        ~=? [12, 11, 15, 2, 8, 3, 1, 7],
    ((\z->[0..z]) .! (map (+1))) [1, 3]
        ~=? [0, 1, 2, 0, 1, 2, 3, 4]
  ]


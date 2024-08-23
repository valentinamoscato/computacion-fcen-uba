# Teórica 1 - 23 de Agosto

# **Esquemas de recursión y Tipos de datos inductivos**

## Repaso
- Las funciones `map` y `filter`

    ```
    map :: (a -> b) -> [a] -> [b]
    map f [] = []
    map f (x : xs) = f x : map f xs

    filter :: (a -> Bool) -> [a] -> [a]
    filter p [] = []
    filter p (x : xs) = if p x
                        then x : filter p xs
                        else filter p xs
    ```
    
- `map filter :: [(a -> Bool) -> [a]] -> [[a]]`
- Funciones *lambda*

## Esquemas de recursión sobre listas

### Recursión estructural

Dada una función `g` que tiene un caso base y un caso recursivo, la definición de `g` está dada por **recursión estructural** si

1. El caso base devuelve un valor *z* fijo (que no depende de `g`)
2. El caso recursivo no puede usar los parámetros `g` ni `xs`,
salvo en la expresión `(g xs)`

Ejemplo:

    g [] = z
    g (x : xs) = ... x ... (g xs) ...

### Plegado de listas a derecha

La función `foldr` abstrae el esquema de recursión estructural:

    foldr :: (a -> b -> b) -> b -> [a] -> b
    foldr f z [] = z
    foldr f z (x : xs) = f x (foldr f z xs)

**Toda recursión estructural es una instancia de `foldr`.**

Ejemplo:

```
reverse :: [a] -> [a]
reverse [] = []
reverse (x : xs) = reverse xs ++ [x]

reverseConFoldr :: [a] -> [a]
reverseConFoldr = foldr (\ x rec -> rec ++ [x]) []
```

### Recursión primitiva

Dada una función `g` que tiene un caso base y un caso recursivo, la definición de `g` está dada por **recursión primitiva** si

1. El caso base devuelve un valor *z* fijo (que no depende de `g`)
2. El caso recursivo no puede usar los parámetros `g`,
salvo en la expresión `(g xs)`, sí puede usar el parámetro `xs`

Ejemplo:

    g [] = z
    g (x : xs) = ... x ... xs ... (g xs) ...
    
**Similar a la recursión estructural, pero permite referirse a xs.**

Observación

- Todas las definiciones dadas por recursión estructural
también están dadas por recursión primitiva.

- Hay definiciones dadas por recursión primitiva
que no están dadas por recursión estructural.

Escribamos una función `recr` para abstraer el esquema de recursión primitiva:

    recr f z [] = z
    recr f z (x : xs) = f x xs (recr f z xs)
    recr :: (a -> [a] -> b -> b) -> b -> [a] -> b

**Toda recursión primitiva es una instancia de `recr`.**

### Recursión iterativa

Dada una función `g` que tiene un caso base y un caso recursivo, la definición de `g` está dada por **recursión iterativa** si

1. El caso base devuelve el acumulador *ac* fijo
2. El caso recursivo invoca inmediatamente a `(g ac' xs)`, donde `ac'` es el acumulador actualizado en función de su valor anterior y el valor de `x`.

Ejemplo:

    reverseConAcumulador :: [a] -> [a] -> [a]
    reverseConAcumulador ac [] = ac
    reverseConAcumulador ac (x : xs) = reverseConAcumulador (x : ac) xs

### Plegado de listas a izquierda

La función `foldl` abstrae el esquema de recursión iterativa:

    foldl :: (b -> a -> b) -> b -> [a] -> b
    foldl f ac [] = ac
    foldl f ac (x : xs) = foldl f (f ac x) xs

**Toda recursión iterativa es una instancia de `foldl`.**

En general `foldr` y `foldl` tienen comportamientos diferentes:

    foldr (⋆) z [a, b, c] = a ⋆ (b ⋆ (c ⋆ z))
    foldl (⋆) z [a, b, c] = ((z ⋆ a) ⋆ b) ⋆ c
    
Si (⋆) es un operador asociativo y conmutativo, `foldr` y `foldl` definen la misma función. Por ejemplo:

    suma = foldr (`+`) 0 = foldl (`+`) 0
    producto = foldr (`*`) 1 = foldl (`*`) 1
    and = foldr (`&&`) True = foldl (`&&`) True
    or = foldr (`||`) False = foldl (`||`) False

## Tipos de datos algebraicos

Si bien existen los tipos de datos "primitivos", también podemos definir nuevos tipos de datos con la cláusula `data`.

`data Tipo = ⟨declaración de los constructores⟩`

En general un tipo de datos algebraico tiene la siguiente forma:

    data T = CBase1 ⟨parámetros⟩
    ...
    | CBase_n ⟨parámetros⟩
    | CRecursivo_1 ⟨parámetros⟩
    ...
    | CRecursivo_m ⟨parámetros⟩
    
- Los constructores base no reciben parámetros de tipo `T`.
- Los constructores recursivos reciben al menos un parámetro de tipo `T`.
- Los valores de tipo `T` son los que se pueden construir aplicando constructores base y recursivos un número finito de veces y sólo esos.

## Esquemas de recursión sobre otras estructuras

La recursión estructural se generaliza a tipos algebraicos en general.

Supongamos que `T` es un tipo algebraico.

Dada una recursión `g :: T -> Y` definida por ecuaciones:

    g (CBase_1 ⟨parámetros⟩) = ⟨caso base 1⟩
    ...
    g (CBase_n ⟨parámetros⟩) = ⟨caso base n⟩
    g (CRecursivo_1 ⟨parámetros⟩) = ⟨caso recursivo 1⟩
    ...
    g (CRecursivo_m ⟨parámetros⟩) = ⟨caso recursivo m⟩

Decimos que `g` está dada por recursión estructural si:
1. Cada caso base se escribe combinando los parámetros.
2. Cada caso recursivo:
   1. No usa la recursión `g`.
   2. No usa los parámetros del constructor que son de tipo `T`.
   3. Pero puede:
      1. Hacer llamados recursivos sobre parámetros de tipo `T`.
      2. Usar los parámetros del constructor que no son de tipo `T`.

### Casos degenerados de recursión estructural

Es recursión estructural (no usa la cabeza):

    length :: [a] -> Int
    length [] = 0
    length (_ : xs) = 1 + length xs
    
Es recursión estructural (no usa el llamado recursivo sobre la cola):

    head :: [a] -> a
    head [] = error "No tiene cabeza."
    head (x : _) = x

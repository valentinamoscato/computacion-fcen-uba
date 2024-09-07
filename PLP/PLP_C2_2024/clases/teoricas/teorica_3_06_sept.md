# Teórica 3 - 06 de Septiembre

# **Intérpretes**

## Introducción

Un intérprete es un programa que ejecuta **programas**.

Involucra dos lenguajes de programación:

- **Lenguaje de implementación**: Lenguaje en el que está definido el intérprete. En nuestro caso, Haskell.
- **Lenguaje fuente**: Lenguaje en el que están escritos los programas que se interpretan. En nuesto caso, definiremos intérpretes para distintos lenguajes fuentes minimalistas (imperativos y funcionales).

### Sintáxis concreta vs. sintáxis abstracta

El intérprete recibe como entrada un dato que representa un programa escrito en el lenguaje fuente.

#### Sintáxis concreta

Se puede representar un programa como una **cadena de texto**.

#### Sintáxis abstracta

Se puede representar como un **árbol de sintáxis**.

Nosotros representaremos los programas como árboles de sintáxis abstracta.
La conversión entre ambas es un problema de análisis sintáctico (queda fuera de la materia).

## Intérpretes básicos

### Lenguaje de expresiones aritméticas

Consideremos un lenguaje de expresiones aritméticas construidas inductivamente de la siguiente manera:
1. Una constante entera es una expresión
2. La suma de dos expresiones es una expresión

`   data Expr = EConstNum Int          -- 1, 2, 3, ...
              | ESuma Expr Expr     -- e1 + e2
              | EConstBool Bool`

`   data Val = VN Int
            | VB Bool`

`
    addVal :: Val -> Val -> Val
    addVal (VN n) (VN m) = n + m
    addVal _ _ = error "No se pueden sumar dos cosas que no son numeros"
`

`   eval :: Expr -> Val                               -- podria hacerse con Either Int Bool
    eval (EConstNum n) = VN n                         -- Left n
    eval (EConstBool b) = VB b                        -- Right b
    eval (EAdd e1 e2) = addVal (eval e1) (eval e2)    -- suma si e1 y e2 son Int, sino tira error
`

### Definiciones locales y entornos

Queremos extender el lenguaje con definiciones locales:

`   let x = 3 in (let y = x + x in 1 + y)`

Necesitamos mantener registro del valor que tiene cada variable.

Un **entorno** es un diccionario que asocia identificadores a valores. Es como un diccionario.

Vamos a suponer que contamos con tipos:

- `Id` identificadores - (nombres de variables)
- `(Env a)` entornos que asocian identificadores a valores de tipo `a`
- 
y la siguiente interfaz:

`   emptyEnv :: Env a                      
    lookupEnv :: Env a -> Id -> a          
    extendEnv :: Env a -> Id -> a -> Env a`

### Extensión con variables y definiciones locales

Extendemos el lenguaje de expresiones:

`
    data Expr = EConstNum Int -- 1, 2, 3, ...
            | EConstBool Bool -- True, False
            | EAdd Expr Expr -- e1 + e2
            | EVar Id x -- x
            | ELet Id Expr Expr -- let x = e1 in e2
`

Problema: ¿Cuál es el resultado de evaluar `(EVar "x")`?

El intérprete ya no es una función `eval :: Expr -> Val` sino `eval :: Expr -> Env Val -> Val`.

`
    eval :: Expr -> Val                              
    eval (EConstNum n) _ = VN n                        
    eval (EConstBool b) _ = VB b                       
    eval (EAdd e1 e2) env = addVal (eval e1 env) (eval e2 env)
    eval (EVar x) env = lookupEnv env x   
    eval (ELet x e1 e2) = v2
        where
            v1 = eval e1 env
            env' = extendEnv env x v1
            v2 = eval e2 env`

En el lenguaje con declaraciones locales, una expresión no denota un valor, sino una función que devuelve un valor en función del entorno dado:

`   eval :: Expr -> (Env Val -> Val)`

## Características imperativas

Queremos extender el lenguaje con características imperativas:

1. Asignaciones: `x := e`
2. Composición secuencial: `e1; e2`

Vamos a suponer que:

1. El *valor* de la asignación es `0`. (No es muy importante, sólo una convención).
1. La semántica de la composición `e1; e2` corresponde a evaluar primero `e1`, descartando su valor, y a continuación evaluar `e2`.

Por ejemplo, el siguiente programa debería resultar en el entero 4:

`   let x = 1 in x := x + 1; x + x`

### Intérprete con memoria para un lenguaje imperativo

**Variables inmutables**

En un lenguaje puramente funcional, las variables son *inmutables*.
El entorno asocia cada variable directamente a un **valor**.

**Variables mutables**

En un lenguaje imperativo, las variables son típicamente *mutables*.

- El entorno **no** asocia cada variable a un valor.
- El entorno asocia cada variable a una **dirección de memoria**.
- Además, hay una **memoria** que asocia direcciones a valores.
- La evaluación de un programa puede modificar la memoria.

#### Memorias

Una memoria es un diccionario que asocia direcciones a valores.

Vamos a suponer que contamos con tipos:
- `Addr` direcciones de memoria
- `(Mem a)` memorias que asocian direcciones a valores de tipo `a`

y la siguiente interfaz:

`   emptyMem :: Mem a
    freeAddress :: Mem a -> Addr
    load :: Mem a -> Addr -> a
    store :: Mem a -> Addr -> a -> Mem a`

#### Extensión con asignación y composición secuencial

Extendemos el lenguaje con características imperativas:

`   data Expr =
    EConstNum Int -- 1, 2, 3, ...
    | EConstBool Bool -- True, False
    | EAdd Expr Expr -- e1 + e2
    | EVar Id -- x
    | ELet Id Expr Expr -- let x = e1 in e2
    | ESeq Expr Expr -- e1; e2
    | EAssign Id Expr -- x := e`

El resultado de evaluar una asignación (`x := e`) no puede ser sólo un valor.

El tipo del intérprete ahora será:

`eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)`

`   eval (EConstNum n) env mem0 = (VN n, mem0)                        
    eval (EConstBool b) env mem0 = (VB b, mem0)                
    eval (EAdd e1 e2) env mem0 = 
        let (v1, mem1) = eval e1 env mem0 in
            (let (v2, mem2) = eval e2 env mem1 in
                (addEval v1 v2, mem2))
    eval (EVar x) env mem0 = (load mem0 (lookupEnv x), mem0)   
    eval (ELet x e1 e2) env mem0 =
        let (v1, mem1) = eval e1 env mem0 in
            (let a = fromAddress mem1 in
                (eval e2 (extendEnv env x a) (store mem1 a v1)))
    eval (ESeq e1 e2) env mem0 =
        let (_, mem0) = eval e1 env mem0 in
            eval e2 env mem1 
    eval (EAssign x e) env mem0 =
       let (v, mem0) = eval e1 env mem0 in
       let mem2 = store mem1 (lookupEnv env x) v in
       (VN 0, mem2)`

#### Extensión con estructuras de control

Extendamos ahora el intérprete con estructuras de control:

`   data Expr =
    EConstNum Int -- 1, 2, 3, ...
    | EConstBool Bool -- True, False
    | EAdd Expr Expr -- e1 + e2
    | EVar Id -- x
    | ELet Id Expr Expr -- let x = e1 in e2
    | ESeq Expr Expr -- e1; e2
    | EAssign Id Expr -- x := e
    | ELtNum Expr Expr -- e1 < e2
    | EIf Expr Expr Expr -- if e1 then e2 else e3
    | EWhile Expr Expr -- while e1 do e2`

El tipo del intérprete ahora será:

`   eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)`

`   eval (ELtNum e1 e2) env mem0 =
        let (v1, mem1) = eval e1 env mem0 in
        let (v2, mem2) = eval e2 env mem1 in
            (isNumVal v1 v2, mem2)
    eval EIf e1 e2 e3 env mem0 = 
        let (v1, mem1) = eval e1 env mem0 in
            if isTrueVal v1
                then eval e2 env mem1
                else eval e3 env mem1
    eval EWhile e1 e2 =
        let (v1, mem1) = eval e1 env mem0 in
            if isTrueVal v1
                then
                    let (_, mem2) = eval e2 env mem1 in
                        eval (EWhile e1 e2) env mem2
                else (VN 0, mem1) 
`

## Características funcionales

Casi todos los lenguajes funcionales están basados en el **cálculo-λ**.

El cálculo-λ es un lenguaje que tiene sólo tres construcciones:

`   data Expr = EVar Id -- x
    | ELam Id Expr -- \ x -> e
    | EApp Expr Expr -- e1 e2
`

Una expresión en cálculo-λ puede ser una variable, una *lambda* o la aplicación de una expresión a otra expresión.

Es posible programar usando sólo estas construcciones.

Pero vamos a extender el cálculo-λ para que sea más cómodo y se asemeje a un lenguaje realista.

¿Cuál será el resultado de evaluar `(\x -> x + x)`? Devuelve un valor funcional.

Necesitamos extender el tipo de los valores para incluir funciones.

Primer intento (mal)

El valor de una función es su “código fuente”.

`   data Val = VN Int
    | VB Bool
    | VFunction Id Expr`

Por ejemplo, el resultado de evaluar `(\x -> x + x)` sería:

`   VFunction "x" (EAdd (EVar "x") (EVar "x"))`

Veremos en breve que esto no es correcto.

Considerar el cálculo-λ extendido con enteros y booleanos:

`   data Expr =
        EVar Id -- x
        | ELam Id Expr -- \ x -> e
        | EApp Expr Expr -- e1 e2
        | EConstNum Int -- 1, 2, 3, ...
        | EConstBool Bool -- True, False
        | EAdd Expr Expr -- e1 + e2
        | ELet Id Expr Expr -- let x = e1 in e2
        | EIf Expr Expr Expr -- if e1 then e2 else e3`

Definamos un intérprete, el tipo será

`   eval :: Expr -> Env Val -> Val`

`   eval (EVar x) env = lookupEnv env x
    eval (ELam x e) env = VFunction x e
    eval (EApp e1 e2) env =
        case eval e1 env of
            VFunction x eCuerpo ->                      -- x es el nombre del parametro y eCuerpo es el cuerpo de la funcion, dentro de la funcion que me retorna e1 evaluada en el env (si es funcion, devuelve un VFunction, y sino, tira error -ultima linea-)
                let v2 = eval e2 env in
                    eval eCuerpo (extendEnv env x v2)
            -> error "No se puede aplicar algo que no sea una funcion"
    eval (EConstNum n) env = VN n
    eval (EConstBool b) env = VB b
    eval (EAdd e1 e2) env = addVal (eval e1 env) (eval e2 env)
    eval (ELet x e1 e2) env = eval e2 (extendEnv env x (eval e1 env))
    eval (EIf e1 e2 e3) env =
        if isTrueVal (eval e1 env)
            then eval e2 env
            else eval e3 env
`

Esto "está mal". ¿Qué pasa si evaluamos el siguiente programa con este intérprete?

`   let suma = \ x -> \ y -> x + y in
    let f = suma 5 in
    let x = 0 in
    f 3
`

`suma` es una función que recibe dos parámetros y los suma, `f` es la función que suma 5 y `x` está evaluada en 0. Debería dar 8 pero da 3.

`f` queda definida como `VFunction "y" (EAdd (EVar "x") (EVar "y"))`, donde `x` está **libre**.

### Intérprete funcional (con clausuras)

Segundo intento

El valor de una función es una **clausura**.

Una clausura es un valor que incluye:

1. El código fuente de la función.
2. Un entorno que le da valor a todas las variables libres.

`   data Val = VN Int
        | VB Bool
        | VClosure Id Expr (Env Val)
`

Definir un intérprete usando clausuras:

`   eval :: Expr -> Env Val -> Val`

`   eval (ELam x e) env = VClosure x e env
    eval (EApp e1 e2) env =
        case eval e1 env of
            VClosure x eCuerpo env' ->
                let v2 = eval e2 env in
                    eval eCuerpo (extendEnv env' x v2)
            -> error "No se puede aplicar algo que no sea una funcion"
`

### Estrategias de evaluación

Hay distintas técnicas para evaluar una aplicación (`e1 e2`).

Estas técnicas se conocen como estrategias de evaluación.
El intérprete que hicimos recién usa la siguiente estrategia:

#### Llamada por valor (*call-by-value*):
- Se evalúa e1 hasta que sea una clausura.
- Se evalúa e2 hasta que sea un valor.
- Se procede con la evaluación del cuerpo de la función.
- El parámetro queda ligado al valor de e2.

- Ventaja: si no usamos el valor de `e2`, por ejemplo, no lo calculamos.
- Desventaja: pero si lo usamos muchas veces, se calcula muchas veces.

Al evaluar (`let x = e1 in e2`) se evalúa directamente `e2`.

La variable `x` queda ligada a una copia no evaluada de `e1`.

Los entornos **no** asocian identificadores a valores.
Los entornos asocian identificadores a *thunks*.

**Thunks**
Un *thunk* es un dato que incluye:

1. Una expresión no evaluada.
2. Un entorno que le da valor a todas sus variables libres.

Los *thunks* y valores se definen del siguiente modo:

`   data Thunk = TT Expr (Env Thunk)
    data Val = VN Int
    | VB Bool
    | VClosure Id Expr (Env Thunk)`

Definir un intérprete que use la estrategia *call-by-name*:

`eval :: Expr -> Env Thunk -> Val`

`   eval (EVar x) env =
        case lookupEnv env x of
            TT e env' -> eval e env
    eval (ELam x e) env = VClosure x e env
    eval (EApp e1 e2) env =
        case eval e1 env of
            VClosure x eCuerpo env' ->
                eval eCuerpo (extendEnv env' x (TT e2 env))
            -> error "No se puede aplicar algo que no sea una funcion"
    eval (EConstNum n) env = VN n
    eval (EConstBool b) env = VB b
    eval (EAdd e1 e2) env = addVal (eval e1 env) (eval e2 env)
    eval (ELet x e1 e2) env = eval e2 (extendEnv env x (TT e1 env))
    eval (EIf e1 e2 e3) env =
        if isTrueVal (eval e1 env)
            then eval e2 env
            else eval e3 env
`

Hay otras estrategias de evaluación.

#### Llamada por nombre (*call-by-name*):
Se evalúa e1 hasta que sea una clausura.
Se procede directamente a evaluar el cuerpo de la función.
El parámetro queda ligado a la expresión e2 sin evaluar.
Cada vez que se usa el parámetro, se evalúa la expresión e2.

#### Llamada por necesidad (*call-by-need*):

Para evaluar una aplicación (`e1 e2`):

- Se evalúa `e1` hasta que sea una clausura.
- Se procede **directamente** a evaluar el cuerpo de la función.
- El parámetro queda ligado a la expresión `e2` **sin evaluar**.
- La primera vez que el parámetro se necesita, se evalúa `e2`.
- Se guarda el resultado para evitar evaluar `e2` nuevamente.

Para esto se necesita contar con una memoria **mutable**.

Esta estrategia es la que usa Haskell.

**Valores**

En *call-by-need* hay dos tipos de valores:

1. Valores finales (enteros, booleanos, clausuras, etc.).
2. Valores pendientes de ser evaluados (*thunks*).

`   data Val = VN Int
        | VB Bool
        | VClosure Id Expr (Env Addr)
        | VThunk Expr (Env Addr)`

Propiedades de la evaluación *call-by-need*

1. El entorno asocia identificadores a direcciones.
2. La memoria asocia direcciones a valores finales o *thunks*.
3. El resultado de evaluar una expresión es un valor final.
   
Definir un intérprete que use la estrategia *call-by-need*:

`   eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)`

`   eval (EVar x) env mem0 =
        let a = lookupEnv env x in
            case load mem0 a of
                Vthunk e env' ->
                   let (v, mem1) eval e env' mem0 in
                    (v, store mem1 a v)
                v -> (v, mem0)
    eval (ELam x e) env mem0 = (VClosure x e env, mem0)
    eval (EApp e1 e2) env mem0 =
        let (v1, mem1) = eval e1 env mem0 in
            case v1 of
                VClosure x eCuerpo env' ->
                    let a = freeAddress mem1 in
                        eval eCuerpo (extendEnv' x a) (store mem1 a (TT e2 env))
                _ -> "No se puede aplicar algo que no es una función"
    eval (EConstNum n) env mem0 = (VN n, mem0)
    eval (EConstBool b) env mem0 = (VB b, mem0)
    eval (EAdd e1 e2) env mem0 =
        let (v1, mem1) = eval e1 env mem0 in
        let (v2, mem2) = eval e2 env mem1 in
            (addVal v1 v2, mem2)
    eval (ELet x e1 e2) env mem0 =
        let a = freeAddress mem0 in
            eval e2 (extendEnv x env a) (store mem0 a (TT e1 env))
    eval (EIf e1 e2 e3) env mem0 =
        let (v1, mem1) = eval e1 env mem0 in
            if isTrueVal v1
                then eval e2 env mem1
                else eval e3 env mem1
`

## Efectos

### Propagación y manejo de errores

Extendemos el lenguaje de expresiones aritméticas:

`   data Expr = EConstNum Int -- 1, 2, 3, ...
        | EAdd Expr Expr -- e1 + e2
        | EVar Id -- x
        | ELet Id Expr Expr -- let x = e1 in e2
        | EDiv Expr Expr -- e1 / e2
        | ETry Expr Expr -- try e1 else e2`

- El operador de división falla si el divisor es 0.
- La estructura de control (`try e1 else e2`) evalúa `e1` y, en caso de falla, procede a evaluar `e2`.

Definir un intérprete:

`   eval :: Expr -> Env Int -> Maybe Int`

`   eval (EConstNum n) env = Just n
    eval (EAdd e1 e2) env =
        case eval e1 env of
            Nothing -> Nothing
            Just n1 ->
                case eval e2 env of
                    Nothing -> Nothing
                    Just n2 -> Just (n1 + n2)
    eval (EVar x) = Just (lookupEnv env x)
    eval (ELet x e1 e2) env =
        case eval e1 env of
            Nothing -> Nothing
            Just n1 -> eval e2 (extend env x n1)
    eval (EDiv e1 e2) env = 
        case eval e1 env of
            Nothing -> Nothing
            Just n1 -> case eval e2 env of
                Nothing -> Nothing
                Just n2 ->
                    if n2 == 0
                        then Nothing
                        else Just n1 div n2
    eval (ETry e1 e2) env =
        case eval e2 env of
            Nothing -> eval e2 env
            Just n1 -> Just n1
`

### No determinismo
Extendemos el lenguaje de expresiones aritméticas:

`   data Expr = EConstNum Int -- 1, 2, 3, ...
    | EAdd Expr Expr -- e1 + e2
    | EVar Id -- x
    | ELet Id Expr Expr -- let x = e1 in e2
    | EAmb Expr Expr -- amb e1 e2`

El operador (`amb e1 e2`) elige entre `e1` y `e2` de manera no determinística.

Definir un intérprete:

`   eval :: Expr -> Env Int -> [Int]`


`   eval (EConstNum n) env = [n]
    eval (EAdd e1 e2) env = [n1 + n2 | n1 <- eval e1 env, n2 <- eval n2 env]
    eval (EVar x) = [lookupEnv env x]
    eval (ELet x e1 e2) env =
        concat [eval e2 (extended env x v1) | v1 <- eval e1 env]
    eval (EAmb e1 e2) env = eval e1 env ++ eval e2 env
`

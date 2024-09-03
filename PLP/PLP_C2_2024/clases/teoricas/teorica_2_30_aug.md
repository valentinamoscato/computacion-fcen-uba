# Teórica 2 - 30 de Agosto

# **Razonamiento ecuacional e Inducción estructural**

## Equivalencia

### Hipótesis de trabajo

Para razonar sobre equivalencia de expresiones vamos a asumir:

1. Que trabajamos con estructuras de datos finitas. Técnicamente: con tipos de datos inductivos.
2. Que trabajamos con funciones totales: las ecuaciones deben cubrir todos los casos y la recursión siempre debe terminar.
3. Que el programa no depende del orden de las ecuaciones

### Igualdades por definición

**Principio de reemplazo**

Sea `e1 = e2` una ecuación incluida en el programa.

Las siguientes operaciones preservan la igualdad de expresiones:

1. Reemplazar cualquier instancia de `e1` por `e2`.
2. Reemplazar cualquier instancia de `e2` por `e1`.

Si una igualdad se puede demostrar usando sólo el principio de reemplazo, decimos que la igualdad vale por definición.

## Inducción estructural

**Principio de inducción sobre booleanos**

Si `P(True)` y `P(False)` entonces `∀x :: Bool . P(x)`.

**Principio de inducción sobre pares**

Si `∀x :: a . ∀y :: b . P((x, y))` entonces `∀p :: (a, b) . P(p)`.


**Principio de inducción sobre naturales**

`data Nat = Zero | Suc Nat`

Si `P(Zero)` y `∀n :: Nat . (P(n) | => P(Suc n))`, entonces `∀n :: Nat . P(n)`.

**Principio de inducción estructural**

En el caso general, tenemos un tipo de datos inductivo:

`data T = CBase1 ⟨parámetros⟩
...
| CBasen ⟨parámetros⟩
| CRecursivo1 ⟨parámetros⟩
...
| CRecursivom ⟨parámetros⟩`

Sea `P` una propiedad acerca de las expresiones tipo `T` tal que:

- `P` vale sobre todos los constructores base de `T`,
- `P` vale sobre todos los constructores recursivos de `T`, asumiendo como hipótesis inductiva que vale para los parámetros de tipo `T`,

entonces `∀x :: T . P(x)`.

## Extensionalidad

**Extensionalidad para pares**

Usando el principio de inducción estructural, se puede probar:

Si `p :: (a, b)`, entonces `∃x :: a . ∃y :: b . p = (x, y)`.

**Extensionalidad para sumas**

`data Either a b = Left a | Right b`

Si `e :: Either a b`, entonces:
- o bien `∃x :: a . e = Left x`
- o bien `∃y :: b . e = Right y`

**Puntos de vista intensional vs. extensional**

- Punto de vista **intensional**: Dos valores son iguales si están definidos de la misma manera.
 
- Punto de vista **extensional**: Dos valores son iguales si son indistinguibles al observarlos.

### Propiedad inmediata

Sean `f, g :: a -> b`.

Si `f = g` entonces `(∀x :: a . f x = g x)`.


### Principio de extensionalidad funcional

Si `(∀x :: a . f x = g x)` entonces `f = g`

## Resumen: razonamiento ecuacional

Razonamos ecuacionalmente usando tres principios:

1. **Principio de reemplazo**
Si el programa declara que e1 = e2, cualquier instancia de e1 es igual a la correspondiente instancia de e2, y viceversa.
2. **Principio de inducción estructural**
Para probar P sobre todas las instancias de un tipo T, basta probar P para cada uno de los constructores (asumiendo la H.I. para los constructores recursivos).
3. **Principio de extensionalidad funcional**
Para probar que dos funciones son iguales, basta probar que son iguales punto a punto.

## Corrección del razonamiento ecuacional

**Corrección con respecto a observaciones**
Si demostramos `e1 = e2 :: A`, entonces:

`obs e1 ⇝ True` si y sólo si `obs e2 ⇝ True`

para toda posible “observación” `obs :: A -> Bool`.

## Isomorfismos de tipos

Decimos que dos tipos de datos `A` y `B` son **isomorfos** si:

1. Hay una función `f :: A -> B` total.
2. Hay una función `g :: B -> A` total.
3. Se puede demostrar que `g . f = id :: A -> A`.
4. Se puede demostrar que `f . g = id :: B -> B`.

Escribimos `A ≃ B` para indicar que `A` y `B` son **isomorfos**.

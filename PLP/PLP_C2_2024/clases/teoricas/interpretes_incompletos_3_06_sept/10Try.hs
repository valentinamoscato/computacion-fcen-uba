import Environment

data Expr = EConstNum Int
          | EAdd Expr Expr
          | EVar Id
          | ELet Id Expr Expr
          | EDiv Expr Expr
          | ETry Expr Expr

eval :: Expr -> Env Int -> Maybe Int
eval (EConstNum n)  env = undefined
eval (EAdd e1 e2)   env = undefined
eval (EVar x)       env = undefined
eval (ELet x e1 e2) env = undefined
eval (EDiv e1 e2)   env = undefined
eval (ETry e1 e2)   env = undefined

ejemplo :: Expr
ejemplo = ETry (EDiv (EConstNum 5) (EConstNum 0))
               (EConstNum 2)



import Environment

data Expr = EConstNum Int
          | EAdd Expr Expr
          | EVar Id
          | ELet Id Expr Expr
          | EAmb Expr Expr

eval :: Expr -> Env Int -> [Int]
eval (EConstNum n)  env = undefined
eval (EAdd e1 e2)   env = undefined
eval (EVar x)       env = undefined
eval (ELet x e1 e2) env = undefined
eval (EAmb e1 e2)   env = undefined

ejemplo :: Expr
ejemplo = 
  ELet "x" (EAmb (EConstNum 10) (EConstNum 20))
    (ELet "y" (EAmb (EConstNum 1) (EConstNum 2))
      (EAdd (EVar "x") (EVar "y")))


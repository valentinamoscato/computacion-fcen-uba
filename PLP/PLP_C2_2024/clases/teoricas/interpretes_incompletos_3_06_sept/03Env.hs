import Environment

data Expr = EConstNum Int
          | EConstBool Bool
          | EAdd Expr Expr
          | EVar Id
          | ELet Id Expr Expr

data Val = VN Int
         | VB Bool
  deriving Show

addVal :: Val -> Val -> Val
addVal (VN a) (VN b) = VN (a + b)
addVal _ _           = error "Los valores no son numéricos."

eval :: Expr -> Env Val -> Val
eval expr           env = undefined

ejemplo :: Expr
ejemplo =
  ELet "x"
    (EConstNum 5)
    (ELet "y" (EAdd (EVar "x") (EVar "x"))
      (ELet "y" (EAdd (EVar "x") (EVar "y"))
        (EVar "y")))


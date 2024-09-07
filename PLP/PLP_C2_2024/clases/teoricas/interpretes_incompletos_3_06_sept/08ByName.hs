import Environment

data Expr = EVar Id
          | ELam Id Expr
          | EApp Expr Expr
          | EConstNum Int
          | EConstBool Bool
          | EAdd Expr Expr
          | ELet Id Expr Expr
          | EIf Expr Expr Expr
  deriving Show

data Thunk = TT Expr (Env Thunk)

data Val = VN Int
         | VB Bool
         | VClosure Id Expr (Env Thunk)

instance Show Val where
  show (VN n)           = "VN " ++ show n
  show (VB b)           = "VB " ++ show b
  show (VClosure _ _ _) = "<clausura>"

addVal :: Val -> Val -> Val
addVal (VN a) (VN b) = VN (a + b)
addVal _ _           = error "Los valores no son numéricos."

isTrueVal :: Val -> Bool
isTrueVal (VB b) = b
isTrueVal _      = False

eval :: Expr -> Env Thunk -> Val
eval (EVar x)       env = undefined
eval (ELam x e)     env = undefined
eval (EApp e1 e2)   env = undefined
eval (EConstNum n)  env = undefined
eval (EConstBool b) env = undefined
eval (EAdd e1 e2)   env = undefined
eval (ELet x e1 e2) env = undefined
eval (EIf e1 e2 e3) env = undefined

ejemplo :: Expr
ejemplo =
  ELet "suma" (ELam "x"
                (ELam "y"
                  (EAdd (EVar "x") (EVar "y"))))
    (ELet "f" (EApp (EVar "suma") (EConstNum 5))
      (ELet "x" (EConstNum 0)
        (EApp (EVar "f") (EConstNum 3))))


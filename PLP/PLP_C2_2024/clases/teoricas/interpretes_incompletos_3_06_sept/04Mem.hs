import Environment
import Memory

data Expr = EConstNum Int
          | EConstBool Bool
          | EAdd Expr Expr
          | EVar Id
          | ELet Id Expr Expr
          | ESeq Expr Expr
          | EAssign Id Expr

data Val = VN Int
         | VB Bool
  deriving Show

addVal :: Val -> Val -> Val
addVal (VN a) (VN b) = VN (a + b)
addVal _ _           = error "Los valores no son numéricos."

eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)
eval (EConstNum n)  env mem0 = undefined
eval (EConstBool b) env mem0 = undefined
eval (EAdd e1 e2)   env mem0 = undefined
eval (EVar x)       env mem0 = undefined
eval (ELet x e1 e2) env mem0 = undefined
eval (ESeq e1 e2)   env mem0 = undefined
eval (EAssign x e)  env mem0 = undefined

ejemplo :: Expr
ejemplo =
  ELet "x"
    (EConstNum 5)
    (ELet "y" (EConstNum 1)
      (ESeq
        (EAssign "x" (EAdd (EVar "x") (EVar "y")))
        (ESeq
          (EAssign "x" (EAdd (EVar "x") (EVar "y")))
          (ESeq
            (EAssign "x" (EAdd (EVar "x") (EVar "y")))
            (EVar "x")))))


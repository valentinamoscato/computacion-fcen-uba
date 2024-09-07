import Environment
import Memory

data Expr = EConstNum Int
          | EConstBool Bool
          | EAdd Expr Expr
          | EVar Id
          | ELet Id Expr Expr
          | ESeq Expr Expr
          | EAssign Id Expr
          --
          | ELtNum Expr Expr
          | EIf Expr Expr Expr
          | EWhile Expr Expr

data Val = VN Int
         | VB Bool
  deriving Show

addVal :: Val -> Val -> Val
addVal (VN a) (VN b) = VN (a + b)
addVal _ _           = error "Los valores no son numéricos."

ltNumVal :: Val -> Val -> Val
ltNumVal (VN a) (VN b) = VB (a < b)
ltNumVal _ _           = error "Los valores no son numéricos."

isTrueVal :: Val -> Bool
isTrueVal (VB b) = b
isTrueVal _      = False

eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)
eval (EConstNum n)  env mem0 = undefined
eval (EConstBool b) env mem0 = undefined
eval (EAdd e1 e2)   env mem0 = undefined
eval (EVar x)       env mem0 = undefined
eval (ELet x e1 e2) env mem0 = undefined
eval (ESeq e1 e2)   env mem0 = undefined
eval (EAssign x e)  env mem0 = undefined
eval (ELtNum e1 e2) env mem0 = undefined
eval (EIf e1 e2 e3) env mem0 = undefined
eval (EWhile e1 e2) env mem0 = undefined

ejemploIf :: Expr
ejemploIf =
  ELet "x" (EConstNum 21)
    (ELet "cond" (EConstBool True)
      (EIf (EVar "cond")
              (EAdd (EVar "x") (EVar "x"))
              (EConstNum 0)))

ejemploWhile :: Expr
ejemploWhile =
  ELet "x" (EConstNum 0)
    (ELet "y" (EConstNum 1)
      (ESeq
        (EWhile (ELtNum (EVar "x") (EConstNum 7))
           (ESeq
             (EAssign "x" (EAdd (EVar "x") (EConstNum 1)))
             (EAssign "y" (EAdd (EVar "y") (EVar "y")))))
        (EVar "y")))


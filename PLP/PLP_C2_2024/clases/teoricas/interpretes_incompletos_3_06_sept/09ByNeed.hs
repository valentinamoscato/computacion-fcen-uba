import Control.Monad.State(State, evalState, get, put)

import Environment(Id, Env, emptyEnv, lookupEnv, extendEnv)
import Memory(Addr, Mem, emptyMem, freeAddress, store, load)

data Expr = EVar Id
          | ELam Id Expr
          | EApp Expr Expr

data Val = VN Int
         | VB Bool
         | VClosure Id Expr (Env Addr)
         | VThunk Expr (Env Addr)

instance Show Val where
  show (VN n)           = "VN " ++ show n
  show (VB b)           = "VB " ++ show b
  show (VClosure _ _ _) = "<clausura>"
  show (VThunk _ _)     = "<thunk>"

eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)
eval (EVar x)       env mem0 = undefined
eval (ELam x e)     env mem0 = undefined
eval (EApp e1 e2)   env mem0 = undefined
eval (EConstNum n)  env mem0 = undefined
eval (EConstBool b) env mem0 = undefined
eval (EAdd e1 e2)   env mem0 = undefined
eval (ELet x e1 e2) env mem0 = undefined
eval (EIf e1 e2 e3) env mem0 = undefined


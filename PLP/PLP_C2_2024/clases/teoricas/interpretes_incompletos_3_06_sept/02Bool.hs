
data Expr = EConstNum Int
          | EConstBool Bool
          | EAdd Expr Expr

data Val = VN Int
         | VB Bool
  deriving Show

eval :: Expr -> Val
eval expr   = undefined


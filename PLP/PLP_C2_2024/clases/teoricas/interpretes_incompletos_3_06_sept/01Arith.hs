
data Expr = EConstNum Int
          | EAdd Expr Expr

eval :: Expr -> Int
eval expr = undefined


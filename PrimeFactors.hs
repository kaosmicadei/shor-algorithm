factorize :: Integer -> (Integer, Integer)
factorize n =
  let coprimes = [ m | m <- [2..n-1], gcd m n == 1 ]
      periods  = map (evenPeriodOf n) coprimes
      factors  = filter validFactors $ zipWith (factorsOf n) coprimes periods
  in head factors
  where
    validFactors (p, q) = p < n && q < n
   
evenPeriodOf :: Integer -> Integer -> Integer
evenPeriodOf n base = go 2
  where
    go r | (base ^ r) `mod` n == 1 = r
         | otherwise = go (r+2)

factorsOf :: Integer -> Integer -> Integer -> (Integer, Integer)
factorsOf n base period = (p, q)
  where
    p = gcd (w + 1) n
    q = gcd (w - 1) n
    w = base ^ (period `div` 2)


main :: IO ()
main = mapM_ (print . factorize) [15, 35, 65, 91]
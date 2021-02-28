macro dountil(condition, expression)
  :(while true
      $expression
      if $condition; break; end
    end) |> esc
end

mutable struct SmallCoprime
  number::Int
  coprime::Int
end

SmallCoprime(n) = SmallCoprime(n, 1)

function next!(sc::SmallCoprime)
  if sc.coprime >= sc.number - 1; return nothing; end
  @dountil gcd(sc.number, sc.coprime) == 1  sc.coprime += 1
  sc.coprime
end

function solve(number::Int)
  (p, q) = (1, number)
  coprime = SmallCoprime(number)
  @dountil p < number && q < number begin
    next!(coprime)
    period = evenperiodof(coprime)
    (p, q) = getfactors(coprime, period)
  end
  (p, q)
end

function evenperiodof(sc::SmallCoprime)
  period = 2
  @dountil (sc.coprime ^ period) % sc.number == 1  period += 2
  period
end

function getfactors(sc::SmallCoprime, period)
  α = sc.coprime ^ (period ÷ 2)
  p = gcd(sc.number, α + 1)
  q = gcd(sc.number, α - 1)
  (p, q)
end


# TEST ========================================================================
map([15, 35, 65, 91]) do n
  println("The factors of $(n) are $(solve(n))")
end

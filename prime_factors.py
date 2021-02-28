from math import gcd

def solve_for(n):
    (p, q)  = (1, n)
    coprime = 1
    while p >= n or q >= n:
        coprime = next_coprime_of(n, coprime)
        period  = even_period_of(n, coprime)
        (p, q)  = factors_of(n, coprime, period)
    return (p, q)

def next_coprime_of(n, coprime):
    while True:
        coprime += 1
        if gcd(n, coprime) == 1: break
    return coprime

def even_period_of(n, base):
    period = 2
    while (base ** period) % n != 1:
        period += 2
    return period

def factors_of(n, base, period):
    base_to_half_period = base ** (period // 2)
    p = gcd(n, base_to_half_period + 1)
    q = gcd(n, base_to_half_period - 1)
    return (p, q)

for n in [15, 35, 65, 91]:
    print("The factors of {} are {}".format(n, solve_for(n)))

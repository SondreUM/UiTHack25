from random import randint, seed
import time
from Crypto.Util.number import *
from sage.all import *

# method for generating a weak prime for the curve
# https://crypto-writeup-public.hatenablog.com/entry/Pohlig-Hellman%2520Attack
def gen_weak_prime(size, smooth):
    """
    generate approximately size-bit prime p
    which p-1 factorized to p_1 * p_2 * ... * p_n and p_n is up to smooth-bit
    (it means that p-1 is <smooth>-smooth number)
    """
    p = 2
    while True:
        if p.bit_length() + smooth >= size:
            p *= getPrime(size - p.bit_length())
            if isPrime(p + 1):
                return p +1
            p = 2
        else:
            p *= getPrime(smooth + 1)

def exploring():
    """
    Tries to find curves that are suitable for solving the ECDLP
    """
    # generate curve parameters
    # y^2 = x^3 + ax + b % p
    p = gen_weak_prime(128, 32)
    F = GF(p)
    a = randint(0, p)
    b = randint(0, p)
    E = EllipticCurve(F, [a,b])
    P = E.gens()[0]

    print(f"p = {p}")
    print(f"a = {a}")
    print(f"b = {b}")
    print(f"P = {P}")

    P = E.point(P)
    N = randint(0, p)
    Q = N * P
    Q = E.point(Q)

    print(f"N = {N}")
    print(f"Q = {Q}")
    print(f"p > ord(E) is {p > E.order()}")
    
    # verify that cardinality of subgroup does not exceeed the curve order
    if not p > E.order():
        return False

    # Check that prime factors of the order of E are not too large
    print(factor(E.order()))
    for x, y in factor(E.order()):
        if len(str(x^y)) > 9:
            return False

    # solve the ECDLP       
    return ECDLP(E, P, Q)

def verify():
    """
    Prepares parameters for a curve to be solved with the ECDLP
    """
    # currently 92bit prime
    # everything needed to calculate b
    p = 161529523242686349623751199704790917899
    F = GF(p)
    a = 92844340578538294469696850346339056286
    P = (60907684355514284357902340083417101634, 130422547263342293911083337308340969533)

    # everything needed to calculate N
    b = (P[1]^2 - P[0]^3 - a * P[0]) % p
    E = EllipticCurve(F, [a, b])
    P = E.point(P)
    N = 137451353911068132518315417803784679923
    Q = N * P
    Q = E.point(Q)

    # solve the ECDLP
    ECDLP(E, P, Q)

def ECDLP(E, P, Q):
    """
    Solves the Elliptic Curve Discrete Logarithm Problem using the Pohlig-Hellman algorithm
    E: Elliptic Curve
    P: Point on E
    Q: Point N * P on E
    """
    # find all prime factors of the order of E
    order = E.order()
    factors = factor(order)
    primes = [f^q for f, q in factors]
    dlogs = []

    # calculate the discrete logarithm for each prime factor
    for fac in primes:
        Pi = (order // fac) * P
        Qi = (order // fac) * Q
        zi = discrete_log(Qi, Pi, operation="+")
        dlogs.append(zi)
        print(f"factor (modulo): {fac}, Discrete Log: {zi}")

    # Solve the system of congruences using the Chinese Remainder Theorem
    l = crt(dlogs[:count],primes[:count])

    print(P*l == Q)
    print(l)

    # check that solution is valid, and not trivial
    for dlog in dlogs:
        if dlog*P == Q:
            return False
    if not P*l == Q:
        return False
    return True

if __name__ == "__main__":
    seed(time.time())
    ret = exploring()
    while ret != True:
        ret = exploring()
    #verify()
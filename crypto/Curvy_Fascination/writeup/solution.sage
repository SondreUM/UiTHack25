from random import randint, seed
import time
from Crypto.Util.number import *
from sage.all import *

# method for generating a weak prime for the curve
# https://crypto-writeup-public.hatenablog.com/entry/Pohlig-Hellman%2520Attack
# (When you realize at 2am that you're reading a japanese blogpost on crypto math you know the rabbithole runs deep)
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
                return p + 1
            p = 2
        else:
            # number is not large enough yet
            p *= getPrime(smooth + 1)

def exploring():
    """
    Tries to find curves that are suitable for solving the ECDLP
    """
    # generate curve parameters
    # y^2 = x^3 + ax + b % p
    p = gen_weak_prime(192, 32)
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
    N = randint(10^30, 10^31)
    Q = N * P
    Q = E.point(Q)

    print(f"N = {N}")
    print(f"Q = {Q}")

    # Check that prime factors of the order of E are not too large
    print(factor(E.order()))
    field = 1
    for x, y in factor(E.order()):
        if len(str(x^y)) > 9:
            print("not enough small factors")
            return False
        field *= x^y
        if field > N:
            break


    # check that the curve is non-singular
    disc = -16*(4*a^3 + 27*b^2)
    if disc == 0:
        print("curve is singular")
        return False

    # solve the ECDLP
    return ECDLP(E, P, Q, N)

def verify():
    """
    Prepares parameters for a curve to be solved with the ECDLP
    """
    # currently 192bit prime
    # everything needed to calculate b
    p = 2764956806584226989688686315401001551002099226289509587423
    F = GF(p)
    a = 2155050678572172123446801779119078298565414489525170719637
    P = (1518590583438435859121798598425462651203845512371070974762, 367203338728152685195537113844972066559716989101776745417)

    # everything needed to calculate N
    b = (P[1]^2 - P[0]^3 - a * P[0]) % p
    print(f"b = {b}")
    E = EllipticCurve(F, [a, b])
    P = E.point(P)
    N = 8076851309726935292348958409867
    Q = N * P
    Q = E.point(Q)

    # solve the ECDLP
    ECDLP(E, P, Q, N)

def ECDLP(E, P, Q, N):
    """
    Solves the Elliptic Curve Discrete Logarithm Problem using the Pohlig-Hellman algorithm
    E: Elliptic Curve
    P: Point on E
    Q: Point N * P on E
    """
    # find all prime factors of the order of E
    order = E.order()
    factors = factor(order)
    print(f"factors: {factors}")
    primes = [f^q for f, q in factors]
    dlogs = []

    # counter for computationally viable primes
    num_primes = 0

    # calculate the discrete logarithm for each prime factor
    for i, fac in enumerate(primes):
        # stop calculation when it becomes too computationally expensive
        if fac >= 10^10:
            num_primes = i
            break

        # multiplying with (order // fac) stops the calculation from trying to solve the curve in one go
        Pi = (order // fac) * P
        Qi = (order // fac) * Q
        zi = discrete_log(Qi, Pi, operation="+")
        dlogs.append(zi)
        print(f"factor (modulo): {fac}, Discrete Log: {zi}")

    # Solve the system of congruences using the Chinese Remainder Theorem
    if num_primes > 0:
        l = crt(dlogs,primes[:i])
    else:
        l = crt(dlogs,primes)

    print(P*l == Q)
    print(l)

    # check that solution is valid, and also not trivial
    for dlog in dlogs:
        if dlog*P == Q:
            return False
    if not P*l == Q:
        return False
    return True

if __name__ == "__main__":
    # seed(time.time())
    # ret = exploring()
    # while ret != True:
    #     ret = exploring()
    verify()

from random import randint, seed
import time

def exploring():
    """
    Tries to find curves that are suitable for solving the ECDLP
    """
    # generate curve parameters
    # y^2 = x^3 + ax + b % p
    p = next_prime(2^92)
    F = FiniteField(p)
    a = randint(0, p-1)
    P = (F.random_element(), F.random_element())

    print(f"p = {p}")
    print(f"a = {a}")
    print(f"P = {P}")

    # Create/calculate the elliptic curve
    b = (P[1]^2 - P[0]^3 - a * P[0]) % p
    E = EllipticCurve(F, [a, b])
    P = E.point(P)
    N = randint(0, p)
    Q = N * P
    Q = E.point(Q)

    print(f"N = {N}")
    print(f"Q = {Q}")
    print(f"p > ord(E) is {p > E.order()}")
    print(factor(E.order()))
    
    # verify that cardinality of subgroup does not exceeed the curve order
    if not p > E.order():
        return False

    # Check that prime factors of the order of E are not too large
    for x, y in factor(E.order()):
        if len(str(x^y)) > 8:
            return False

    # solve the ECDLP       
    return ECDLP(E, P, Q)

def verify():
    """
    Prepares parameters for a curve to be solved with the ECDLP
    """
    # currently 92bit prime
    # everything needed to calculate b
    p = 79228162514264337593543950397
    F = FiniteField(p)
    a = 53733592243402496449468535509
    P = (8531568884526597726104480015, 3965280560779306635737009839)

    # everything needed to calculate N
    b = (P[1]^2 - P[0]^3 - a * P[0]) % p
    E = EllipticCurve(F, [a, b])
    P = E.point(P)
    N = 39704161044724923518801859797
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
    factors = factor(E.order())
    primes = [f^q for f, q in factors]
    dlogs = []

    # calculate the discrete logarithm for each prime factor
    for fac in primes:
        t = int(P.order()) / int(fac)
        dlog = discrete_log(t * Q,t * P, operation="+")
        dlogs += [dlog]
        print(f"factor: {fac}, Discrete Log: {dlog}")

    # Solve the system of congruences using the Chinese Remainder Theorem
    l = crt(dlogs,primes)

    print(P*l == Q)
    print(l)

    # check that solution is valid, and not trivial
    if not P*l == Q or l in dlogs:
        return False
    return True

if __name__ == "__main__":
    #seed(time.time())
    #ret = exploring()
    #while ret != True:
    #    ret = exploring()
    verify()
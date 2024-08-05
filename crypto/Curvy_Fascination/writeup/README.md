> # Curvy Fascination
> > Crypto - 500pts
>
> After monitoring the encrypted communication at EvilCorp, for a while, you finally have the information needed to crack their entire encryption scheme. And judging by the message you first choose to decrypt it would seem the inclinations of the IT guy will be on full display.
>
> Find the key N to decrypt the flag. (The upper bound of N is 34 digits, meaning $log_{10}(N) < 35$)
>

## Writeup

The motivation behind this challenge was to get more familiar with the math behind elliptic curves and possible weaknesses that exist for them.
Challenging myself to understand enough to construct/find curves suitable for the challenge.
The challenge itself is heavily inspired by ECC2 from picoCTF_2017. For a better writeup when it comes to the details of the math I recommend checking out the writeup by "pwang00".
His writeup can be found online [here](https://github.com/hgarrereyn/Th3g3ntl3man-CTF-Writeups/tree/master/2017/picoCTF_2017/problems/cryptography/ECC2/ECC2.md) or locally in a touched up version [here](ECC2.md).

I will try to explain the solution myself, but if the explanation falls short feel free to look up the writeup mentioned before as it is truly an exceptional one.

To recap what our objective is: we need to find the scalar N that makes

$Q = N * P$

With an upper bound on N that is 34 digits, but more accurately $log_{10}(N) < 35$.

Now, given that we have already calculated $b$ for the curve (in Defining Curves) we can add it to the information we know

$b = 632783634760079068257481593728378909226796967090221149792$

As the tag for this challenge eludes to it would be very beneficial to use a tool/progrmaming language that allows for efficient calculation to be done with/on elliptic curves.
For this writeup we will be using sagemath 10.2, but Mathematica and Maple has been known to work as well.
Sagemath is, for all intents and purposes, Python with math on steroids.

First off we define the field and curve we will be working on, and define P and Q as points on that curve

```sage
F = FiniteField(p)
E = EllipticCurve(F, [a, b])
P = E.point(P)
Q = E.point(Q)
```

There exists multiple ways to attack elliptic curves. The one intended for this challenge is the Pohlig-Hellman attack.
The way to confirm that this attack is viable is to check the size of the prime factors of E.
If most of them are relatively small then the Pohlig-Hellman attack is viable.

```sage
43 * 2477 * 15559 * 251918963 * 583103869 * 584585929 * 19429296133822807718719
```

Most of them are indeed relatively small. "What is small?" you might say. There's not really a perfect number for that, but generally 10 or less digits should be computationally viable on a consumer computer.
Now, all the factors are not small. That last one is looking real nasty, but all we need is enough small factors that their product is larger than the upper bound of $N$.
And indeed $log_{10}(43 * 2477 * 15559 * 251918963 * 583103869 * 584585929) > 35$. This means we should be able to disregard the large prime and still get the correct answer.

Without going into into the heavy math details of the Pohlig-Hellman attack, that attack itself can be seen as a way of incrementally expanding the size of $N$ that we can solve for.
This way one is able to disregard the computational complexity of large primes as long as there are enough small ones.
By solving the discrete logarithm for each smaller prime we are then able to use the CRT(Chinese Remainder Theorem) to solve the resulting system of congruencies and find $N$.
In our case we are then left with

$N = 8076851309726935292348958409867$

Run the [decryption file](../src/decrypt.py), paste in $N$ when asked for the key.

We are then given the [flag](../src/flag.txt) which is:

```txt
UiTHack25{B1gB34ut1fulNumb3r5}
```

## Resources

https://wstein.org/edu/2010/414/projects/novotney.pdf

https://scholar.google.com/scholar?hl=no&as_sdt=0%2C5&q=Pohlig-Hellman+Applied+in+Elliptic+Curve+Cryptography&btnG=

https://github.com/hgarrereyn/Th3g3ntl3man-CTF-Writeups/tree/master/2017/picoCTF_2017/problems/cryptography/ECC2/ECC2.md

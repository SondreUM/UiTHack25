> # Curvy Fascination
> > Crypto - 500pts
>
> After monitoring the encrypted communication at EvilCorp, for a while, you finally have the information needed to crack their entire encryption scheme. And judging by the message you first choose to decrypt it would seem the inclinations of the IT guy will be on full display.
>
> Find the key N to decrypt the flag
>

## Writeup

I acknowledge that my own understanding of the field might not be enough to fully explain everything on my own, but I will try my best.
Recognition shall be given to picoCTF_2017 for the inspiration to make the challenge, and github user "pwang00" for his excellent
writeup of the challenge.
His writeup can be found online [here](https://github.com/hgarrereyn/Th3g3ntl3man-CTF-Writeups/tree/master/2017/picoCTF_2017/problems/cryptography/ECC2/ECC2.md) or locally in a touched up version [here](ECC2.md)

I will try to explain the solution myself, but if the explanation falls short feel free to look up the writeup mentioned before as it is truly an exceptional one.

To recap what our objective is: we need to find the scalar N that makes

$Q = N * P$

Now, given that we have already calculated b for the curve (in Defining Curves) we can add it to the information we know

$b = 209128692091064461400500798718612636591$

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
If they are relatively small then the Pohlig-Hellman attack is viable.

```sage
2 * 17 * 419 * 1423 * 2503 * 8837 * 20143 * 28751 * 25447871 * 36945089
```

They are indeed relatively small. "What is small?" you might say. There's not really a perfect number for that, but generally 10 or less digits should be computationally viable on a consumer computer.
If you check the conditions at the bottom of explore() in [solution.sage](solution.sage) we used a condition of the prime factors being 9 digits or smaller when searching for a computationally viable curve for the challenge.
Important to note for sagemath, the ^ operator means exponentiation.

Skipping over the heavy details of the Pohlig-Hellman algorithm, which can be found in the resources listed at the bottom, we can summarize
our next steps as solving the discrete logarithm problem for each prime power factor of $E$ before solving that system of congruences using the
chinese remainder theorem (CRT).

## Resources

https://wstein.org/edu/2010/414/projects/novotney.pdf

https://scholar.google.com/scholar?hl=no&as_sdt=0%2C5&q=Pohlig-Hellman+Applied+in+Elliptic+Curve+Cryptography&btnG=

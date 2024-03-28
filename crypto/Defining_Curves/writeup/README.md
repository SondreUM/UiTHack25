# Crypto - Defining Cruves

> > Crypto - *points/solves*
>
> Find the constant b and use it to decrypt the flag.
>
> Files: [decrypt.py](../src/decrypt.py), [handout.txt](../src/handout.txt)

## Writeup

The handout given reads

```txt
# y^2 % p = (x^3 + ax + b) % p
p = 79228162514264337593543950397
a = 53733592243402496449468535509
P = (8531568884526597726104480015, 3965280560779306635737009839)
```

We are given the equation for an elliptic curve in the Weierstrass form.
To find b we rearrange the equation to leave b alone on one side.

$y^2 \mod p = (x^3 + ax + b) \mod p$

$y^2(x^3 + ax) \mod p = b \mod p$

We then insert the values for a and p, and insert the x and y value from the point P.
This can be seen in the python example [calculate.py](calculate.py), and we reach the conclusion:

$b = 22514939140182650645646535879$

Inserting this into [decrypt.py](../src/decrypt.py), and running the script we get the flag

```txt
UiTHack25{Curves_worth_dying_for}
```

## Resources

Include links to the original challenge, writeups, vulnerabilities, tools, etc. here
# Crypto - Defining Cruves

> > Crypto - *points/solves*
>
> Rummaging through the dumpsters behind the EvilCorp headquarters you find parts of some maculated encryption scheme calculations. This could be your team's path into the secret parts of EvilCorp.
>
> "b" is the key used as input when running decrypt.py
>
> Files: [decrypt.py](../src/decrypt.py), [handout.txt](../src/handout.txt)

## Writeup

The handout given reads

```txt
# y^2 % p = (x^3 + ax + b) % p
p = 2764956806584226989688686315401001551002099226289509587423
a = 2155050678572172123446801779119078298565414489525170719637
P = (1518590583438435859121798598425462651203845512371070974762, 367203338728152685195537113844972066559716989101776745417)
```

We are given the equation for an elliptic curve in the Weierstrass form.
To find b we rearrange the equation to leave b alone on one side.

$y^2 \mod p = (x^3 + ax + b) \mod p$

$(y^2 - (x^3 + ax)) \mod p = b \mod p$

We then insert the values for a and p, and insert the x and y value from the point P.
This can be seen in the python example [calculate.py](calculate.py), and we reach the conclusion:

$b = 632783634760079068257481593728378909226796967090221149792$

Inserting this into [decrypt.py](../src/decrypt.py), and running the script we get the flag

```txt
UiTHack25{Curves_worth_dying_for}
```

## Resources

Include links to the original challenge, writeups, vulnerabilities, tools, etc. here

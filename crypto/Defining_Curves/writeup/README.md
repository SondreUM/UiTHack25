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
p = 161529523242686349623751199704790917899
a = 92844340578538294469696850346339056286
P = (60907684355514284357902340083417101634, 130422547263342293911083337308340969533)
```

We are given the equation for an elliptic curve in the Weierstrass form.
To find b we rearrange the equation to leave b alone on one side.

$y^2 \mod p = (x^3 + ax + b) \mod p$

$(y^2 - (x^3 + ax)) \mod p = b \mod p$

We then insert the values for a and p, and insert the x and y value from the point P.
This can be seen in the python example [calculate.py](calculate.py), and we reach the conclusion:

$b = 22679512306421273518746478180967858373$

Inserting this into [decrypt.py](../src/decrypt.py), and running the script we get the flag

```txt
UiTHack25{Curves_worth_dying_for}
```

## Resources

Include links to the original challenge, writeups, vulnerabilities, tools, etc. here

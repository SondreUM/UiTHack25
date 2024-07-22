# Crypto - Pattern Recognition

> > Crypto - *points/solves*
>
> While on the run from some corpos after a failed break in attemp you get an encrypted message as you see your partner disappear from view.
>
> Files: [flag.txt.enc](../src/flag.txt.enc)

## Writeup

Looking at the pattern of the encrypted flag we can recognize that numbers
and special characters seem to remain as is. We might then assume that what
is supposed to be before "25" is "UiTHack".

Doing this we end up with a map like this

```txt
f-u
r-i
g-t
s-h
z-a
x-c
p-k
```

which can be used in a preliminary test on the entire flag which gives us

```txt
UiTHack25{g*tta_g*_fast*r_tha*_th*_sp***_*f_*ight}
```

We now see that that the flag starts to make sense, and actually look like something.
Continuing, we can expand the mapping created in a way that completes the more obvious words
like "go" and "faster". Doing this we learn that.

```txt
l-o
v-e

UiTHack25{g*tta_g*_fast*r_tha*_th*_sp***_*f_*ight} --> UiTHack25{gotta_go_faster_tha*_the_spee*_of_*ight}
```

with a quick guess to complete the remaining words we arrive at the answer

```txt
FrGSzxp25{tlggz_tl_uzhgvi_gszm_gsv_hkvvw_lu_ortsg} --> UiTHack25{gotta_go_faster_than_the_speed_of_light}
```

## Resources

Include links to the original challenge, writeups, vulnerabilities, tools, etc. here

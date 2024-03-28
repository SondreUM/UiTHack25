# crypto - Caesarian Dilemma

> > crypto - *points/solves*
>
> Decrypt the flag.
>
> Files: [flag.txt.enc](src/flag.txt.enc)

## Writeup

By seeing "25" in the encrypted flag we can go off the assumption that the
preceeding character should rightfully be "UiTHack". By checking how many
shifts it takes to recreate that string we can infer the shift distance.

If you go right/up you will conclude with 11 in shift distance, or 15 if you
go left/down. At that point all that is left is to decrypt with either a script
like done here [decrypt.go](decrypt.go) or do it by hand.

## Resources

Include links to the original challenge, writeups, vulnerabilities, tools, etc. here
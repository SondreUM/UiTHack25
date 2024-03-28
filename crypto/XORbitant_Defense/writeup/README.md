# Crypto - XORbitant Defense

> > Crypto - *points/solves*
>
> Decrypt the flag
>
> Files: [encrypt.go](../src/encrypt.go), [flag.txt.enc](../src/flag.txt.enc)

## Writeup

Inspecting [encrypt.go](../src/encrypt.go) we can notice that every
byte in the flag is XOR'd with 0xff. This is a byte of only 1s. This means
that all the bits in the flag are flipped. The rest of the program then converts
the flag into a string of bytes that are then written to the file in binary format.

As can be seen in the suggested writeup [decrypt.go](decrypt.go) all that needs
to be done is to flip all the bits and convert each byte back to ascii.

## Resources

Include links to the original challenge, writeups, vulnerabilities, tools, etc. here

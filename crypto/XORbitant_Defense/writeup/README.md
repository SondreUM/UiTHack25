# Crypto - XORbitant Defense

> > Crypto - *points/solves*
>
> The maintenance people at EvilCorp have been too lazy with the security to access the backup servers. There are some binary strings carved into the wall next to the door. Surely they can't have been stupid enough to leave the password there?
>
> Files: [encrypt.go](../src/encrypt.go), [flag.txt.enc](../src/flag.txt.enc)

## Writeup

Inspecting [encrypt.go](../src/encrypt.go) we can notice that every
byte in the flag is XOR'd with 0xff. This is a byte of only 1s. This means
that all the bits in the flag are flipped. The rest of the program then converts
the flag into a string of bytes that are then written to the file in binary format.

As can be seen in the suggested writeup [decrypt.go](decrypt.go) all that needs
to be done is to flip all the bits and convert each byte back to ascii.

```txt
10101010 10010110 10101011 10110111 10011110 10011100 10010100 11001101 11001010 10000100 10011101 10010110 10010001 11001011 10001101 10000110 10100000 10011100 11001111 10010010 10001111 11001110 11001100 10000111 10010110 10001011 10000110 10000010
-->
UiTHack25{bin4ry_c0mp13xity}
```

## Resources

Include links to the original challenge, writeups, vulnerabilities, tools, etc. here

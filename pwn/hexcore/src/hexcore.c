#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <sys/mman.h>


void ignore_me(){
    setvbuf(stdin, NULL, _IONBF, 0);
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
}

void timeout(int signal){
    if (signal == SIGALRM){
        printf("\n[-] System timeout! Exiting...\n");
        _exit(0);
    }
}

void ignore_me_timeout(){
    signal(SIGALRM, timeout);
    alarm(60);
}

void handle_segfault(int signal){
    printf("[-] Segmentation fault occurred!\n");
    _exit(1);
}

void banner() {
    puts("\n");
    puts(" __    __                    ______                             ");
    puts("|  \\  |  \\                  /      \\                            ");
    puts("| ▓▓  | ▓▓ ______  __    __|  ▓▓▓▓▓▓\\ ______   ______   ______  ");
    puts("| ▓▓__| ▓▓/      \\|  \\  /  \\ ▓▓   \\▓▓/      \\ /      \\ /      \\ ");
    puts("| ▓▓    ▓▓  ▓▓▓▓▓▓\\\\▓▓\\/  ▓▓ ▓▓     |  ▓▓▓▓▓▓\\  ▓▓▓▓▓▓\\  ▓▓▓▓▓▓\\");
    puts("| ▓▓▓▓▓▓▓▓ ▓▓    ▓▓  ▓▓  ▓▓| ▓▓   __| ▓▓  | ▓▓ ▓▓   \\▓▓ ▓▓    ▓▓");
    puts("| ▓▓  | ▓▓ ▓▓▓▓▓▓▓▓/  ▓▓▓▓\\| ▓▓__/  \\ ▓▓__/ ▓▓ ▓▓     | ▓▓▓▓▓▓▓▓");
    puts("| ▓▓  | ▓▓\\▓▓     \\  ▓▓ \\▓▓\\\\▓▓    ▓▓\\▓▓    ▓▓ ▓▓      \\▓▓     \\");
    puts(" \\▓▓   \\▓▓ \\▓▓▓▓▓▓▓\\▓▓   \\▓▓ \\▓▓▓▓▓▓  \\▓▓▓▓▓▓ \\▓▓       \\▓▓▓▓▓▓▓");
    puts("\n");
    puts("HexCore Terminal v1.0.3\n");
}

void hex_to_bytes(const char *hex, unsigned char *bytes, size_t length) {
    for (size_t i = 0; i < length; i++) {
        sscanf(hex + 2 * i, "%2hhx", &bytes[i]);
    }
}

int contains_sequence(const unsigned char *shellcode, size_t length) {
    // Sequence to detect: 'HexCore'
    const unsigned char sequence[] = { 0x48, 0x65, 0x78, 0x43, 0x6f, 0x72, 0x65 };
    size_t sequence_length = sizeof(sequence);
    
    if(length < sequence_length) {
        return 0;
    }

    for (size_t i = 0; i <= length - sequence_length; i++) {
        if (memcmp(&shellcode[i], sequence, sequence_length) == 0) {
            return 1;
        }
    }
    return 0;
}

void shell()
{
    banner();

    char hex_input[68];
    printf("[+] Insert a HexCore (max 32 bytes): ");

    if (fgets(hex_input, sizeof(hex_input), stdin) == NULL) {
        perror("[-] Error reading input");
        return;
    }

    hex_input[strcspn(hex_input, "\n")] = '\0';

    size_t hex_length = strlen(hex_input);
    printf("[+] HexCore length: %zu bytes\n", hex_length / 2);

    if (hex_length >= 2 && hex_input[0] == '0' && hex_input[1] == 'x') {
        hex_length -= 2;
        memmove(hex_input, hex_input + 2, hex_length);
    }
    if(hex_length % 2 != 0) {
        printf("[-] Invalid input length. Must be even.\n");
        return;
    }
    else if(hex_length == 0 || hex_length / 2 > 32)
    {
        printf("[-] Invalid input length. Must be <= 32 bytes.\n");
        return;
    }

    size_t byte_length = hex_length / 2;
    unsigned char *shellcode = malloc(byte_length);
    if (!shellcode) {
        perror("[-] Memory allocation failed");
        free(shellcode);
        return;
    }

    hex_to_bytes(hex_input, shellcode, byte_length);

    if (!contains_sequence(shellcode, byte_length)) {
        printf("[-] No 'HexCore' detected.\n");
        free(shellcode);
        return;
    }

    printf("[+] Loading HexCore...\n");

    printf("\n[+] HexCore successfully initiated! Executing...\n\n");

    // Allocate one page of memory with RWX permissions.
    void *exec_mem = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
                          MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    if (exec_mem == MAP_FAILED) {
        perror("mmap");
        free(shellcode);
        return;
    }

    // Copy shellcode into the executable memory region.
    memcpy(exec_mem, shellcode, byte_length);

    // Call the executable memory.
    int (*ret)() = (int(*)())exec_mem;
    ret();

    munmap(exec_mem, 4096);
    free(shellcode);
}

int main(){
    ignore_me();
    ignore_me_timeout();

    signal(SIGSEGV, handle_segfault);

    shell();
    return 0;
}

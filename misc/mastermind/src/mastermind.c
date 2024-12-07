#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <time.h>
#include <fcntl.h>
#include <unistd.h>

#define CODE_LENGTH 4
#define MAX_GUESSES 7
#define TIMEOUT 60

void ignore_me(){
    setvbuf(stdin, NULL, _IONBF, 0);
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
}

void timeout(int signal){
    if (signal == SIGALRM)
    {
        printf("\nTime's up! Security has been called!\n");
        _exit(0);
    }
}

void ignore_me_timeout(){
    signal(SIGALRM, timeout);
    alarm(TIMEOUT);
}

void print_flag(){
    char chr;
    FILE *f = fopen("flag.txt", "r");
    chr = fgetc(f);
    while (chr != EOF){
        printf("%c", chr);
        chr = fgetc(f);
    }
    fclose(f);
}

void generate_code(int code[CODE_LENGTH]){
    for (int i = 0; i < CODE_LENGTH; i++) {
        int num = rand() % 10;
        if (i > 0) {
            for (int j = 0; j < i; j++) {
                if (code[j] == num) {
                    num = rand() % 10;
                    j = -1;
                }
            }
        }

        code[i] = num;
    }
}

unsigned long generate_secure_seed() {
    unsigned long seed;
    int fd = open("/dev/urandom", O_RDONLY);
    if (fd == -1) {
        perror("open");
        return 0; 
    }
    if (read(fd, &seed, sizeof(seed)) != sizeof(seed)) {
        perror("read");
        close(fd);
        return 0;
    }
    close(fd);
    return seed;
}

void mastermind_game() {
    int code[CODE_LENGTH];
    int guess[CODE_LENGTH];
    
    generate_code(code);

    for (int attempt = 1; attempt <= MAX_GUESSES; attempt++) {
        printf("Please enter code (4 digits): ");
        for (int i = 0; i < CODE_LENGTH; i++) {
            scanf("%1d", &guess[i]);
        }

        int correct_position = 0;
        int correct_but_wrong_position = 0;

        for (int i = 0; i < CODE_LENGTH; i++) {
            if (code[i] == guess[i]) {
                correct_position++;
            } 
            else {
                for (int j = 0; j < CODE_LENGTH; j++) {
                    if (code[i] == guess[j]) {
                        correct_but_wrong_position++;
                        break;
                    }
                }
            }
        }

        if (correct_position == CODE_LENGTH) {
            printf("ACCESS GRANTED! Code ");
            for (int i = 0; i < CODE_LENGTH; i++) {
                printf("%d", code[i]);
            }
            printf(" AUTHORIZED.\n");
            printf("[+] Decrypting Classified data...\n");
            print_flag(); // Print the flag as a reward
            return;
        } else {
            printf("[?] %d digits in the correct position.\n", correct_position);
            printf("[?] %d correct digits, but in the wrong position.\n", correct_but_wrong_position);
        }
    }

    printf("Spam detection alert activated! Security has been called!\n");
}

int main() {
    ignore_me();
    ignore_me_timeout();

    unsigned long seed = generate_secure_seed();
    srand(seed);

    printf("\nWelcome Mastermind!\n\n");

    printf("[+] Establishing Secure Connection...\n");
    printf("[+] Accessing encrypted mainframe...\n");
    printf("[*] Initializing code sequence...\n");
    printf("[*] Code sequence online!\n\n");

    mastermind_game();

    return 0;
}
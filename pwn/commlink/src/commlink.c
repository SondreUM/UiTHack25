#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>


void ignore_me(){
    setvbuf(stdin, NULL, _IONBF, 0);
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
}

void timeout(int signal){
    if (signal == SIGALRM){
        printf("You timed out!\n");
        _exit(0);
    }
}

void ignore_me_timeout(){
    signal(SIGALRM, timeout);
    alarm(120);
}

void flag(){
    char flag[64];
    FILE *file = fopen("flag.txt", "r");
    if (file == NULL) {
        printf("flag.txt is missing!\n");
        exit(0);
    }
    fgets(flag, sizeof(flag), file);
    printf("%s\n", flag);
}

int main(int argc, char **argv){
    ignore_me();
    ignore_me_timeout();

    char password[32];
    char command[64];
    char *valid_password = argv[1];
    int logged_in = 0;

    printf("╔════════════════════════════╗\n║      EchoNet Commlink      ║\n║  Secure. Reliable. Trusted.║\n╚════════════════════════════╝\n");
    
    printf("[Commlink] Welcome!\n");

    while (1) {
        printf("> ");
        scanf("%63s", command);

        if (strcmp(command, "login") == 0) {
            printf("[Commlink] Insert password:\n> ");
            scanf("%31s", password);

            if (strcmp(password, valid_password) == 0) {
                logged_in = 1;
                printf("[Commlink] Login successful.\n");
            } else {
                printf("[Commlink] Password %s is not valid.\n", password);
            }
        } 
        else if (strcmp(command, "status") == 0) {
            printf("[Commlink] System operating normally. No anomalies detected.\n");
        } 
        else if (strcmp(command, "exit") == 0) {
            printf("[Commlink] Disconnecting. Goodbye.\n");
            exit(0);
        } 
        else if (strcmp(command, "help") == 0) {
            printf("[Commlink] Available commands: login, status, exit, help, mails\n");
        } 
        else if (strcmp(command, "mails") == 0) {
            if (logged_in) {
                printf("[Commlink] You have a new message. Do you want to read it? (yes/no)\n> ");
                scanf("%63s", command);
                if (strcmp(command, "yes") == 0) {
                    flag();
                    exit(0);
                }
            } else {
                printf("[Commlink] You need to login first.\n");
            }
        }
        else {
            printf(command);
            printf(": command not found\n");
        }
    }

    return 0;
}

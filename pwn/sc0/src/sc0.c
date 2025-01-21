#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>

void ignore_me(){
    setvbuf(stdin, NULL, _IONBF, 0);
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
}

void timeout(int signal){
    if (signal == SIGALRM){
        printf("System timeout! The megacorp traced you!\n");
        _exit(0);
    }
}

void ignore_me_timeout(){
    signal(SIGALRM, timeout);
    alarm(60);
}

void visualize_stack(char* buffer, size_t size){
    printf("\nAddress          | Value\n");
    printf("-----------------+----------------\n");

    for (size_t i = 0; i < size; i += 8) {
        printf("0x%p | ", (void *)(buffer + i));
        for (size_t j = 0; j < 8 && i + j < size; j++) {
            printf("%02x ", (unsigned char)buffer[i + j]);
        }
        printf("\n");
    }
}

void disable_camera(){
    printf("\nDisabling camera...\n");
    char chr;
    FILE *f = fopen("flag.txt", "r");
    if (f == NULL){
        printf("Error: flag.txt not found.\n");
        exit(1);
    }

    chr = fgetc(f);
    while (chr != EOF){
        printf("%c", chr);
        chr = fgetc(f);
    }
    printf("\n");
    fclose(f);
}

void cam_control(){
    char cam_data[48] = "enabled=true, resolution=1080p, fps=60";
    char cam_label[16] = "SC0";

    printf("\n[ %s Data Memory ]\n", cam_label);
    visualize_stack(cam_data, sizeof(cam_data));

    printf("\nEnter a new camera label for %s: ", cam_label);
    fgets(cam_label, 32, stdin);

    cam_label[strcspn(cam_label, "\n")] = 0;

    if (strncmp(cam_data, "enabled=false", 13) == 0){
        disable_camera();
    }

    printf("\n[ %s Data Memory ]\n", cam_label);
    visualize_stack(cam_data, sizeof(cam_data));
}

int main(){
    ignore_me();
    ignore_me_timeout();

    cam_control();
    return 0;
}

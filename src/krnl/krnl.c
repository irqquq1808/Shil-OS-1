// test
#include "stdint.h"

char* vidptr = (char*)0xB8000;

void print(const char* str) {
    unsigned int j = 0, i = 0;
    while (str[j] != '\0'){
        vidptr[i] = str[j];
        vidptr[i+1] = 0x07;
        i = i + 2;
        j++;
    }
}
void clear(void){
    unsigned int j = 0;
    while(j < 80*25*2){
        vidptr[j] = '\0';
        vidptr[j+1] = 0x07;
        j++;
    }
}

void kernel_main() {
    clear();
    print("ShilOS is run");
    while (1) {
        __asm__("hlt");
    }
}
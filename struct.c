#include "stdio.h"

typedef struct {
    int x;
} data;

void modify(data *d) {
    d->x = 7;
}

int main(void) {
    data d = { 5 };
    data d2 = { 6 };
    modify(&d);
    printf("%d\n", d.x);
    return 0;
}
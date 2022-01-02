void update_arr(unsigned int arr[], unsigned int v) {
    arr[1] = v;
}

unsigned a[3] = {1,2,3};
unsigned int b = 5;

int main(void) {
    update_arr(a, 4);
    unsigned int *bp = &b;
    *bp = 6;

    return 0;
}

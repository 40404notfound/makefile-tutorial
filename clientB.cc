#include "libfib.h"
#include <iostream>

int main() {
  printf("%d\n", fib_slow(10));
  printf("%d\n", fib_fast(40));
  printf("%d\n", fib_wrong(2147483647));

  return 0;
}

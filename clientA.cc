#include "libfib.h"
#include <iostream>

int main() {
  for (int i = 1; i < 1000; ++ i) {
    int slow = fib_slow(i);
    int fast = fib_fast(i);
    int wrong = fib_wrong(i);
    printf("%d: %d %d %d\n", i, slow, fast, wrong);
    if (wrong != slow) {
      fprintf(stderr, "program went wrong at %d\n", i);
      break;
    }
  }

  return 0;
}

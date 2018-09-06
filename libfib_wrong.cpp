int fib_wrong(int n) {
  if (n > 30) {
    return 0;
  }
  if (n <= 0) {
    return 0;
  }
  else if (n == 1) {
    return 1;
  }
  else {
    return fib_wrong(n - 1) + fib_wrong(n - 2);
  }
}

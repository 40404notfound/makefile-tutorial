#include <vector>

class Matrix {
  size_t n, m;
  std::vector<std::vector<int> > content;
 public:
  Matrix(size_t n, size_t m) {
    this->n = n;
    this->m = m;
    content.resize(n, std::vector<int>(m, 0));
  }

  std::vector<int> &operator[](size_t x) {
    return content[x];
  }

  Matrix operator*(Matrix rhs) {
    Matrix result(n, rhs.m);
    for (size_t x = 0; x < n; ++ x) {
      for (size_t y = 0; y < m; ++ y) {
        for (size_t z = 0; z < rhs.m; ++ z) {
          result[x][z] += content[x][y] * rhs[y][z];
        }
      }
    }

    return result;
  }
};


int fib_fast(int n) {
  Matrix base(2, 2), init(1, 2);
  base[0][0] = base[0][1] = base[1][0] = init[0][0] = 1;
  base[1][1] = init[0][1] = 0;

  while (n != 0) {
    if (n & 1) {
      init = init * base;
    }

    base = base * base;
    n >>= 1;
  }

  return init[0][1];
}

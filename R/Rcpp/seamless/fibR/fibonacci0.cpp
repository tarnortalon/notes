#include <iostream>

int fibonacci(const int x) {
  if (x == 0) return(0);
  if (x == 1) return(1);
  return (fibonacci(x - 1) + fibonacci(x - 2));
}

int main() {
  int x = 10;
  std::cout << "Fibonacci(" << x << "): " << fibonacci(10) << std::endl;
}

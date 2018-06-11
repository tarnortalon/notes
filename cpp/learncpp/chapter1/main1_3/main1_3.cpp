// An example of uninitialized variable
#include <iostream>

int main()
{
  int x; // define a variable x without initialization
  std::cout << x; // print out whatever value stored in x's memory location
  return 0;
}

# Various implementation of Fibonacci series in R and C++

1. fibR.R is a simple R-only implementation.

1. fibonacci0.cpp is a simple C++ only implementation.

1. fibRcpp.R uses `inline` package to compile a C++ function at runtime and wrap
   a R function around the C++ implementation.

1. fibonacci.cpp is a C++ file that can be compiled to create a shared object.
   fibonacci.R loads the compiled shared object and calls the wrapper function.

1. fibonacci_attr.cpp and fibonacci_attr.R are two files that together complete
   a R/C++ implementation using `Rcpp` attributes.

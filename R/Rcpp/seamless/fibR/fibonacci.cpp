/*
To compile the shared object:

PKG_CXXFLAGS=`Rscript -e 'Rcpp:::CxxFlags()'` \
PKG_LIBS=`Rscript -e 'Rcpp:::LdFlags()'` \
R CMD SHLIB fibonacci.cpp

The resulting fibonacci.so shared object can then be loaded
into R using dyn.load().
   */
#include <Rcpp.h>

int fibonacci(const int x) {
  if (x == 0) return(0);
  if (x == 1) return(1);
  return (fibonacci(x - 1) + fibonacci(x - 2));
}

extern "C" {
  SEXP fibWrapper(SEXP xs) {
    int x = Rcpp::as<int>(xs);
    int fib = fibonacci(x);
    return(Rcpp::wrap(fib));
  }
}

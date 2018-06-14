library(inline)

src <- '
  Rcpp::NumericVector x =
    // Use create() to initialize a named numeric vector
    Rcpp::NumericVector::create(
      Rcpp::Named("mean") = 1.23,
      Rcpp::Named("dim") = 42,
      Rcpp::Named("cnt") = 12
    );
  return x;
'

fun <- cxxfunction(sig = signature(), body = src, plugin = "Rcpp")
fun()

library(inline)

src <- '
  Rcpp::NumericVector x =
    // Use create() to initialize a named numeric vector
    Rcpp::NumericVector::create(
      _["mean"] = 1.23,
      _["dim"] = 42,
      _["cnt"] = 12
    );
  return x;
'

fun <- cxxfunction(sig = signature(), body = src, plugin = "Rcpp")
fun()

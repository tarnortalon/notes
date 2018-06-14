library(inline)

src <- '
  Rcpp::IntegerVector epn(4); // initialize an integer vector of 4 elements
  epn[0] = 6;
  epn[1] = 14;
  epn[2] = 496;
  epn[3] = 8182;
  return epn; // directly return the vector as wrap() would be implicitly called
'

fun <- cxxfunction(sig = signature(), body = src, plugin = "Rcpp")
fun()

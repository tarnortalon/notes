library(inline)

src <- '
  Rcpp::IntegerVector vec(vx); // initialize an integer vector using input
  int prod = 1;
  for (int i = 0; i < vec.size(); ++i) {
    prod *= vec[i];
  }
  return Rcpp::wrap(prod); // wrap() needs to explicitly called here
'

fun <- cxxfunction(sig = signature(vx = "integer"), body = src,
                   plugin = "Rcpp")
fun(1:10)

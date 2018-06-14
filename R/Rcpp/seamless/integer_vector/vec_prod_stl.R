library(inline)

src <- '
  Rcpp::IntegerVector vec(vx); // initialize an integer vector using input
  int prod = std::accumulate(vec.begin(), vec.end(), 1,
                             std::multiplies<int>());
  return Rcpp::wrap(prod);

'

fun <- cxxfunction(sig = signature(vx = "integer"), body = src,
                   plugin = "Rcpp")
fun(1:10)

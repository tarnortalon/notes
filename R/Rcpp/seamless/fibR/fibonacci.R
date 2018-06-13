library(Rcpp)

dyn.load("fibonacci.so")
.Call("fibWrapper", 10)

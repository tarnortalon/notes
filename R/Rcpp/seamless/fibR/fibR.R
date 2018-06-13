# R implementation of a recursive Fibonacci series generation algo
fibR <- function(n) { # n is 0-indexed here
  if (n == 0) { return(0) }
  if (n == 1) { return(1) }
  return (fibR(n - 2) + fibR(n - 1))
}
# fibR(10)

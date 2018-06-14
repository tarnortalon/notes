# IntegerVector class 

1. perfecr_num.R uses `cxxfunction()` from the `inline` package. The C++ body of
function uses `IntegerVector` class to initialize a vectror, assigns its values,
and returns the vector as is. It doesn't take any input.

1. vec_prod.R makes a function that takes an integer vector input in R, passes
it to the C++ function. vec_prod_stl.R is similar, but uses STL functions.

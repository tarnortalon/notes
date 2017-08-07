# [Non-standard evaluation][1]

## Pre-requisite

* [Expressions, environments and lexical scopting](expressions.md)

## Capturing expressions

Capturing an expression looks at an expression (e.g., a function argument) and
instead of seeing the value, it sees the **code used to compute the value**.

### [`substitute()`][2]

`substitute()`makes capturing expressions possible. It takes two arguments
(`expr` and `env`) and returns the parse tree for the (unevaluated) expression
`expr`, substituting any variables bound in `env`.

It takes place by examining each component of the parse tree as follows.

1. If it is not a bound symbol in `env`, it is unchanged.

2. If it is a promise object, i.e., a formal argument to a function or
explicitly created using `delayAssign()`, the expression slot of the promise
replaces the symbol.

3. If it is an ordinary variable, its value is substituted, unless `env` is
`.GlobalEnv` in which case the symbol is left unchanged.

`substitute()` is often paired with [`deparse()`][3] which takes the output
expression, and turns it into a character vector.

## Non-standard evaluation

Capturing unevaluated expression is half of the recipe for non-standard
evaluation (NSE). The other half lies in eventually evaluating the captured
expression **in the right environment**.

### [`quote()`][2] and [`eval()`][4]

`quote()` simply captures an unevaluated expression and does not do any
transformation.

`eval()` is the opposite of `quote()`.

* In its simplest form when only one expression argument (e.g., an expression
captured by `substitute()` or `quote()`) is supplied, it evaluates the
expression in the current calling environment of `eval()`. This makes
`eval(quote(x))` equivalent to `x`, regardless of what `x` is.

* `eval()`'s second argument **specifies the environment (e.g., a list, a data
frame, or an environment) in which the code is executed**. This is the key to
NSE as it alters the meaning of the original expression.

An example of such non-standard evaluation is a subset function that accepts a
data frame and a condition to subset it.

``` r
subset2 <- function(x, condition) {
  # condition is "preserved" rather than evaluated here.
  # Should it be evaluated, it would throw an error because most likely the
  # variable doesn't exist outside of the data frame.
  condition_call <- substitute(condition)
  # Here the condition is evaluated in the context of the data frame.
  r <- eval(condition_call, x)
  x[r, ]
}

sample_df <- data.frame(a = 1:5, b = 5:1, c = c(5, 3, 1, 4, 1))

subset2(sample_df, a >= 4)
#>   a b c
#> 4 4 2 4
#> 5 5 1 1
```

## Scoping of NSE

The previous `subset2` example runs into unexpected results or errors
when `condition` includes variables defined in the function, such as `x`,
`condition`, or `condition_call`.

``` r
y <- 4
x <- 4
condition <- 4
condition_call <- 4

subset2(sample_df, a == 4)
#>   a b c
#> 4 4 2 4
subset2(sample_df, a == y)
#>   a b c
#> 4 4 2 4
subset2(sample_df, a == x)
#>       a  b  c
#> 1     1  5  5
#> 2     2  4  3
#> 3     3  3  1
#> 4     4  2  4
#> 5     5  1  1
#> NA   NA NA NA
#> NA.1 NA NA NA
subset2(sample_df, a == condition)
#> Error in eval(condition_call, x): object 'a' not found
subset2(sample_df, a == condition_call)
#> Warning in a == condition_call: longer object length is not a multiple of
#> shorter object length
#> [1] a b c
#> <0 rows> (or 0-length row.names)
```

When `eval()` can't find a variable in its second argument (when it's a
(pair)list or a data frame), by default it looks in the calling environment of
`eval()`. This behavior can be altered by supplying a third argument `enclos`
to `eval()`. `enclos` specifies a parent (or enclosing) environment for objects
that don't have one (like lists and data frames). Lexical scoping rules can also
be applied through `enclos`.

This essentially allows **dynamic scoping**: the values come from location where
a function is called, not where it is defined.

After providing the `enclos` argument, the function works properly.

``` r
subset2 <- function(x, condition) {
  condition_call <- substitute(condition)
  # By providing enclos = parent.frame(), eval() tries to find any variables
  # that are not found in the data frame x in parent.frame(), that is the
  # calling environment of subset2().
  r <- eval(condition_call, x, parent.frame())
  x[r, ]
}

x <- 4
subset2(sample_df, a == x)
#>   a b c
#> 4 4 2 4
```

## Calling from another function

When called from another function, `subset2` throws an error.

``` r
subset2 <- function(x, condition) {
  condition_call <- substitute(condition)
  r <- eval(condition_call, x, parent.frame())
  x[r, ]
}

scramble <- function(x) x[sample(nrow(x)), ]

subscramble <- function(x, condition) {
  scramble(subset2(x, condition))
}

subscramble(sample_df, a >= 4)
#> Error in eval(condition_call, x, parent.frame()): object 'a' not found
```

When `a >= 4` is passed as `condition` to `subscramble()`, it's not captured as
an unevaluated expression.

[1]: http://adv-r.hadley.nz/nse.html
[2]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/substitute.html
[3]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/deparse.html
[4]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/eval.html

# [Non-standard evaluation][1]

## Pre-requisite

* [Expressions, environments and lexical scopting](expressions.md)

## [Promise objects][5]

Promise objects are part of R's lazy evaluation mechanism.

They contain three slots.

* A value.

* An expression.

* An environment.

When a function is called, the arguments are matched. Then each of the formal
argument is bound to a promise. The *expression* that was given for that formal
argument and a pointer to the *environment* the function was called from are
stored in the promise.

Until that argument is accessed there is no *value* associated with the promise.
When the argument is accessed, the stored expression is evaluated in the stored
environment, and the result is returned.

The `substitute()` function extracts the content of the expression slot.

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
explicitly created using `delayedAssign()`, the expression slot of the promise
replaces the symbol (the environment slot of the promise is not passed).

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

### More on `eval()`

See if you can reason the outputs of the following example.

``` r
a <- 1

e <- new.env()
e$a <- c(1:10)

eval(quote(a))
#> [1] 1
eval(quote(a), e)
#>  [1]  1  2  3  4  5  6  7  8  9 10
eval(a)
#> [1] 1
eval(a, e)
#> [1] 1
evalq(a, e)
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

* In `eval(quote(a))`, `quote(a)` returns an expression (or more precisely
a name) that's simply `a`. `eval()` then evaluates that name in the current
environment (i.e., `.GlobalEnv`) because the second argument `env` is missing.
Name `a` is bound to the value `1` in the `.GlobalEnv`, so the output is `1`.

* In `eval(quote(a), e)`, `quote(a)` returns the same name `a`. When
`eval()` evaluates the name, it looks in the environment `e` rather than the
`.GlobalEnv`, as `env` is explicitly supplied. In the environment `e`, the name
`a` is bound to a vector `1:10` and that's what's returned.

* In `eval(a)`, the `expr` argument is first bound to a promise object that
has the name `a` in the expression slot the the calling environment (i.e.,
`.GlobalEnv`) in the environment slot (see [Promise](#promise-objects)).
The promise object is then immediately evaluated using the expression and
environment slots. The name `a` is bound to the value `1` in the `.GlobalEnv`,
so the `expr` argument's value is `1`. Essentially, `eval(a)` becomes `eval(1)`
and clearly the output is `1`.

* In `eval(a, e)`, the `env` argument is actually a red herring. The `expr`
argument evaluates to the value `1` as explained in the bullet above.
Essentially, `eval(a, e)` is equivalent to `eval(1, e)` and should always
evaluate to the value `1`, regardless of the `env` argument.

* `evalq(expr, ...)` is a shortcut for `eval(quote(expr), ...)`. So `evalq(a,
e)` is equivalent to `eval(quote(a), e)` and should evaluate to the same result.

### A `subset2` example

An example of such non-standard evaluation is a subset function that accepts a
data frame and a condition specifying how to subset it.

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

To understand this error, one needs to take a deeper look at what happens at
every step of the function call.

* When `subscramble(sample_df, a >= 4)` is called, the formal arguments are
bound to promise objects that are not evaluated yet.

  * Argument `x` is bound to a promise object that has the name `sample_df` in
the expression slot and the calling environment (i.e., `.GlobalEnv`) in the
environment slot.

  * Argument `condition` is bound to a promise object that has the expression
`a >= 4` in the expression slot and `.GlobalEnv` in the environment slot.

* `x` and `condition` are then passed to the `subset2()` function as arguments.
They are also bound to promise objects.

  * `subset2()`'s argument `x` is bound to a promise object that has the
name `x` in the expression slot and `subset2()`'s calling environment (i.e.,
`subscramble()`'s execution environment) in the environment slot.

  * `subset2()`'s argument `condition` is bound to a promise object that has
the name `condition` in the expression slot and `subscramble()`'s execution
environment in the environment slot.

  * Both argments are not evaluated at this point because they haven't been
accessed.

* Within `subset2()`'s execution environment, the argument `condition` (i.e.,
the promise object) is passed to the `substitute()` function. `substitute()`
extracts the expression slot of the promise object which is the name
`condition`. It then stores the name in the variable `condition_call`.

* The variable `condition_call` and the argument `x` (i.e., the promise object)
are now passed to `eval()` for evaluation.

  * The value of the promise object bound to the `x` argument is now accessed
and it kicks off a chain reaction.

    * The name `x` stored in the expression slot is now evaluated in
`subscramble()`'s execution environment.

    * In `subscramble()`'s execution environment, `x` is bound to a promise
object. The expression of the promise (i.e., the name `sample_df`) is now
evaluated in the `.GlobalEnv`. the result is the data frame and it's passed
along to the `eval()` within `subset2()`.

  * `eval()` now evaluates the name `condition` in the data frame and finds no
match.

  * `eval()` now tries to find the name `condition` in what's supplied as the
`enclos` argument. `parent.frame()` here evaluates to `subset2()`'s calling
environment which is `subscramble()`'s execution environment.

  * In `subscramble()`'s execution environment, the name `condition` is bound
to a promise object and it's now being accessed. The expression `a >= 4` stored
in its expression slot is now evaluated in the `.GlobalEnv`. Since there's no
variable `a` in the `.GlobalEnv`, this evaluation throws an error.

The crux of the problem is that `substitute()` is called in `subset2()` which is
inside the `subscramble()` function. When `subscramble()` calls `subset2()` with
the argument `condition`, it actually passes a promise object named `condition`
rather than the original expression `a >= 4`. As a result, `substitute()`
extracts the name `condition` to store in the `condition_call` variable rather
than the original expression.

This problem can be solved by two complementary practices.

* Write escape hatch functions to accept quoted expressions as arguments rather
than regular expressions.

* Write NSE functions to capture regular expressions into quoted expressions and
pass those to the escape hatch functions.

``` r
subset2_q <- function(x, condition) {
  r <- eval(condition, x, parent.frame())
  x[r, ]
}

subset2 <- function(x, condition) {
  subset2_q(x, substitute(condition))
}

subscramble <- function(x, condition) {
  condition <- substitute(condition)
  scramble(subset2_q(x, condition))
}

subscramble(sample_df, a >= 3)
#>   a b c
#> 3 3 3 1
#> 5 5 1 1
#> 4 4 2 4
```

[1]: http://adv-r.hadley.nz/nse.html
[2]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/substitute.html
[3]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/deparse.html
[4]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/eval.html
[5]: https://cran.r-project.org/doc/manuals/r-release/R-lang.html#Promise-objects

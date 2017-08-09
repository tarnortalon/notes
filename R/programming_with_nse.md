# Programming with non-standard evaluation (NSE)

## Articles

* [Programming with `dplyr`][1]

* [Tidy evaluation][2]

## Related notes

* [Non-standard evaluation](nse.md)

## Passing expressions to NSE functions

Here we refer to passing an expression as passing an expression inside
a function to another NSE function. That's why this note deals with
**programming** with NSE. See [Non-standard evaluation](nse.md) for a note on
writing and calling interactive NSE functions.

### A very simple example

We write a very simple NSE function that executes an expression within the
context of a list.

``` r
# A simple NSE function
f <- function(l, expr) {
  expr_call <- substitute(expr)
  eval(expr_call, l, parent.frame())
}

# The list environment with only one variable in it
l <- list()
l$a <- 1

# Check there's nothing in the global environment, except the function and the list
ls()
#> [1] "f" "l"

# Call the function to increment a in the list by 1
f(l, a + 1)
#> [1] 2
```

### Why is passing objects safe?

Passing an object (e.g., a data frame, a list, a vector, etc) inside a function
to another function is safe because each function call captures the name of
the object and the calling environment in a promise object. When the object is
eventually accessed, the chain of promises sprawns into action and the object is
"fetched" from the correct environment.

You can think of this process as a series of pointers, each pointing the the
next pointer and the last one points to the actual object. This series is
**referentially transparent**. When following the pointers, one can always get
to the actual object safely.

### Why is passing expressions unsafe/confusing/hard/etc?

The key premise for NSE to work is R's ability to temporarily suspend an
expression's evaluation by *quoting* it (e.g., via `substitute()` or `quote()`
functions). This allows an NSE function to manipulate the environment in which
the expression will ultimately be evaluated.

When an expression is passed to an NSE function directly, this quoting approach
works as intended. However, when an expression is passed within an outer
function to an inner NSE function, This approach breaks down.

* If the outer function doesn't quote the expression before passing it to the
inner NSE function, what gets passed along is the promise object whose name is
the name of the argument that matches the expression. So when the NSE function
tries to quote it, it ends up quoting the promise object bearing the argument
name instead of the expression.

``` r
# A dummy outer function that simply passes both arguments to f()
f2 <- function(l, expr) {
  f(l, expr)
}

# Call the outer function
f2(l, a + 1)
#> Error in eval(expr, envir, enclos): object 'a' not found
```

Here the name `a` is being evaluated in the global environment and not
surprisingly it's not found and throws an error.

A more confusing case occurrs when there is a variable `a` in the global
environment. The function call will succeed, but return a wrong result.

``` r
# Assign 0 to variable a in the global environment
a <- 0
f2(l, a + 1)
#> [1] 1
```

Here the search of `a` in the global environment succeeds (by accident, not by
design), but it has a different value than `a` in the list and hence produces a
wrong output.

* If the outer function quotes the expression before passing, it now passes a
quoted expression object whose name it the name of the matching argument. The
quoting within the inner NSE function will not work in this case either.

``` r
# A dummy outer function that quotes the expression before passing it to f()
f3 <- function(l, expr) {
  expr_call <- substitute(expr)
  f(l, expr_call)
}

# Call the outer function
f3(l, a + 1)
#> a + 1
```

### A solution

A viable solution is to write a SE version of the NSE function (called an escape
hatch by Hadley Wickham). The SE function accepts quoted expression instead of
raw expression as argument. The NSE function then can be turned into a wrapper
around the SE function by quoting the non-standard expressions typed by user and
pass them to the SE function. Any other outer function that calls the function
should also quote their argument expressions and pass them to the SE function.

``` r
# An SE version of the function
f_ <- function(l, q_expr) {
  eval(q_expr, l, parent.frame())
  }

# An NSE wrapper around the SE function
f <- function(l, expr) {
  q_expr <- substitute(expr)
    f_(l, q_expr)
    }

# Check there's nothing in the global environment, except the function and the list
ls()
#> [1] "f"  "f_" "l"

# Call the NSE function
f(l, a + 1)
#> [1] 2
```

### A `rlang` solution




[1]: http://dplyr.tidyverse.org/articles/programming.html
[2]: http://rlang.tidyverse.org/articles/tidy-evaluation.html

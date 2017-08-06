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

`eval()` is the opposite of `quote()`. In its simplest form when only one
expression argument (e.g., an expression captured by `substitute()` or
`quote()`) is supplied, it evaluates the expression in the current calling
environment of `eval()`. This makes `eval(quote(x))` equivalent to `x`,
regardless of what `x` is.

`eval()`'s second argument **specifies the environment (e.g., a list, a data
frame, or an environment) in which the code is executed**. This is the key to
NSE as it alters the meaning of the original expression.

## Scoping of NSE

When `eval()` can't find a variable in its second argument (when it's a
(pair)list or a data frame), by default it looks in the calling environment of
`eval()`. This behavior can be altered by supplying a third argument `enclos`
to `eval()`. `enclos` specifies a parent (or enclosing) environment for objects
that don't have one (like lists and data frames). Lexical scoping rules can also
be applied through `enclos`.

This essentially allows **dynamic scoping**: the values come from location where
a function is called, not where it is defined.


[1]: http://adv-r.hadley.nz/nse.html
[2]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/substitute.html
[3]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/deparse.html
[4]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/eval.html

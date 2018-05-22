-   [R language](#r-language)
    -   [Concepts](#concepts)
    -   [Expressions](#expressions)
        -   [Overview](#overview)
        -   [Two ways of creating R
            expressions](#two-ways-of-creating-r-expressions)
        -   [Base R expression functions](#base-r-expression-functions)
            -   [Expression and its
                components](#expression-and-its-components)
            -   [Conversion between string and
                expression](#conversion-between-string-and-expression)
        -   [Expression-related functions in
            `rlang`](#expression-related-functions-in-rlang)
            -   [`rlang` expression functions vs. base R expression
                functions](#rlang-expression-functions-vs.base-r-expression-functions)
    -   [Quotation](#quotation)
        -   [Base R](#base-r)
        -   [`rlang` quotation](#rlang-quotation)

R language
==========

Concepts
--------

-   An R
    [expression](https://stat.ethz.ch/R-manual/R-devel/library/base/html/expression.html)
    vector is a list of calls, symbols, constants etc.

-   [Quoting](http://dplyr.tidyverse.org/articles/programming.html#quoting)
    or quotation is the action of capturing an expression instead of
    evaluating it.

-   **Quasiquotation** is the combination of quoting an expression while
    allowing immediate evaluation (unquoting) of part of that
    expression.

    -   [Unquoting](http://dplyr.tidyverse.org/articles/programming.html#unquoting)
        or unquotation allows selective evaluation parts of a quoted
        expression.

-   Quosure

Expressions
-----------

### Overview

Quoted expressions are also called **abstract syntax trees** (AST)
because the structure of code is hierarchical and can be naturally
represented as a tree.

Note that the [Expressions](https://adv-r.hadley.nz/expressions.html)
chapter in [Advanced R](https://adv-r.hadley.nz/) refers to base R’s
expression as [**expression
objects**](https://adv-r.hadley.nz/expressions.html#expression-objects)
and uses the term *expression* to include following objects.

1.  **Constants** are “self-quoting” in the sense that the expression
    used to represent a constant is the constant itself.

2.  [Symbols](https://stat.ethz.ch/R-manual/R-devel/library/base/html/name.html)
    represent variable names.

3.  [Calls](https://stat.ethz.ch/R-manual/R-devel/library/base/html/call.html)
    define the tree in AST. A call behaves similarly to a (potentially
    nested) list.

    -   It has a `length()`.

    -   You can extract elements with `[[`, `[`, and `$`.

    -   Calls can contain other calls (hence nested list).

4.  **Pairlists** have been replaced by lists almost everywhere. The
    only place you are likely to see pairlists in R is when working with
    function arguments.

### Two ways of creating R expressions

1.  You can **build** calls and symbols from parts and pieces.

2.  The other way to create expressions is by quotation or
    quasiquotation, i.e., by intercepting an expression instead of
    evaluating it.

### Base R expression functions

#### Expression and its components

-   `expression()` captures its arguments (unevaluated) in a vector of
    type “expression” which can be coerced into a list.

    ``` r
    x <- expression("R", a <- 1, 2 * 5, LETTERS)

    x
    ```

        ## expression("R", a <- 1, 2 * 5, LETTERS)

    ``` r
    as.list(x)
    ```

        ## [[1]]
        ## [1] "R"
        ## 
        ## [[2]]
        ## a <- 1
        ## 
        ## [[3]]
        ## 2 * 5
        ## 
        ## [[4]]
        ## LETTERS

    ``` r
    typeof(x)
    ```

        ## [1] "expression"

    ``` r
    class(x)
    ```

        ## [1] "expression"

    ``` r
    length(x)
    ```

        ## [1] 4

    ``` r
    sapply(x, typeof)
    ```

        ## [1] "character" "language"  "language"  "symbol"

    ``` r
    sapply(x, class)
    ```

        ## [1] "character" "<-"        "call"      "name"

-   `as.symbol()` and `as.name()` coerce the argument to a name.

    ``` r
    x <- as.symbol("R")

    typeof(x)
    ```

        ## [1] "symbol"

    ``` r
    class(x)
    ```

        ## [1] "name"

-   `call()` creates an unevaluated function call which consists of the
    named function applied to the given arguments.

    ``` r
    x <- call("*", 2, 5)

    x
    ```

        ## 2 * 5

    ``` r
    typeof(x)
    ```

        ## [1] "language"

    ``` r
    class(x)
    ```

        ## [1] "call"

    Note that although the returned call is unevaluated, the arguments
    supplied to `call()` are evaluated.

    ``` r
    a <- 2
    b <- 5
    x <- call("+", a, b)

    x
    ```

        ## 2 + 5

#### Conversion between string and expression

-   `parse()` returns the parsed but unevaluated expressions in a list.

    ``` r
    x <- parse(
      text = c('"R"', "a <- 1", "2 * 5", "LETTERS")
    )

    x
    ```

        ## expression("R", a <- 1, 2 * 5, LETTERS)

    ``` r
    typeof(x)
    ```

        ## [1] "expression"

    ``` r
    class(x)
    ```

        ## [1] "expression"

    ``` r
    length(x)
    ```

        ## [1] 4

    ``` r
    sapply(x, typeof)
    ```

        ## [1] "character" "language"  "language"  "symbol"

    ``` r
    sapply(x, class)
    ```

        ## [1] "character" "<-"        "call"      "name"

-   `deparse()` turns unevaluated expressions into character strings.

    ``` r
    x <- parse(text = "a <- 1")[[1]]
    y <- quote(b <- 2)

    deparse(x)
    ```

        ## [1] "a <- 1"

    ``` r
    deparse(y)
    ```

        ## [1] "b <- 2"

### Expression-related functions in `rlang`

-   `expr()` and `exprs()` capture the expressions *you* supply (e.g.,
    through typing in an interactive session).

-   `enexpr()` and `exexprs()` capture the expressions *user* supplies
    (e.g., through arguments in a function).

    -   `ensym()` and `ensyms()` are variants of `enexpr()` and
        `enexprs()` that check the captured expression is either a
        string (which they convert to symbol) or a symbol. If anything
        else is supplied they throw an error.

#### `rlang` expression functions vs. base R expression functions

-   `enexpr(arg)` corresponds to `substitute(arg)`.

-   `expr()` is like `quote()`.

-   `exprs()` is equivalent to `alist()`.

-   `enexprs()` has no equivalent function in base R, but its behavior
    can be reproduced with `eval(substitute(alist(...)))`.

The difference is that all quotation functions in `rlang` support
unquotation, so they are quasiquotation functions.

Quotation
---------

### Base R

There are two ways of quoting in base R.

1.  [*Formula*](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/formula.html)
    is one of the most important quoting operators in R. It’s usually
    used for the specification of statistical models.

2.  The other family of quoting operator in base R is `quote()`, and
    `substitute()` functions (see
    [documentation](http://stat.ethz.ch/R-manual/R-devel/library/base/html/substitute.html)).

    -   `quote()` simply returns its argument unevaluated as a call.

        ``` r
        x <- quote(seq(1, 10, 1))

        typeof(x)
        ```

            ## [1] "language"

        ``` r
        class(x)
        ```

            ## [1] "call"

    -   `substitute()` takes an R expression and an `env` argument. It
        returns a call in which any variables bound in `env` are
        substituted.

        ``` r
        e <- new.env()
        e$a <- 1
        x <- substitute(a * 10, env = e)

        x
        ```

            ## 1 * 10

        ``` r
        typeof(x)
        ```

            ## [1] "language"

        ``` r
        class(x)
        ```

            ## [1] "call"

The difference is that **a formula captures its execution environment
with its expression** whereas **a quoting function only captures its
expression**.

### `rlang` quotation

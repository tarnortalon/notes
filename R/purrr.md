# `purrr`

`purrr` is a toolkit for working with functions and vectors in R. The most
obvious use of `purrr` is to replace `for` loops with a function call (e.g.,
usually some function from the `map()` family).

## `map()` function

[`map()`][4] function is the backbone of most `purrr` tools. It takes at least
two arguments: **a list or atomic vector** to loop through and **a function** to
apply to each element. It returns a list of the same length as the input list or
vector, much like what [`lapply()`][5] does.

User can supply a variety of values as a "function" to `map()`.

* A regular function defined using `function()`.

* A formula as an anonymous function. It's converted to a function. There are
three ways to specify the arguments.

  * A single argument uses `.`.

  * Two arguments uses `.x` and `.y`.

  * More arguments use `..1`, `..2`, `..3`, etc.

* A vector (character or numeric) or a list. This is converted into an
*extractor* function to extract specific element from the input vector/list
using name or numeric index. A list is used to extract element at different
levels.

  * A `.default` value can be supplied and it will be used when the extracted
element is not present.

* `map_at()` and `map_if()` apply the function to selective elements of the
vector/list based on the position or predicate supplied. Otherwise, they behave
in the same way as `map()`.

## Typed `map()`

R is not a strong-typed language, so it's hard to ascertain what types of output
a function will return. To make sure the `map()` function only returns an output
of a certain type, a few typed `map()` functions are provided.

* `map_lgl()`, `map_int()`, `map_dbl()`, and `map_chr()` return logical,
integer, double, and character outputs, respectively. They behave somewhat
similarly to `sapply()` and `vapply()` functions.

* `map_dfr()` and `map_dfc()` return data frames, created by row-binding and
column-binding individual elements.

  * A `.id` argument can be provided to denote every data frame element with
a value (either the name or the index of the data frame) so that they can
differentiated in the resulting mega data frame.

* Lastly, `walk()` function does exactly what `map()` does, but is usually used
when the function applied doesn't create an output but a side-effect (e.g., save
an object to a file, etc). It silently returns the input vector/list as output.

## `map()` variants

There are ? types of `map()` function variants.

* Two-argument `map()` functions

  * `map2()` takes two vectors of the same length as arguments and a function to
apply.

  * `map2_lgl()`, `map2_int()`, `map2_dbl()`, and `map2_chr()` are variants of
their `map_*()` counterparts.

  * `map2_dfr()` and `map2_dfc()` are variants of `map_dfr()` and `map_dfc()`
respectively.

  * `walk2()` is the two-argument variant of `walk()`.

* Multiple-argument `map()` functions

  * Similarly, `pmap()` takes a list of lists. The length of the outer list
determines the number of argument the applied function will be called with. List
names will be use to match argument names, if present.

  * `pmap_lgl()`, `pmap_int()`, `pmap_dbl()`, `pmap_chr()`, `pmap_dfr()`,
`pmap_dfc()`, and `pwalk()` are also available.

* Indexed map

`imap()`, an indexed map, is short hand for `map2(x, names(x), ...)`, if `x` has
names, or `map2(x, seq_along(x), ...)` if it does not.

  * `imap_lgl()`, `imap_int()`, `imap_dbl()`, `imap_chr()`, `imap_dfr()`,
`imap_dfc()`, and `iwalk()` are also available.

* Modify elements "in-place"

`modify()` is shortcut for `x[] <- map(x, .f)`. It modifies the input
vector/list in place and return the modified vector/list as output.

  * `modify_at()` and `modify_if()` only modify specific elements of the input
vector/list.

  * `modify_depth()` takes an extra `.depth` argument that specifies which level
of the input vector/list to map on.

    * `modify_depth(x, 0, fun)` is equivalent to `x[] <- fun(x)`.

    * `modify_depth(x, 1, fun)` is equivalent to `x[] <- map(x, fun)`.

    * `modify_depth(x, 2, fun)` is equivalent to `x[] <- map(x, ~map(., fun))`.

* Apply a function to list-element of a list.

Suppose `x` is a list. `x[[1]]` is the first element of the list while `x[1]` is
the first list-element of the list (i.e., it behaves like a one-element list).

`lmap()`, `lmap_at()`, and `lmap_if()` behave like `map()`, `map_at()`, and
`map_if()`, but exclusively on list-elements of a list. When they are used on a
data frame, they operate on individual columns of the data frame.

## Related materials

* [Iteration][1] in [R for Data Science][2]

## References

* [`purrr` package on GitHub][6]

* [`purrr` package documentation][3]

[1]: http://r4ds.had.co.nz/iteration.html
[2]: http://r4ds.had.co.nz/
[3]: http://purrr.tidyverse.org/index.html
[4]: http://purrr.tidyverse.org/reference/map.html
[5]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/lapply.html
[6]: https://github.com/tidyverse/purrr

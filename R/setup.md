# Set up R environment on Ubuntu

## References

* [R Installation and Administration][1]

## Essential concepts

* `R_HOME`

  `R_HOME` is the directory in which the R tree is installed. It also hosts
sub-directories like `src`, `doc` and `etc`.

  The environment variable `R_HOME` can be retrieved in R using [`R.home()`][2].
In Ubuntu terminal, one can run `R RHOME` to get the value.

* library

  A library is a directory containing *installed* packages.

  * The main library is `R_HOME/library` which is the value of the
[`.Library`][3] string object. It contains standard and recommended packages.

  * R will automatically make use of a site-specific library
`R_HOME/site-library` if it exists. This location can be overridden in two ways.

    * Set [`.Library.site`][3] value in `R_HOME/etc/Rprofile.site`.

    * Set the environment variable `R_LIBS_SITE` (not recommended).

  * `.Library` and `.Library.site` are always included by `.libPaths()`.

  * Users can have one or more libraries, normally specified by the environment
variable `R_LIBS_USER`. This has a default value, but it's only used if the
corresponding directory actually exists.

  * Both `R_LIBS_SITE` and `R_LIBS_USER` can specify multiple library paths,
separated by colons.

  * Users can also set a `R_LIBS` environment variable which should be a
colon-separated list of directories.

  * The order of library loading is `.Library` > `R_LIBS_SITE` | `.Library.site` > `R_LIBS_USER` > `R_LIBS`.

## Necessary libraries

* libcurl4-openssl-dev for `curl` package

  ```
  sudo apt install libcurl4-openssl-dev
  ```

* libxml2-dev for `xml2` package

  ```
  sudo apt install libxml2-dev
  ```

[1]: https://cran.r-project.org/doc/manuals/r-release/R-admin.html
[2]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/Rhome.html
[3]: https://stat.ethz.ch/R-manual/R-devel/library/base/html/libPaths.html

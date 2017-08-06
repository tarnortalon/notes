# Expressions and environments in R

## Environments

### [Scoping](http://adv-r.hadley.nz/functions.html#lexical-scoping)

Scoping governs how R looks up the value of a symbol (e.g., variable name,
function name, etc).

R has two types of scoping:

* **Lexical scoping** looks up symbol values based on how functions are nested
**when they are created**, not how they are nested **when they are called**.

* **Dynamic scoping**

#### Lexical scoping

There are four basic principles behind R's lexical scoping:

* **Name masking**. A name is first searched within a function, then the parent
function (if any) in which the function (or closure) is defined, all the way up
to the global environment, and then on to other loaded packages.

* **Functions vs. variables**. Finding functions works exactly the same way as
finding variables. If you are using a name in a context when it's obvious that
you want a function (e.g., `f(3)`), R will ignore objects that are not functions
in the search.

* **A fresh start**. Every time a function is called, a new environment is
created to host the execution.

* **Dynamic lookup**. Lexical scoping determines **where** to look for values,
not **when** to look for them. R looks for values **when the function is run**,
not when it's created. This *dynamic* lookup means that the output of a function
can be different if the function depends on object *outside* its environment.

### Environments

The environment is the data structure that powers scoping.

#### Basics

You can think of an environment as a bag of names. Each name points to an object
stored elsewhere in memory. Multiple names can point to the same underlying
object.

#### Parent environment

Every environment (except the empty environment) has a parent environment which
is used to implement lexical scoping.

#### Special environments

There are four special environments:

* The **`globalenv()`, or global environment**, is the interactive workspace.
The parent of the global environment is the last package that you attached.

* The **`baseenv()`, or base environment**, is the environment of the `base`
package. Its parent is the empty environment.

* The **`emptyenv()`, or empty environment**, is the ultimate ancestor of all
environments, and the only environment without a parent.

![global, base and empty environment](http://i.imgur.com/dP7Z1Ic.png)

* The **`environment()`** is the current environment.

#### Useful environment functions

* `new.env()` creates an environment manually.

* `ls()` lists the bindings in an environment's frame.

* `parent.env()` returns an environment's parent environment.

* `as.environment("package:<package name>")` access an attached package's
environment.

* `search()` lists all parents of the global environment, which collectively is
called the **search path**.

* Given a name, you can extract the value to which it is bound with `$`, `[[`,
or `get()`.

  * `$` and `[[` look only in one environment and return `NULL` if there is no
such binding.

  * `get()` uses the regular scoping rules (i.e., by default, it searches the
ancestors of the environment) and throws an error if the binding is not found.

  * `pryr::where()` finds the *first* environment *where* the name is defined
(i.e., the first binding environment), using R's regular scoping rules.

* `environment(fun)` returns a function's enclosing environment.

#### Functional environments

There are four types of environments associated with a function.

* The **enclosing** environment is the environment where the function was
**created**. Every function has one and only one enclosing environment. This
*environment is used for lexical scoping and never changes.

* Binding a function to a name in an environment defines a **binding**
environment.

* Calling a function creates an *ephemeral* **execution** environment that
stores variables created during execution.

* Every execution environment is associated with a **calling** environment,
which tells you where the function was called.

#### Package namespaces and environments

Package namespaces keep packages independent. Namespaces are implemented using
environments, taking advantage of the fact that function's binding and enclosing
environments can be different.

More specifically, a function's enclosing environment is a package's namespace
environment and its binding environment is the package's package environment.

* A package's namespace environment contains (i.e., encloses) *all* functions
(including internal functions), and its parent environment is a special imports
environment that contains bindings to all the functions that the package needs.

* A package's package environment binds all *exported* functions. It's placed in
the search path when the package is loaded.

#### Execution environment

Each time a function is called, a new environment is created to host the
execution.

Each execution environment has two parents.

* A calling environment.

* The function's enclosing environment. R's regular scoping rules only use the
enclosing parent.

Usually once the function has completed, the execution environment is thrown
away. The exception is when the function defines a child function. The child
function's enclosing environment is the function's execution environment and
it's no longer ephemeral.

#### Calling environment

We can access a function's calling environment using `parent.frame()` function.

Looking up variables in the calling environment rather than in the enclosing
environment is called **dynamic scoping**.

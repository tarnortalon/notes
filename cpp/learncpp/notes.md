## Structure of a program

* Statements
* Expressions
* Functions
* Libraries and C++ standard library

### Statements

Statements are often (but not always) terminated by a semicolon.

Statements convey to the compiler about a specific task.

```c++
int x;
```

**Declaration statement** tells the compiler that `x` is a variable that holds an
integer (`int`) value.

```c++
x = 5;
```

This is a statement that **assigns** a value (`5`) to a variable (`x`).

```c++
std::cout << x;
```

This is a statement that outputs the value of variable `x` to the screen.

### Expressions

Expressions specify a computation to be performed.

Expressions cannot be compiled by themselves, as they are meant to be used
inside statements.

An **expression statement** is simply an expression followed by a semicolon.

### Functions

Statements are typically **grouped** into units called **functions**. A function
is a collection of statements that execute *sequentially*.

Every program must contain a special function called `main`.

### Libraries

A **library** is a collection of precompiled code (e.g., functions) that has
been "packaged up" for *reuse* in many different programs.

C++ comes with a library called **C++ standard library** that's divided into
areas, each of which focuses on providing a specific type of functionality.

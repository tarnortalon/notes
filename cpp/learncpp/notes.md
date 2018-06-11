## Structure of a program

* Directives
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

## Variables, initialization, and assignment

### Objects

An **object** is a piece of *memory* that can be used to store values.

### Variables

A **variable** is an object (i.e., a piece of memory) that has a name.

```c++
int x;
```

The statement above defines a variable named `x` as an integer variable.
When the statement is executed, a piece of memory will be set aside (called
**instantiation**). Whenever the program sees the variable `x` in an expression
or statement, it knows how to locate the piece of memory to get the value.

```c++
x = 5;
```

When this assignment statement is executed, value `5` is put in variable `x`'s
memory location.

#### l-values and r-values

An **l-value** is a value that has a *persistent* address in memory. The name
came about because l-values are the only values that can be on the *left* side
of an assignment statement. Since all variables have addresses, all variables
are l-values.

An **r-value** is a value that's not associated with a persistent memory
address. It is generally temporary in nature and is *discarded* at the end of
the statement.

```c++
int y;      // define y as an integer variable
y = 4;      // r-value 4 evaluates to 4, which is then assigned to l-value y
y = 2 + 5;  // r-value 2 + r-value 5 evaluates to r-value 7, which is then assigned to l-value y

int x;      // define x as an integer variable
x = y;      // l-value y evaluates to 7 (from before), which is then assigned to l-value x.
x = x;      // l-value x evaluates to 7, which is then assigned to l-value x (useless!)
x = x + 1;  // l-value x + r-value 1 evaluate to r-value 8, which is then assigned to l-value x.
```

### Initialization

**Initialization** refers to the action that defines a variable and assigns it a
value in one single statement.

```c++
int x = 5; // initialize variable x with the value 5
```

The practice of initialization is better than the "define first and assign
later" practice for a subtle reason.

When defining a variable without an initial value (e.g., `int x;`), C++ does
*not* automatically assign a default value (such as 0) to the variable. As the
variable is given a memory location, the variable will take whatever value
that the memory location holds to be its own value. Such a variable is called
**uninitialized variable**.

## Functions

A **function** is a reusable sequence of statements designed to do a particular
job.

When writing a function, the developer gets to decide the *return type* of the
function.

```c++
int return5()
{
  return 5;
}
```

The `return5()` function above has a return type of `int` specified.

Functions are *not* required to return a value. To tell the compiler that a
function does not return a value, a return type of **void** is used.

```c++
void doNothing()
{
  std::cout << "Doing nothing" << std::endl;
}
```

A function like `doNothing()` above is usually called for its side effects
instead of the value returned.

## Classes

### Alternatives to classes

A **struct** can be used to hold structured data. Here's an example of a struct
to hold date values.

```c++
struct DateStruct
{
  int year;
  int month;
  int day;
};
```

It can be initialized using uniform initialization.

```c++
DateStruct today {2018, 5, 30};
```

We can also write functions that take the struct as parameter.

```c++
#include <iostream>

struct DateStruct
{
  int year;
  int month;
  int day;
};

void print(DateStruct &ds) {
  std::cout << ds.year << "/" << ds.month << "/" << ds.day << std::endl;
}

int main()
{
  DateStruct today { 2018, 5, 30 };
  print(today);
  return 0;
}
```

This approach could work for small problems. However, for larger projects that
have a lot of data and functions, it can be hard to organize and keep track
of all related functions. In addition, all fields in a struct are publicly
available and it increases risks of unauthorized access to data.

### Classes definition

Classes offer a better solution for organizing data and related functions.

We start from a `DateClass` class that's functionally equivalent to the
`DateStruct` struct that we've defined earlier.

```c++
struct DateStruct
{
  int year;
  int month;
  int day;
};

class DateClass
{
public:
  int m_year;
  int m_month;
  int m_day;
};
```

A variable of `DateClass` type can be declared.

```c++
DataClass today;
```

It can also be **instantiated** using uniform initialization.

```c++
DateClass today { 2018, 5, 30 };
```

The variable itself (e.g., `today` in the example above) is called an
**instance** of the class type.

When an instance is declared but not instantiated, its members have default zero
values.

### Class member functions

One key feature of the class type is that it can contain functions. Those
functions defined as parts of a class are called **member functions** (or
**methods**).

Member functions can be defined inside of a class definition, or outside later
on.

Here we define a `print` function similar to the one defined for the
`DateStruct` struct type above.

```c++
#include <iostream>

class DateClass
{
public:
  int m_year;
  int m_month;
  int m_day;

  void print()
  {
    std::cout << m_year << "/" << m_month << "/" << m_day << std::endl;
  }
};

int main()
{
  DateClass today { 2018, 5, 30};
  today.print();
  return 0;
}
```

Members of a class are accessed using the member selector operator (`.`).

### Public versus private access specifiers

**Public members** of a struct or class are members that can be accessed from
*outside* of the struct or class.

* Struct members are *public* by default.

* Class members (without an access specifier) are *private* by default. That is,
they can't be accessed outside of the class.

**Private members** are members of a class that can only be accessed by other
members of the same class. Note that a struct cannot have private members.

We can use an **access specifier** to specify who has access to the members
following the specifier. There are three types of access specifiers: `public`,
`private`, and `protected`.

The general rule is to make member variables private, and member functions
public, unless you have a good reason not to.

### Constructors

#### Alternatives to constructors

When all members of a class are public, we can initialize (or instantiate) the
class directly by using an initialization list or uniform initialization (in
C++11).

```c++
class DateClass
{
public:
  int year;
  int month;
  int day;
};

int main()

  DateClass today { 2018, 5, 30 }; // initialize a class variable using uniform initialization
  DateClass tomorrow = { 2018, 5, 31}; // initialization list
  return 0;
}
```

However, as soon as we make any member variable private, we can no longer
initiate a class variable in such a way. Instead, we need to resort to class
constructors.

#### Constructors

A **constructor** is a special kind of class member function that is
*automatically* called when an instance of that class is instantiated.

* Constructors must have the same name as the class.

* Constructors have no return type (not even void).

* A constructor that takes no parameters (or has parameters that all have
default values) is called a **default constructor**. It is called if no
user-provided initialization values are provided.

#### Constructor member initializer list

When a class has private member variables, it can be initialized using
assignment in the constructor.

```c++
class DateClass
{
private:
  int year;
  int month;
  int day;

public:
  DataClass()
  {
    year = 2018;
    month = 5;
    day = 30;
  }
};
```

However, this approach doesn't work for some types of data (e.g., constant
variables and reference variables) that must be initialized on the same line
they are declared. To initialize a class variable that has such types of member
variables, we need to use a **member initializer list**.

```c++
#include <iostream>

class DateClass
{
private:
  int year;
  int month;
  int day;

public:
  DateClass() : year(2018), month(5), day(30) // directly initialize private member variables
  {
    // No need for assignment here
  }

  void print()
  {
    std::cout << year << "/" << month << "/" << day << std::endl;
  }
};

int main()
{
  DateClass today;
  today.print();
  return 0;
}
```

The member initializer list is inserted after the constructor parameters. It
begins with a colon (:), and then lists each variable to initialize along with
the value for that variable separated by a comma. Also note that the initializer
list does *not* end in a semicolon.

It can also use the argument values passed in the constructor.

```c++
#include <iostream>

class DateClass
{
private:
  int m_year;
  int m_month;
  int m_day;

public:
  DateClass(int year, int month, int day = 1)
    : m_year(year), m_month(month), m_day(day) // directly initialize private member variables using constructor arguments
  {
    // No need for assignment here
  }

  void print()
  {
    std::cout << m_year << "/" << m_month << "/" << m_day << std::endl;
  }
};

int main()
{
  DateClass today(2018, 5);
  today.print();
  return 0;
}
```

In C++11, you can also use uniform initialization instead of direct
initialization.

```c++
public:
  DateClass(int year, int month, int day = 1)
    : m_year { year }, m_month { month }, m_day { day } // uniform initialization
  {
    // No need for assignment here
  }
```

Uniform initialization is preferred if the compiler supports C++11 standard.

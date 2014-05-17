Prim
====

The _Prim_ programming language is based on the set of [Primitive Recursive functions](https://en.wikipedia.org/wiki/Primitive_recursive_function).  Since I had been abbreviating the term as "Prim R," it seems reasonable to also tip the hat to [Robert Prim](https://en.wikipedia.org/wiki/Robert_C._Prim), whose work is almost entirely unrelated.

Warning
-------

Don't use this.

The recommendation may change in the future, but there is a handful of serious obstacles to getting use out of Prim at this time.

 - This code is _very_ old (I can't remember the last time I used Lex and Yacc), and I don't like what I see.  There's a push for one-liners and avoiding braces for control structures as if they're somehow costly.

 - The compiler generates code for [Sphinx C--](http://www.goosee.com/cmm/), a sort of high-level assembler that I surely thought was _The Future_^TM^ back in the day.  The sole compiler is DOS/Windows-based and closed-source, so.

 - There is at least one obvious bug in generating variable names.

 - The language is incomplete.  Primitive recursion is not yet implemented, making this just a simplified mathematical notation.

So, feel free to mess around with it, but don't expect _Prim_ to reveal the secrets of the universe...or work.

Usage
-----

This _Prim_ distribution comes with both a compiler and an interpreter, run in different ways.

Run the interpreter as expected:

    primi <infile>

The compiler is fussier:

    primc <infile> <outfile>

There is no error checking on the file names, so enter at your own risk.  As mentioned, the compiler produces code for C--, which is only available as a closed-source package, and produces very strange variable names.

The Basics
----------

Primitive recursive functions are a class of functions that are defined using primitive recursion and composition as central operations; they form an important building block on the way to a full formalization of computability.

The core functions are:

 - Constant (`Z()`):  Takes no parameters and returns a base value.  Arithmetically, this value is zero (0).

 - Successor (`S(n)`):  Takes a single parameter and returns the successor of that argument.  In arithmetic terms, `S(n)` produces `n + 1`.

 - Projection (`P:n;i(l)`):  Takes three parameters---a maximum list length (`n`), an index (`i`), and a comma-delimited list (`l`)---and returns the indexed element of the list.  For example, `P:3;1(10,20,30)` returns `20`.

 - Pseudo-Composition (`expr->n`):  To compose functions, _Prim_ provides a simple assignment-based system to feed the results of one function into the parameter of another.  Note that this will not suffice for full composition, for a variety of reasons.

Primitive Recursion has not yet been implemented.

Every _Prim_ statement is terminated with a period (`.`).  A question mark (`?`) may be added to the end of a statement (before the period) to print the value represented.

Next
----

After completing the _Prim_ implementation, the obvious next step would be to add _Minimization_.  Such a _Prim++_ would represent mu-Recursive functions, which would make it Turing Complete.

Someday.

Examples
--------

_Prim_ comes with two simple example programs.

 - test.pr:  Calculate the numbers zero through three and print them out in reverse order.

 - prime.pr:  Print (_does not calculate_) the first twenty prime numbers.

The particularly brand of tediousness in the examples should indicate how much _Prim_ still needs to grow.


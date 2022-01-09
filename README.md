# SectorLISP Examples
This repository contains programs written for [SectorLISP](https://github.com/jart/sectorlisp),
a 512-byte Lisp interpreter that fits inside the boot sector of a floppy disk and runs on bare metal.

The following programs run on the original SectorLISP:
- [basic.lisp](./lisp/basic.lisp) :
  - A BASIC-subset interpreter that runs on the original SectorLISP.
    Supports the instructions `REM`, `LET`, `IF`, `GOTO`, `PRINT`, and the infix operators `+`, `-`, `%`, and `<=`.
    Integers are expressed in unary as the number of atoms in a list, such as `(1 1 1)`.
- [quine.lisp](./lisp/quine.lisp) :
  - A [quine](https://en.wikipedia.org/wiki/Quine_(computing)) for SectorLISP,
    which is a program that prints its own source code when evaluated, without the use of any external input.
    When evaluated in the SectorLISP REPL, the output exactly matches the input itself.
    The technique used in this code is referenced from the Common Lisp quine in the [Quine](https://rosettacode.org/wiki/Quine#Common_Lisp) entry from [Rosetta Code](https://rosettacode.org/wiki/Rosetta_Code).
- [eval-macro.lisp](./lisp/eval-macro.lisp) :
  - An extended version of the metacircular evaluator in [lisp.lisp](https://github.com/jart/sectorlisp/blob/main/lisp.lisp) from the [original SectorLISP repository](https://github.com/jart/sectorlisp),
    supporting a new special form `MACRO` which can be used to construct macros.
    Using `MACRO`, this example implements the backquote macro `` ` ``, as well as the unquote operation `~`.
- [eval-macro-define.lisp](./lisp/eval-macro-define.lisp) :
  - An extended version of eval-macro.lisp, supporting `DEFINE` and `PROGN`.
  - `DEFINE` can be used either at the top level to define a persistent variable,
    or inside `LAMBDA`s and `MACRO`s to define a temporary variable.
    The definitions that occur in `LAMBDA`s and `MACRO`s do not modify the global variable namespace, 
    and are discarded after evaluating the body of the `LAMBDA`s and `MACRO`s.
  - `DEFINE` can be written inside any part of the program, including conditions inside `COND`, parts of `CONS`, etc.,
    and will successfully modify the surrounding variable namespace.
  - Due to the introduction of side effects, there is also support for `PROGN`,
    with the same behavior as modern Lisp dialects.
    `LAMBDA`s and `MACRO`s also have an implicit `PROGN`, and multiple statements can be written inside its body
    which will be evaluated sequentially in the order of appearance, as in modern Lisp dialects.
  - This example first defines the backquote macro `` ` `` and the unquote operation `~`,
    and then defines `DEFMACRO` as a macro.
    It then uses `DEFMACRO` to define a new macro `REPQUOTE`, which returns an expression where the input expression is repeated twice.


The following programs run on a [fork of SectorLISP](https://github.com/woodrush/sectorlisp/tree/io) with `READ` and `PRINT`:
- [number-guessing-game.lisp](./lisp/number-guessing-game.lisp) :
  - An interactive number guessing game where the player guesses a
    secret number from 1 to 10, using incremental knowledge of whether the guess was less than or greater than the secret number.
- [basic-repl.lisp](./lisp/basic-repl.lisp) :
  - A BASIC-subset interpreter with an REPL interface.
    Supports the commands `LIST`, `RUN`, `DISCARD` for editing and running BASIC programs.
- [repl.lisp](./lisp/repl.lisp) :
  - A version of eval-macro.lisp with an REPL interface,
    supporting the `macro` special form which can be used to construct macros.
    This example also implements the backquote macro `` ` ``, as well as the unquote operation `~` using `macro`.
- [repl-macro-define.lisp](./lisp/repl-macro-define.lisp)
  - A version of eval-macro-define.lisp with an REPL interface.
    With the combination of `print`, `read`, `define`, `progn`, and implicit `progn`s inside lambdas and macros,
    the experience of the REPL should be close to that of modern Lisp dialects.

## Licensing
The following programs are based on [lisp.lisp](https://github.com/jart/sectorlisp/blob/main/lisp.lisp) in the [original SectorLISP repository](https://github.com/jart/sectorlisp):
- [repl.lisp](./lisp/repl.lisp)
- [eval-macro.lisp](./lisp/eval-macro.lisp)
- [eval-macro-define.lisp](./lisp/eval-macro-define.lisp)
- [repl-macro-define.lisp](./lisp/repl-macro-define.lisp)

The [LICENSE](LICENSE) in this repository includes the license from the original SectorLISP repository.

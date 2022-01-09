# SectorLISP Examples
This repository contains programs written for [SectorLISP](https://github.com/jart/sectorlisp),
a 512-byte Lisp interpreter that fits inside the boot sector of a floppy disk and runs on bare metal.

The following program runs on the original SectorLISP:
- [basic.lisp](./lisp/basic.lisp) : A BASIC-subset interpreter that runs on the original SectorLISP.
  Supports the instructions `REM`, `LET`, `IF`, `GOTO`, `PRINT`, and the infix operators `+`, `-`, `%`, and `<=`.
  Integers are expressed in unary as the number of atoms in a list, such as `(1 1 1)`.
- [quine.lisp](./lisp/quine.lisp) : A [quine](https://en.wikipedia.org/wiki/Quine_(computing)) for SectorLISP,
  which is a program that prints its own source code when evaluated, without the use of any external input.
  When evaluated in the SectorLISP REPL, the output exactly matches the input itself.
  The technique used in this code is referenced from the Common Lisp quine in the [Quine](https://rosettacode.org/wiki/Quine#Common_Lisp) entry from [Rosetta Code](https://rosettacode.org/wiki/Rosetta_Code).
- [macro-eval.lisp](./lisp/macro-eval.lisp) : An extended version of the metacircular evaluator in [lisp.lisp](https://github.com/jart/sectorlisp/blob/main/lisp.lisp) from the [original SectorLISP repository](https://github.com/jart/sectorlisp),
  supporting a new special form `MACRO` which can be used to construct macros.
  Using `MACRO`, this example implements the backquote macro `` ` ``, as well as the unquote operation `~`.


The following program runs on a [fork of SectorLISP](https://github.com/woodrush/sectorlisp/tree/io) with `READ` and `PRINT`:
- [number-guessing-game.lisp](./lisp/number-guessing-game.lisp) : An interactive number guessing game where the player guesses a
  secret number from 1 to 10, using incremental knowledge of whether the guess was less than or greater than the secret number.
- [basic-repl.lisp](./lisp/basic-repl.lisp) : A BASIC-subset interpreter with an REPL interface.
  Supports the commands `LIST`, `RUN`, `DISCARD` for editing and running BASIC programs.
- [repl.lisp](./lisp/repl.lisp) : A version of macro-eval.lisp with and REPL interface,
  supporting the `macro` special form which can be used to construct macros.
  This example also implements the backquote macro `` ` ``, as well as the unquote operation `~` using `macro`.


## Licensing
[repl.lisp](./lisp/repl.lisp) and [macro-eval.lisp](./lisp/macro-eval.lisp) is based on [lisp.lisp](https://github.com/jart/sectorlisp/blob/main/lisp.lisp) in the [original SectorLISP repository](https://github.com/jart/sectorlisp).
The [LICENSE](LICENSE) in this repository includes the license from the original SectorLISP repository.

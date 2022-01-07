# SectorLISP Examples
This repository contains programs written for [SectorLISP](https://github.com/jart/sectorlisp),
a 512-byte Lisp interpreter that fits inside the boot sector of a floppy disk and runs on bare metal.

The following program runs on the original SectorLISP:
- [basic.lisp](basic.lisp) : A BASIC-subset interpreter that runs on the original SectorLISP.
  Supports the instructions `REM`, `LET`, `IF`, `GOTO`, `PRINT`, and the infix operators `+`, `-`, `%`, and `<=`.
  Integers are expressed in unary as the number of atoms in a list, such as `(1 1 1)`.

The following program runs on a [fork of SectorLISP](https://github.com/woodrush/sectorlisp/tree/io) with `READ` and `PRINT`:
- [number-guessing-game.lisp](number-guessing-game.lisp) : An interactive number guessing game where the player guesses a
  secret number from 1 to 10, using incremental knowledge of whether the guess was less than or greater than the secret number.
- [basic-repl.lisp](basic-repl.lisp) : A BASIC-subset interpreter with an REPL interface.
  Supports the commands `LIST`, `RUN`, `DISCARD` for editing and running BASIC programs.
- [repl.lisp](repl.lisp) : An extended Lisp interpreter with an REPL interface.
  Supports the `macro` special form which can be used to construct macros.
  The example implements the backquote macro `` ` ``, as well as the unquote operation `~`.


## Licensing
[repl.lisp](repl.lisp) is based on [lisp.lisp](https://github.com/jart/sectorlisp/blob/main/lisp.lisp) in the [original SectorLISP repository](https://github.com/jart/sectorlisp).
The [LICENSE](LICENSE) in this repository includes the license from the original SectorLISP repository.

# BootFuck
A bootable brainfuck interpreter... the greates os of all time!

## How To:
1. Install fasm http://flatassembler.net/
2. run make
  * fasm bootfuck.asm bootfuck
3. Install qemu
4. run make run
  * qemu-system-x86_64 bootfuck

## Brainfuck
Brainfuck is a really cool programming language using only 8 characters. This bootable interpreter will run on any x86 system. If you want to learn about Brainfuck, go here http://www.muppetlabs.com/~breadbox/bf/

If you just want to see it work try this:

### Hello World
taken from esolangs.org
```
+++++ +++ [ >++++ [ >++ >+++ >+++ >+ <<<<- ] >+>+>->>+ [<] <- ] >>. >---. +++++ ++..+++. >>. <-. <. +++.----- -.----- ---. >>+. >++.
```
### Text Editor
if you need something shorter.
```
+[,.]
```

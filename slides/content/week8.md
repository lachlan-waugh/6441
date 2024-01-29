---
title: "8: re"
layout: "bundle"
outputs: ["Reveal"]
---

## We'll get started at 18:05

---

{{< slide class="center" >}}
# reverse engineering
### 6441 week8

---

## good faith policy

We expect a high standard of professionalism from you at all times while you are taking any of our courses. We expect all students to act in good faith at all times

*tldr: don't be a ~~dick~~ jerk*

[sec.edu.au/good-faith-policy](https://sec.edu.au/good-faith-policy)

---

## housekeeping
![](assets/img/broom.gif)

---

{{% section %}}
## reverse engineering
the process of deconstructing a program to work out it's underlying code, architecture, design, etc

* essentially getting the source code of an application, without being given it

---

### what types of reverse engineering are there?
* static analysis: examine an executable without running it (disassembler)
* dynamic analysis: examine an executable by running it (debugger)

---

### to note:
* if you've written programs before, chances are you've used a debugger
* the process of debugging code (setting breakpoints, changing values during execution) is a lot dynamic analysis

{{% /section %}}

---

{{% section %}}

## static analysis
trying to understand the program by determining the original source code

---

### suggestions
* pattern recognition
* ignore the noise

---

### x86 assembly instructions
```
mov         # move a value into a register
add/sub     # 
inc/dec     # 
and/or/xor  # 
```

---

### some more
```
lea         # dereference pointer, move that value
pop/push    # grab from/put something on stack
cmp         # 
jmp         # jump to another memory location
je/jne      # jumps based on a condition
```

* read more [here](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)

---

### a note
it's not super important to understand it all

* you don't need to know what each individual instruction does
* you're just trying to work out the overall purpose/functionality
* get an understanding of the bigger picture, what the code did 

{{% /section %}}

---

{{% section %}}

## dynamic analysis
trying to understand the program by running it, and seeing how it behaviours

---

### the most basic way
* just run the program
* see how it responds to certain input
* see what paths you can traverse

---

### more advanced
* actual debuggers (e.g. gdb)
* if you've ever used cheat engine, it's essentially the same idea
* cheat engine is actually a really powerful tool

---

### breakpoints
`break *X`, where X is
* an address e.g. `0x12345678`
* a function e.g. `main`

---

### fuzzing
* another type of dynamic tool you can use
* basically just generates a bunch of input, and tries to get the application to crash

{{% /section %}}

---

### How to practice
* Just write some basic code, and run it through an analysis tool.
* It's not just C programs that can be reversed, python also compiles modules into bytecode (.pyc files), which could also be reversed
* try to identify patterns that appear


---

### CTF

---

##  case study
![](assets/img/week8/)

---

## questions?

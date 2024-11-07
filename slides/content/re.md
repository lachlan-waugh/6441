---
title: "re"
layout: "bundle"
outputs: ["Reveal"]
---

## We'll get started at 18:05

---

{{< slide class="center" >}}
# Reverse Engineering
### 6841 week9

---

## good faith policy

~~We expect a high standard of professionalism from you at all times while you are taking any of our courses. We expect all students to act in good faith at all times~~

~~[sec.edu.au/good-faith-policy](https://sec.edu.au/good-faith-policy)~~

> do this irl its really fun

---

{{% section %}}

### whoami
* lachlan/melon
* security engineer @ google
    * detection eng stuff
* teach `644[357]`
    * may meet some of you next year

---

### where slides
might be on webcms but I dont have access to that ll

> [waugh.zip/6441/re](https://waugh.zip/6441/re)

---

### shilling
COMP6447 is cool
* DO COMP6447
* DO COMP6447
* DO COMP6447
* DO COMP6447
* DO COMP6447
* DO COMP6447
* DO COMP6447
* DO COMP6447

<iframe width="560" style="position:absolute; height: 600px !important; bottom: -25%; left: -25%; overflow: visible" src="https://www.youtube.com/embed/i0M4ARe9v0Y?si=7PC6qY_KRjN1WJ2P&autoplay=1&mute=1&controls=0&modestbranding&showinfo=0" allow="autoplay" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

<iframe width="560" style="position:absolute; height: 600px !important; bottom: -25%; right: -25%; overflow: visible" src="https://www.youtube.com/embed/NX-i0IWl3yg?si=E2318HUCu79n2SUt?si=00VYhWc7SS7iG0tA?si=7PC6qY_KRjN1WJ2P&autoplay=1&mute=1&controls=0&modestbranding&showinfo=0" allow="autoplay" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

{{% /section %}}

---

{{% section %}}

### what is re?
**reverse engineering**

* *"the process of discovering the technological principles of a device, object, or system through analysis of its structure, function, and operation"*
* basically, **finding out how something works**
* we cover reverse engineering x86 binaries (& how to determine their original source code)

---

### why re?
* finding vulns (wargames?)
* malware ([what it do](https://bluecatnetworks.com/blog/dns-helped-stop-wannacry-ransomware-attack/))
* breaking drm/keygens ([mod 7](https://www.youtube.com/watch?v=cwyH59nACzQ))
* understanding closed source software

> all code is oss if you're good at re

{{% /section %}}

---

{{% section %}}

### short aside
before re, what about e?

---

### compilation
how does your code become a binary?

<img height="500" style="margin-top: 0" src="../assets/img/re/compilation.svg"/>

---

### compilation is lossy
* compilers are really smart, and will [optimize](https://en.wikipedia.org/wiki/Optimizing_compiler) your bad code into good code 
* so the output doesn't reflect the input 1:1
* you'll lose context: variable names (not **always** symbols), comments, #DEFINEs

> optimization is the devil

---

### another aside
we're only talking about C binaries
* you can absolutely reverse other compiled languages: rust, golang, java, even pyc

> they're usually just a lot more tedious

{{% /section %}}

---

{{% section %}}

### how2re
surely theres an easier way to do this

![](../assets/img/re/hexdump.png)

---

### tooling
very important to have tools that perform analysis 

* *static*: read the program without running it
* *dynamic*: show the state of the program as it runs

---

### static analysis
*disassembling*

* examine an executable without running it
* what instruction do the bytes correspond to?

> e.g. ida, ghidra, radare, binary ninja

---

### dynamic analysis
*debugging*

* examine an executable by running it
* what are the register values at X point in time
* allows you to examine program state as it runs

> e.g. **gdb**, ltrace, strace, windbg

---

### another aside??
im an official:TM: default gdb hater

> if you're using gdb, install an extension e.g. [pwndbg](https://github.com/pwndbg/pwndbg), [gef](https://github.com/hugsy/gef), or [peda](https://github.com/longld/peda)

{{% /section %}}


---

{{% section %}}

### at a high level
reversing is hard, and takes a lot of time

* don't focus on every single instruction, try to understand the big picture
* its largely down to pattern recognition
* functions are super helpful (if they aren't stripped)

---

### what does this do?

![](../assets/img/re/wtf.png)

> lol idk either

---

### what about this instead?
time for a demo

<img height="500" src="../assets/img/re/strcat.png"/>

---

### dont scroll any further

---

### the original code
how close were we?

```C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *re3(char *s1, char *s2) {
    size_t a = strlen(s1);
    size_t b = strlen(s2);

    s1 = realloc(s1, (a + b + 1));

    memcpy(s1 + a, s2, b + 1);

    return s1;
}

int main(void) {
    return 0;
}
```

{{% /section %}}

---

{{% section %}}

### a bit deeper
how does assembly work

---

### registers

<img height="500" src="../assets/img/re/registers.png"/>

---

### stack frames

<img height="500" src="../assets/img/re/frame.jpg"/>

---

### calling conventions
x86 uses the [cdecl](https://en.wikipedia.org/wiki/X86_calling_conventions#cdecl) calling convention

* parameters are passed on the stack
* return value stored in eax
* caller allocs args/eip, callee ebp/locals
* callee also cleans up its args

> its just convention, not guaranteed. not everything uses it

---

### callee cleans up args
```
function(x, y, z):
push z
push y
push x
call function
add esp, 0xC
```

{{% /section %}}

---

{{% section %}}

### assembly

---

## the stack grows down
* the stack grows from high address to low addresses
* so the top of the stack, is lower down in memory 
* ebp points to the base of the frame (higher in memory)
* esp points to the top of the frame (lower in memory)

---

## stack frames
basic example

```
    0x30  [   ARGS   ] <- parameters
    0x28  [    EIP   ] <- stored return pointer
    0x20  [    EBP   ] <- stored frame pointer
    0x18  [ AAAAAAAA ] <- local vars
    0x10  [ 00000000 ] <- an int?
    0x08  [ DEADBEEF ] <- a pointer
    0x00  [ 59454554 ] <- 4 characters
```

---

## variables
referenced in relation to `ebp` e.g. `ebp-0x4`

* local vars are ~~above~~ lower, so `ebp-0x4`
* arguments are ~~below~~ higher so `ebp+0x8`

---

### what are the variables used for
instructions give context to the variables they act on

![](../assets/img/re/operation_implications.png)

---

### a question for you 
why are these instructions different?

```
mov eax, dword ptr [esp]
mov eax, word ptr [esp]
mov eax, byte ptr [esp]
mov ax, [esp]
mov al, [esp]
```

{{% /section %}}

---

{{% section %}}

### control

---

### instructions
* jmp/call
* push/pop
* add/sub
* mov/lea
* and/xor
* test/cmp

---

### mov
stands for **mov**e
```php
mov eax, ebx        # eax = ebx
mov eax, [ebx]      # eax = *ebx
mov eax, [ebx + 4]  # eax = *(ebx + 4)
```

> what might that last one represent?

---

### lea
stands for **l**oad **e**ffective **a**ddress

```php
lea eax, [ebx + 8]

# equivalent to
mov eax, ebx
add eax, 8
```

often used for fast addition/multiplication

```
lea eax, [ebx * 4 + 8]
```

---

### cmp & test
the two main comparison instructions

```php
TEST <a> <b>    # a & b
CMP  <a> <b>    # a - b
```

> Sets zero/negative/positive flags in EFLAGS

---

### jumping
now we've done a comparison, we can (maybe) jump

* theres a lot of types of jumps
    * jz: jump if zero flag set
    * jnz: jump if zero flag not set
    * jge (>=): positive || zero flag is set
    * jlt (<): negative flag set

> some will be signed comparisons, some not

{{% /section %}}

---

{{% section %}}

### deobfuscation
*degarbage*

---

```javascript
const print_nums = (nums) => {
  nums.forEach((e) => console.log(`Hello ${e}!`));
}
print_nums([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
```

---

```
(function(_0x20a892,_0x42c6a2){const _0x110cc6=_0x3fb9,_0x5e470a=_0x20a892();while(!![]){try{const _0x28667e=-parseInt(_0x110cc6(0xd6))/0x1+-parseInt(_0x110cc6(0xd5))/0x2+parseInt(_0x110cc6(0xd1))/0x3+parseInt(_0x110cc6(0xd3))/0x4+-parseInt(_0x110cc6(0xd2))/0x5+-parseInt(_0x110cc6(0xcf))/0x6+parseInt(_0x110cc6(0xce))/0x7;if(_0x28667e===_0x42c6a2)break;else _0x5e470a['push'](_0x5e470a['shift']());}catch(_0x44da5f){_0x5e470a['push'](_0x5e470a['shift']());}}}(_0x51e8,0x1d318));const _0x3701c2=_0x1e33b1=>{const _0x312fdd=_0x3fb9;_0x1e33b1[_0x312fdd(0xd4)](_0xd313=>console['log'](_0x312fdd(0xd0)+_0xd313+'!'));};function _0x3fb9(_0x442c25,_0x161fd0){const _0x51e8ef=_0x51e8();return _0x3fb9=function(_0x3fb99b,_0x2e90f0){_0x3fb99b=_0x3fb99b-0xce;let _0x53b2c7=_0x51e8ef[_0x3fb99b];return _0x53b2c7;},_0x3fb9(_0x442c25,_0x161fd0);}function _0x51e8(){const _0x363b8b=['1406202HDigRG','486342oaFrmi','Hello\x20','679206PuoPaQ','614310PnzrDk','630464HDiLMH','forEach','257710HKLNTu','132554IxtBWS'];_0x51e8=function(){return _0x363b8b;};return _0x51e8();}_0x3701c2([0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xa]);
```

{{% /section %}}

---

## questions?

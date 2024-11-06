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

---

### why re?
* finding vulns (wargames?)
* malware ([what it do](https://bluecatnetworks.com/blog/dns-helped-stop-wannacry-ransomware-attack/))
* breaking drm/keygens ([mod 7](https://www.youtube.com/watch?v=cwyH59nACzQ))

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
* you'll lose context: variable names (not always symbols), comments, #DEFINEs

> optimization is the devil

---

### registers

<img height="500" src="../assets/img/re/registers.png"/>

{{% /section %}}

---

{{% section %}}

### how2re
surely theres an easier way to do this

![](../assets/img/re/hexdump.png)

---

### tooling
very important to 

static analysis: tools 

dynamic analysis: show you the state of the program as it runs

{{% /section %}}

---

{{% section %}}

### static analysis
*disassembling*: examine an executable without running it

> e.g. ida, ghidra, radare, binary ninja

---

{{% /section %}}

---

{{% section %}}

### dynamic analysis
*debugging*: examine an executable by running it

e.g. **gdb**, windbg, cheat engine

> allows you to examine the state of the program as it runs

---

> if you're using gdb, install an extension e.g. [pwndbg](https://github.com/pwndbg/pwndbg), [gef](https://github.com/hugsy/gef), or [peda](https://github.com/longld/peda)

{{% /section %}}

---

{{% section %}}

### deobfuscation
*degarbage*

{{% /section %}}

---

## questions?

---
title: "Week05"
layout: "bundle"
outputs: ["Reveal"]
---

## We'll get started at 18:05

---

{{< slide class="center" >}}
# format strings
### 6441 Week05

---

## good faith policy

We expect a high standard of professionalism from you at all times while you are taking any of our courses. We expect all students to act in good faith at all times

*tldr: don't be a ~~dick~~ jerk*

[sec.edu.au/good-faith-policy](https://sec.edu.au/good-faith-policy)

---

{{% section %}}

## housekeeping
![](assets/img/broom.gif)

---

### make sure you're doing the extended challenges
buffer overflows, format strings, xss, sqli

* 

{{% /section %}}

---

{{% section %}}

## questions

---

### public/private keys
if 10 people wanted to communicate privately (one-on-one), how many:
* AES keys/key-pairs would they need?
* RSA keys/key-pairs would they need?

---

### bits of work
How many bits of work will it take to brute-force a 6-character password (consisting of numeric digits, lower-case, and upper-case letters) if every password takes 10 bits of work to check

* in the worst case?
* in the average case?
* in the best case?

---

### merkle puzzles
* Suppose for a Merkle puzzle it takes 1 second to encrypt, 5 seconds to decrypt (if you have the key), 10 minutes to decrypt (bruteforcing)
* Alice sends Bob 1000 puzzles so that Bob can select the key they are going to use for an upcoming encrypted chat.
* Approx. how many seconds, on average, does it take Bob to choose a key, and communicate this to Alice?  (measure the elapsed duration from when Bob receives collection of puzzles to when he first replies to Alice)

---

### 
[rsa tutorial](https://featherbear.cc/tutoring-unsw-22t1-cs6441/rsa/tutorial.html) 

{{% /section %}}

---

## lecture content
* format strings
* where to write
* memory protections

---

{{% section %}}

### printf (and it's siblings)
* `[v,va,s,sn,f]printf`
* `[v,va,s,sn,f]scanf`
* `setproctitle`, `syslog`, and others!

---

### anatomy of a format string
`%<flags><width><precision><modifier><type>`

---

## types
* `%d`: print as signed decimal
* `%x`: print as hex
* `%c`: print as a character
* `%p`: print out a value as a pointer
* `%s`: print as a string?
* `%n`: huh?
* ... more [here](https://www.freecodecamp.org/news/format-specifiers-in-c/)

---

## modifiers
* `h`: print half 
	* `%hd`: print bottom 2 bytes
	* `%hn`: write two bytes
* `hh`: print half half (quarter)
	* `%hhd`: print bottom byte
	* `%hhn`: write one byte

---

## width (minimum width)
* you can pad your input, like `zfill()` in python 
* `%10c` pads the argument to 100 bytes

```C
printf("%10c", 5);
>         5
```

```C
printf("%10c", 10)
>        10
```

---

## index
* not included in the graphic, woops
* which argument we want to print from/to
* e.g. `%10$x` prints the 10th argument as hex

```C
int a = 1, b = 2, c = 3;
printf("%2x", a, b, c);
> 0x2
```

---

## This is a hacking course, why should I care?

---

### what is a format string 

```C
char buffer[30] = "the quick brown fox";
printf("The length of '%s' is %d\n", buffer, strlen(buffer));
// The length of 'the quick brown fox' is 19
```

---

### okay but...

```C
printf("The length of '%s' is %d\n");
// The length of '????' is ???
```

```C
char buffer[30] = "The length of '%s' is %d\n");
printf(buffer);
```

> what do these do?

---

* when you don't provide arguments (apart from the format string) `printf(buffer);`. 
* where does it gets it's arguments from?
* it'll just start grabbing values from the stack, where the arguments **should** be

---

> time 2 draw

{{% /section %}}

---

{{% section %}}

## where to write
* overwrite variables
* overwrite function pointers
	* PLT / GOT
	* function hooks (malloc hook, free hook, \_\_atexit)

---

## potential issues when writing 
* padding
* writing addresses?
* writing zeros?

---

## padding
* to read/write an address, it need's to be aligned in one of the stack addresses
* so if you see it isn't correctly aligned, just add some padding.

```
		     AAAA             BBAAAA
		| ---------- |    | ---------- |
		| 0x41410000 | -> | 0x41414141 |
		| 0x00004141 | -> | 0x00004242 |
		| ---------- |    | ---------- |
```

* small demo 

---

## Writing addresses
* it's fine to write a small int to a variable
	* e.g. for `10` you'd just need to write `10` chars + %n
	* what about `0x08041234(134484532)`, how do we write 134M chars?
* write 1 byte at a time to `addr,addr+1...`

---

## Where can I write?
* you can write to stack variables
	* if there's an address on the stack, you can read/write it
	* if your input is on the stack, you can read/write anywhere (just put an address in your payload, and read/write there)

{{% /section %}}

---

{{% section %}}

## Protections
* ASLR + PIE
* RELRO
* PAC
* NX
* Fortify

---

## TLDR
*ASLR*: randomizes the programs location in memory

*PIE*: program can only use relative jumps (needs ASLR)

*RELRO*: GOT is Read-Only (partial is trash, full is RIP)

*PAC*: you can only jump to signed pointers 

*NX*: the stack isn't executable (no shellcode)

*Fortify*: %n only allowed if fmtstr in read-only memory 

---

## recognise leaked addresses
* `0x565...`: binary base (PIE enabled)
* `0x804...`: binary base (PIE disabled)
* `0xf7f...`: library base
* `0xff....`: stack base

{{% /section %}}

---

##  case study
![](assets/img/week05/snoopy.png)

---

## questions?

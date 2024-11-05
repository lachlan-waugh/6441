---
title: "07: ctf"
layout: "bundle"
outputs: ["Reveal"]
---

## we'll get started at 18:05

---

{{< slide class="center" >}}
# ctf, rootkits && more
### 6441 week07

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

### revision
* cryptographic hash function w/ a 60 bit hash,
* on average 20 bits of work to hash a short document

On average how many bits of work would it take to find two short documents with the same hash
* one beginning with the word "banana"
* the other beginning with the word "fish" 

---

### solution
since I didn't do this last time

* There are `2^60` possible hashes
* Each hash takes `2^20` time to compute
* Due to the birthday attack, on average you need to find `sqrt(2^60)=2^30` hashes

> `2^30*2^20=2^50` (`50` bits of work)

---

### midterm revision quiz
apparently I wrote this last year

[joinmyquiz.com](joinmyquiz.com) : 880 493

> kinda like kahoot, but free

{{% /section %}}

---

{{% section %}}

### extended stuff
time 2 shill

---

### binary exploitation (6447)
if you enjoyed buffer overflows and format strings

> idk, ramble

---

### web exploitation (6443)
if you enjoyed xss and sqli

> idk, ramble

---

### ctf
[comp6841.quoccabank.com](https://comp6841.quoccabank.com)

{{% /section %}}

---

{{% section %}}

### course content
* Authentication
* MAC
* Privacy

---

### ~~course content~~
* ~~Authentication~~
* ~~MAC~~
* ~~Privacy~~

&nbsp;

### IoT malware
TODO

{{% /section %}}

---

##  case study
![](assets/img/week07/ghost.jpg)

---

## questions?

---
title: "03: xss"
layout: "bundle"
outputs: ["Reveal"]
---

## We'll get started at 18:05

---

{{< slide class="center" >}}
# cross-site scripting
### 6441 Week03

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

### logbooks
* Summary 👎
    * "short, concise, and comprehensive version of a longer original work."
* Analysis 👍
    * "a breakdown of the examination and evaluation of an original document or text."
    * cool people do this 😎!

---

### weekly challenges
* how are people finding them
* have you been trying the extended challenges

{{% /section %}}

---

{{% section %}}

### 
Play 20 questions with the person next to you.
* One person come up with "something"
* The other person asks 20 yes-no questions, to try to determine what that "something" is.

---

### hacking
Say you are the NSA, and you wanted to hack someone's phone, how would you do it?

---


### supply chain attacks
only as strong as the weakest link...

* Vulnerabilities in dependencies (either deliberate, or intentional)
    * How do you know that the libraries/packages you use are secure?
    * What about random applications that you install off the internet?

---

### log4j
* Mixing up of data and control
* Generally, internal systems won't be nearly as secure as external ones.

---

### solarwinds
solarwinds123

{{% /section %}}

---

{{% section %}}

## client-side injection
* html injection
* xss

---

## html injection

---

### html injection
* browsers just render the DOM
* how would it know if tags are user-supplied or server-supplied
* what if our input was just `<s>`?

---

### so what can we inject

know yours tags
* some are paired `<div></div>`
* some aren't `<img src=.../>`
* what goes in here? `<script>...</script>`

{{% /section %}}

---

{{% section %}}

## xss

---

### cross-site scripting
* another 'mixing of data and control' issue
* browsers are just html/css/js interpreters
* what if we tricked the **browser** into executing our code

---

### reflected xss
* payload is part of user input
    * e.g. a search query, cookie, header, etc 
    * anything insecurely rendered on the page

```html
<!-- www.example.com/database?q=dog -->
you have searched for 'dog'

<!-- www.example.com/database?q=<script>alert(1)</script> -->
you have searched for '<script>alert(1)</script>'
```

---

### stored XSS
* payload is stored persistently (e.g. in a database)
    * anybody who visits a certain page will view it
    * e.g. blog posts, twitter (lol)
* generally more dangerous, but more easily detected

---

### dom-based XSS
* similar to the others, but the vulnerability comes from modifying the DOM
* dw about this stuff, but interesting to know

```html
<script>
    const pos = document.URL.indexOf("context=") + 8;
    document.write(document.URL.substring(pos,document.URL.length));
</script>
```

---

### demo!

---

### xss isn't just `<script>` tags
```js
// event-handlers
<img src=x onerror=alert(1)/>
 
// injecting into javascript code
const a = '<user_input>'

// and much more
```

> it's any time you get user supplied input in a javascript context

---

### some good resources
* [PayloadAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XSS%20Injection)
* [OWASP Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/XSS_Filter_Evasion_Cheat_Sheet.html)
* [HackTricks](https://book.hacktricks.xyz/pentesting-web/xss-cross-site-scripting)
* [PortSwigger](https://portswigger.net/web-security/cross-site-scripting/cheat-sheet)

{{% /section %}}


---

##  case study
![](assets/img/week03/door.gif)

---

## questions?

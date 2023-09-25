---
title: "Week03"
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

{{% section %}}

---

### 

{{% /section %}}

## client-side injection
* html injection
* xss

---

{{% section %}}

## html injection

---

### html injection
* browsers just render the DOM
* how would it know if tags are user-supplied or server-supplied
* what if our input was just `<s>`?

---

### know your tags
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
www.example.com/database?q=eggs<script>alert(1)</script>
you have searched for 'eggs<script>alert(1)</script>'
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
```javascript
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
![](assets/img/week0/)

---

## questions?

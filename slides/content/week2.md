---
title: "02: sqli"
layout: "bundle"
outputs: ["Reveal"]
---

## We'll get started at 18:05

---

{{< slide class="center" >}}
# sqli
### 6841 week02

---

{{% section %}}

## housekeeping
![](../assets/img/broom.gif)

---

### class notes
our tutorial is scheduled to do the lecture notes for the wednesday lecture of week 4

---

### class representatives
you get to attend meetings with Richard?

* have they mentioned this?
* if you want to nominate yourself, cool
* maybe we can vote as a class?

---

## logbooks

---

### feedback on logbooks
* some didn't do the learning community/dealing with challenges sections.
    * this is worth 40% of the mark per week, you should do it.
* if you're unsure how to approach the it, check out some other people's logbook

---

### non-technical questions
try to focus on analysis, rather than just noting down what you read
* what conclusions did you come to?
* what made you come to them?
* what did you learn?

---

### technical questions
* just showing you solved it (e.g flag) isn't enough
* show me what you didn't work (and why not? or why YOU didn't think it worked)
* show me the process you took to get the solution, not the solution!

---

### what do I want
do just this stuff

* case study analysis
* extended challenge (e.g. SQLi, XSS)
* 50%\* of the other challenges 

> \* rounded up

---

## something awesome

---

### what to do now
* plan it now, before you start working on it.
* work on your marking criteria (pls).
* post weekly update blogs!
    * easier to determine how much time you put in
    * stops you from leaving it all until the last minute

---

### what to do throughout the term
* you should spend around 30 hours total on it.
* at the end of term, you present what you produced
    * you record a video presentation (marked), and
    * present it during the tutorial (not marked)

> if it has something targeting others, you need their express permission

---

### who doesn't love presenting
share what you're planning on doing for your Something Awesome!

{{% /section %}}

---

{{% section %}}

## woops
some stuff I forgot to mention last week

---

## COMP6441 vs COMP6841
* extended isn't much more difficult, there's just "different" content.
* different (better) weekly challenges, exam questions, and an extra lecture hour each week.
* if you're technically-inclined, I'd recommend 6841.
* generally extended security courses are intended for people with an interest in pursuing security-adjacent careers

---

### other security courses
ones i've done, in order of goodness
* COMP6447
* COMP6[84]43
* MATH3411
* COMP9447
* COMP6[84]45

---

### even more
others I haven't done
* COMP9301
* COMP6448
* COMP4337

{{% /section %}}

---

{{% section %}}

### what is the most insecure part of
* a system (e.g. a bank or banking app)?
* password authentication (think outside the box)

---

### what is the CIA triad?

* CDont hack me pls
* Idk
* A

---

### what is the general anatomy of an attack

1. 
2. 
3.
4.
5.

---

### what is security by design

* what is shifting security left?
* why is this important/beneficial
* proactive good, reactive bad?

---

### what are type I and II errors?

this slide is intentionally blank

{{% /section %}}

---

# questions?

---

{{% section %}}

# SQL
> structured query language
* SQLite, PostgreSQL, MySQL, MSSQL Server

---

Queries >
* `SELECT <column> FROM <table>;`
* `INSERT INTO table VALUES (a, b);`
* `UPDATE table SET ... = ...`
* ~~`DELETE FROM table ...`~~ (*pls dont*)
* `-- a comment (also #)`

---

SELECT \* FROM table WHERE ...
* `col =  ...`
* `col >  ...`
* `col <  ...` 
* `col <> ...	#` not equals (!=)
* `col LIKE ...	#` regexp
  * `_` `(.)` and `%` `(.*)` are wildcards

---

`SELECT user, pass FROM users UNION SELECT title, author FROM blogs`
```
  user	  pass	     id	  title   author	THE UNION
|=======|=======|   |===|=======|=======|   |=======|=======|
| admin	| admin	|   | 1 | blog1 | melon |   | admin | admin |
| melon	| water	|   | 2 | blog2 | admin |   | melon | water |
|=======|=======|   | 3 | blog3 | admin |   | blog1 | melon |
		            |===|=======|=======|   | blog2 | admin |
		 		                      	    | blog3 | admin |
      users     		   blogs        	|=======|=======|
```

---

## Notes on UNIONs
* the query needs to extract the same number of columns from both tables
* the data-type for the columns must be compatible
* you can also UNION the same table

---

> fingerprinting
* work out the flavour/version
	* **MySQL**: `Version()`
	* **SQLite**: `sqlite_version()`
	* **MSSQL**: `@@Version`

---

> finding the schema
* what tables exist, what do they look like?
	* **MySQL**: `information_schema.[tables|columns]`
	* **SQLite**: `sqlite_[master|schema]`
	* **MSSQL**: `SHOW TABLES; DESCRIBE <table_name>`

{{% /section %}}

---

## SQLi
{{% section %}}

### SQL Injection
* *tldr*: blindly trusting user input is bad

* what if we injected control characters which changed how the database interprets the query? e.g. inject our own `UNIONS/WHERES/etc`

* how could it tell the difference?

---

### How does SQLi work

```sql
SELECT * FROM users WHERE user = '{input}' AND password = '{...}'
```

&nbsp;  

If our input was: `' OR 1=1 --`

```sql
--                        vvvvvvvvvvvvvvvvvvvv
SELECT * FROM users WHERE user = '' OR 1=1 --'and password = '...'
--                        ^^^^^^^^^^^^^^^^^^^^
-- user = '' is always false, but 1=1 is always true
-- so this will return every user from the database
```

---

### issues you may encounter
* syntax needs to be correct, or you'll throw an error
  * so, determine syntax through errors/fingerprint

* you have SQLi in `items`, but want `users`
  * find out the tables? (database schema)
  * include that table with a `UNION`

{{% /section %}}

---

# demo
> a basic login form

---

## mitigations

{{% section %}}

### defense
* reduce information disclosure
  * don't display error messages
  * just fail or show a basic error message (e.g. `'username or password incorrect'`)
* strip out malicious content (e.g. use a WAF)
* block requests with anything sus (*kinda bad UX*)

---

### better defence
* don't use raw content
  * use parameterised queries rather than raw input
  * use an ORM (database as an object)

> note: these have historically still been vulnerable, don't solely rely on them

---

### offense

* content stripped?
  * embed dummy characters (oORr)
  * use alternating case (WhErE)
* no response?
  * timing Attacks (IF success THEN sleep(1))
  * error-based extraction (get the output in an error)
  * boolean-based extraction (IF success THEN ...)

{{% /section %}}

---

# Questions

---

## Case Study
![](../assets/img/week02/drill.gif)

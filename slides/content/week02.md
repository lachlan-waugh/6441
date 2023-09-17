---
title: "02: sqli"
layout: "bundle"
outputs: ["Reveal"]
---

## We'll get started at 18:05

---

{{< slide class="center" >}}
# sqli
### 6441 week02

---

{{% section %}}

## housekeeping
![]()

---

### class notes
Our tutorial is scheduled to do the lecture notes for the ???? lecture of week ????

---

## logbooks

---

### feedback on logbooks
* Some didn't do the learning community/dealing with challenges sections.
    * This is worth 40% of the mark per week, you should do it.
* if you're unsure how to approach the challenges/logbook, check out XXXXXX's logbook, it's very good

---

### non-technical questions
Try to focus on analysis, rather than just noting down what you read
* What conclusions did you come to?
* What made you come to them?
* What did you learn?

---

### technical questions
* Just showing you solved it (e.g. a flag) isn't really enough
* Show me what you didn't work (can you show me why it didn't work? or why YOU didn't think it worked)
* Show me the process you took to get the solution, not the solution!

---

## something awesome

---

Plan everything now, before you start working on it.
Maybe post your own marking/success criteria (pls).
Post weekly update blogs!
* Easier for me to determine how much time you've put in
* Stops you from leaving it all until the last minute
* Research report, CTF

---

You should spend around 30 hours total on it.
At the end of term, you present what you produced, you record a video presentation (marked), and present it during the tutorial (not marked)
If your SA has something targeting other people/places, you need their express permission (e.g. if you're auditing your workplace)

---

Everyone, share what you're planning on doing for your Something Awesome!

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

## other security courses
in order of goodness

* COMP6447
* COMP6[84]43
* MATH3411
* COMP9447
* COMP6[84]45

{{% /section %}}

---

{{% section %}}

### NIST password guidelines
* Length > Complexity.
* Eliminate Periodic Resets.
* Enable “Show Password While Typing”
* Allow Password “Paste-In”
* Use Breached Password Protection.
* Don't Use “Password Hints”
* Limit Password Attempts.
* Use Multi-Factor Authentication.

---

### What is the most insecure part of
* a system (e.g. a bank or banking app)?
* password authentication (think outside the box)

{{% /section %}}

---

questions?

## SQL

{{% section %}}
> Structured Query Language
* SQLite, PostgreSQL, MySQL, MSSQL Server

---

> Fingerprinting
* work out the flavour/version
	* **MySQL**: `Version()`
	* **SQLite**: `sqlite_version()`
	* **MSSQL**: `@@Version`

---

> Finding the schema
* what tables exist, what do they look like?
	* **MySQL**: `information_schema.[tables|columns]`
	* **SQLite**: `sqlite_[master|schema]`
	* **MSSQL**: `SHOW TABLES; DESCRIBE <table_name>`

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

# Case Study
![]()

---

### 

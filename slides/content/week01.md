---
title: "Week01"
layout: "bundle"
outputs: ["Reveal"]
---

## we'll get started at 18:05

---

{{< slide class="center" >}}
# course intro && sqli
### 6841 week01

---

{{% section %}}

## > whoami

* Lachlan
* TODO: more stuff here

---

## how to contact me

* lachlan.waugh@student.unsw.edu.au
* [@melon]() on the SecEdu Slack
* [@melon]() on the SecSoc Discord

---

## places for course discussion

* [discord.gg/TODO](https://discord.gg/TODO)
    * ~/security/ > comp6441-6841

* [seceduau.slack.com/signup](https://seceduau.slack.com/signup)
    * #cs6441

{{% /section %}}

---

{{% section %}}

![](../img/week01/icebreaker.jpg)

---

## > whoru
* what's your name/degree?
* why did you decide to do this course?
* what's your favourite course you've done, and why?

{{% /section %}}

---

## OpenLearning
* walkthrough (wow!)
* join the H18B-6841 Tutorial Group (if you haven't already)
* change your profile picture to a picture of yourself (or don't)

---

## Good faith policy

we expect a high standard of professionalism from you at all times while you are taking any of our courses. We expect all students to act in good faith at all times

*tldr: don't be a ~~dick~~ jerk*

[sec.edu.au/good-faith-policy](https://sec.edu.au/good-faith-policy)

---

{{% section %}}
# admin stuff

---

## assessments
I have no idea about the weightings

* logbook: 30%?
* something awesome: 30%?
* final: 40%?

---

## weekly challenges/log book
* set up your logbook (Celeste's is a template)
* each week, put a link to your challenge answers in your logbook
* mark the challenge that you're most proud of with an X or something
* your answers and marks are posted publicly

---

## marking criteria

grade     |  marks | description                                                                                  |
----------|--------|----------------------------------------------------------------------------------------------|
excellent | 85-100 | work with impressive elements significantly exceeding what would be regarded as satisfactory |
good 	  | 60-75% | acceptable work demonstrating solid and satisfactory level of achievement for the criteria   |
partial   | 30-45% | borderline work. demonstrates some relevant skills and work but below the level expected     |
absent 	  |    0   | no serious attempt made

---

## something awesome
* worth 30% of your grade
* there's a document outlining a bunch of ideas, you can select from it, or propose something new if you'd like.
* make a blog post describing your idea, and send it to me by Sunday

---

## something awesome options
* learning: e.g. coding or lockpicking
* teaching: pick something from the first 4/5 weeks of term, spend week 6 teaching that to someone (or a group of people)
* auditing: pick something real (e.g. lecture halls at UNSW, not your house), and write up a document explaining any vulnerabilities in it's security.

---

## hall of fame
* present something for about 3-5 minutes during a tutorial.
* it can't just be something from the lectures.
* bonus marks!?
    * one, maybe two if you hack NASA or something.

---

## simplified grading
huh

* apparently you can opt for a pass/fail system of grading
* but a pass is a 70, and fail is ?? idk
* you can change this anytime up until monday week 7

{{% /section %}}

---

# case study
![](week01/earthquake.jpg)

---

## questions?

---

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

### Issues you may encounter
* syntax needs to be correct, or you'll throw an error
  * so, determine syntax through errors/fingerprint

* you have SQLi in `items`, but want `users`
  * find out the tables? (database schema)
  * include that table with a `UNION`

{{% /section %}}

---

# SQLi Demo
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

## COMP6441 vs COMP6841
* extended isn't much more difficult, there's just "more" content.
* a few more weekly challenges, "extra" exam questions, and an extra lecture hour each week.
* if you're technically-inclined, I'd recommend 6841.
* generally extended security courses are intended for people with an interest in pursuing security-adjacent careers

---

## Other security courses
in order of goodness

* COMP6447
* COMP6[84]43
* COMP9447
* COMP6[84]45
* COMP6448
* MATH3411

---

# done
## thank you :)

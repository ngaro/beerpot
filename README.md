# Beerpot

A honeypot in docker meant for human attackers.

## Description

Beerpot is a [honeypot](https://en.wikipedia.org/wiki/Honeypot_(computing)) inside a container.

Although it's mostly meant to trap/attract real humans, it can also be used to attract bots.<br>
See also the section on [Usage](README.md#Usage) for extra use cases.

**The main consideration in the code is the safety of the person hosting it.**<br>
Please [file an issue](https://gitlab.com/ngaro/beerpot/-/issues/new) if you notice any issues.
This includes possible problems not mentioned in this documentation.

In general you can expect the following problems when hosting honeypots:
- They can be used as gateway to break into the host and/or other systems.
- They can leak information of the host that is meant to be private.
- They can use more resources (e.g. RAM, CPU, Network bandwidth ...) of the host than allowed and/or let it crash.

**The same problems all hold when honeypots are incorrectly used, so make sure to read the section on [Usage](README.md#Usage).**<br>
We will try to avoid all of these problems in code and by adding enough documentation.

See also [License and requests](README.md#License and request) for more information on allowed usage of beerpot and how you can contribute.

## Installation

**TODO...**

## Usage

**TODO...**

## Support

- Contact me (username <code>garo</code>) on the IRC network [Libera.Chat](https://libera.chat/) for a quick question[^1].
- Place more advanced questions on [Serverfault](https://serverfault.com/). (Part of the StackExchange network)
- [File an issue](https://gitlab.com/ngaro/beerpot/-/issues/new) if you have a good reason to assume there is a bug.

[^1]: *A suggested read before asking questions is: ["How To Ask Questions The Smart Way"](http://catb.org/~esr/faqs/smart-questions.html)<br>
(These guidelines hold for most questions in the world of free and open source software)*

## Project status and roadmap

Under heavy development and barely usable...

## Authors and acknowledgment

For now I am the only author, tester and user.<br>
But I would already like to thank any future contributor. Whether is for programming, documenting, testing, popularizing, ...

## License and requests

- This project is licensed under GPLv3. See the file [LICENSE](LICENSE) for details.<br>
For this project a really important of the license is the one that boils down: **"Don't blame me if you end up in problems."**
- The following requests should only be treated as *requests*. You are free to ignore them, but I would certainly appreciate following them:

    - If you make changes in your version of this project and you assume others might be interested → Send a [Merge Request](https://gitlab.com/ngaro/beerpot/-/merge_requests/new).<br>*Even if your assume your changes are only usable to a small part of the user. In that case I might create an extra branch for them*

    - If you notice bugs → [File an issue in this repository](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: **"BUG: "**

    - If you have a feature request → [File an issue in this repository](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: **"FEATREQ: "**

    - If you can think of an interesting use case (not yet mentioned in [Usage](#Usage)) → [File an issue in this repository](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: **"INFO: "**

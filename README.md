# Beerpot

A honeypot in docker meant for human attackers.

## Description

Beerpot is a [honeypot](https://en.wikipedia.org/wiki/Honeypot_(computing)) inside a container.

Although it's mostly meant to trap/attract real humans, it can also be used to attract bots.
See also the section on [Usage](#Usage) for extra usecases.

**The main consideration in the beerpot-code is the safety of the person hosting it.**
Please [file an issue](https://gitlab.com/ngaro/beerpot/-/issues/new) if you notice any issues.
This includes possible problems not mentioned in this documentation.

In general you can expect the following problems when hosting honeypots.
- They can be used as a gateway to break into the host and/or other systems.
- They can leak information of the host that is meant to be private.
- They can use more resources (e.g. memory, cpu, networkbandwith ...) of the host and/or let it crash.
**(The same problems hold when honeypots are incorrectly used, so make sure to read the section on [Usage](#Usage)).**
We will try to avoid all of these problems in beerpot.

See also [License and requests](#License and request) for more information about how you are allowed to use beerpot and how you can contribute.

## Installation

**TODO...**

## Usage

**TODO...**

## Support

- Contact me (username <code>garo</code>) on the IRC network [Libera.Chat](https://libera.chat/) for a quick question.
- Place a more advanced question on [Serverfault](https://serverfault.com/) (this is a part of StackExchange)
- [File an issue](https://gitlab.com/ngaro/beerpot/-/issues/new) if you have a good reason to assume there is a bug.

*A suggested read before asking questions is: ["How To Ask Questions The Smart Way"](http://catb.org/~esr/faqs/smart-questions.html)
These guidelines hold for most questions in the free software world or even IT in general*

## Project status and roadmap

*Under heavy development and barely usable...*

## Authors and acknowledgment

For now I am the only author, tester and user.
But I would already like to thank any future contributor. Whether is for programming, documenting, testing, popularizing, ...

## License and requests

- This project is licensed under GPLv3. See the <code>LICENSE</code> for details.
For this project a really important of the license is the one that boils down: "Don't blame me if you end up in problems."
- The following are only *requests* of me. You are free to ignore, but I would certainly appreciate them:
    - If you make changes in your version of this project and you assume others might be interested please send a [Merge Request](https://gitlab.com/ngaro/beerpot/-/merge_requests/new). *Even if your assume your changes ar only usable to a small part of the user. In that case I might create an extra branch for them*
    - If you notice bugs: [File an issue in this repo](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: "BUG: "
    - If you have a feature request: [File an issue in this repo](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: "FR: "
    - If you can think of an interesting usecase (not yet mentioned in [Usage](#Usage)): [File an issue in this repo](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: "INFO: "

# Beerpot

A honeypot in docker meant for human attackers.

## Description

Beerpot is a [honeypot](https://en.wikipedia.org/wiki/Honeypot_(computing)) inside a container.

Although it's mostly meant to trap/attract real humans, it can also be used to attract bots.<br>
See also the section on [Usage](README.md#Usage) for extra use cases.

**The main consideration in the code is the safety of the person hosting it.**<br>
Please [file an issue](https://github.com/ngaro/beerpot/issues) if you notice any issues.
This includes possible problems not mentioned in this documentation.

In general you can expect the following problems when hosting honeypots:
- They can be used as gateway to break into the host and/or other systems.
- They can leak information of the host that is meant to be private.
- They can use more resources (e.g. RAM, CPU, bandwidth, ...) of the host than allowed and/or let it crash.

**The same problems all hold when honeypots are incorrectly used so make sure to read [Usage](README.md#Usage).**<br>
We will try to avoid all of these problems in the code and by adding enough documentation.

Don't forget to checkout [License and requests](README.md#License_and_requests) for more info on allowed usage of Beerpot and how you can contribute.

## Installation

You can just run `./build.sh` and answer the questions.<br>
When in doubt, it's usually best to just press ↵ to take the default option.

**Advanced installation:**<br>
You can overwrite the filesystem in your beerpot by changing the files in `/rootfs`<br>The whole filestructure there will end up in `/` on Beerpot.<br>
Do this before running `./build.sh`

Note: Some changes will be automatically made in the files in `/rootfs` when building:
- In the resulting `/etc/motd` every `---OWNER---` will be replaced by the owner asked by `./build.sh`
- In the resulting `/etc/motd` every `---USER---` will be replaced by the username asked by `./build.sh`

## Usage

### WARNING: Running the code as mentioned below places NO restriction on resources

This means that the attacker can crash your host or in the worst case even damage the hardware.<br>
I will try to describe a **safe** way to run it as soon as I am sure it is indeed safe.<br>
For now, here are some **unsafe** ways:

- You can just run `docker run -d --rm -p 22:22 --name beerpot beerpot`<br>*You can now also see the connections (and attempts) with `docker logs beerpot`*

- When you are using a firewall, the following is also an interesting setup:<br>*(It makes sure that IP's you trust end up on the host while the rest of the internet ends up at Beerpot)*

    - Change the `-p` option to `-p someOtherPort:22`<br>*(Set `someOtherPort` to a number above 1024 or you might run into problems)*

    - Change the firewall rule that forwards all incoming traffic on `tcp/22` to `tcp/22` on your host in such a way that only connections from IP's you trust are forwarded.

    - Add a rule that forwards the traffic from the rest of the internet to `someOtherPort`

- Once you manage to restrict resources attackers will often manage to crash the container.<br>*(This is wanted behaviour)*<br>Also consider using the option `--restart=always` so that you don't have to restart it manually.

### Other use cases

#### Situation: You need to access to a system of somebody else but that system is behind a firewall

*The following solution for this situation will only work if you enabled portwarding in `./build.sh`<br>This is **not** a good idea if honeypot-usage is your main purpose for Beerpot.*

1. Ask that person to run `ssh -fNT -R RANDOM_PORT:localhost:22 user@beerpot`<br>*(`RANDOM_PORT` should be a number between 1024 and 65535)*
2. Run `ssh -fNT -L RANDOM_PORT_ON_YOUR_SYSTEM:localhost:RANDOM_PORT user@beerpot`<br>*(`RANDOM_PORT_ON_YOUR_SYSTEM` should be a number between 1024 and 65535)*
3. Run `ssh -p RANDOM_PORT_ON_YOUR_SYSTEM HIS_USERNAME@localhost`<br>*(He will obviously have to provide HIS_USERNAME and his password, how else will you login...)*

- The result will now be the same as `ssh HIS_USERNAME@HIS_SYSTEM` if there was no firewall.<br>
- If you wanted to reach another system behind that firewall, you could have asked him to change `localhost:22` to `OTHER_SYSTEM:PORT_OF_THE_SERVICE_YOU_NEED` *(e.g `ftp_server_on_his_lan:21`)*<br>
- This technique can also be used without Beerpot but would require an account for that person on your system.<br>*(Which is dangerous if you don't trust that person)*

## Support

- Contact me (username <code>garo</code>) on the IRC network [Libera.Chat](https://libera.chat/) for a quick question[^1].
- Place more advanced questions on [Serverfault](https://serverfault.com/). (Part of the StackExchange network)
- [File an issue](interesting) if you have a good reason to assume there is a bug.

[^1]: *A suggested read before asking questions is: ["How To Ask Questions The Smart Way"](http://catb.org/~esr/faqs/smart-questions.html)<br>
(These guidelines hold for most questions in the world of free and open source software)*

## Project status and roadmap

Under heavy development and barely tested...

## Authors and acknowledgment

For now I am the only developer, tester and user.<br>
But I would already like to thank any future contributor.<br>Whether is for programming, documenting, testing, popularizing, ...

## License and requests

- This project is licensed under GPLv3. See the file [LICENSE](LICENSE) for details.<br>
For this project a really important of the license is the one that boils down to:<br>**"Don't blame me if you end up in problems."**
- The following requests should only be treated as *requests*.<br>You are free to ignore them, but I would certainly appreciate it if you follow them:

    - If you make changes in your fork and you assume others might be interested → Send a Pull Request.<br>*Even if you assume your changes are only usable to a small part of the userbase.<br>In that case I might create an extra branch for them*

    - If you notice bugs → [File an issue](https://github.com/ngaro/beerpot/issues) and start the title with: **"BUG: "**

    - If you have a feature request → [File an issue](https://github.com/ngaro/beerpot/issues) and start the title with: **"FEATREQ: "**

    - If you can contribute docs/info  → [File an issue](https://github.com/ngaro/beerpot/issues) and start the title with: **"INFO: "**

    - **The following is my most important request at the moment:**<br>If you have experience in limiting resources on containers → Add answers to [my StackOverflow question](https://stackoverflow.com/questions/70395953/how-can-i-limit-a-docker-container-resources).<br>That question already provides some information on how to restrict resources. But at this moment these are only *assumptions*. Chances are that some of them are wrong. Once they are confirmed I will update the [Usage](README.md#Usage) docs to make it more safe.

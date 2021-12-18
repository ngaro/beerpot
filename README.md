# Beerpot

A honeypot in docker meant for human attackers.

## Description

Beerpot is a [honeypot](https://en.wikipedia.org/wiki/Honeypot_(computing)) inside a container.

Although it's mostly meant to trap/attract real humans, it can also be used to attract bots.
See also the section on [Usage](#Usage) for extra use cases.

**The main consideration in the code is the safety of the person hosting it.**<br>
Please [file an issue](https://gitlab.com/ngaro/beerpot/-/issues/new) if you notice any issues.
This includes possible problems not mentioned in this documentation.

In general you can expect the following problems when hosting honeypots:
- They can be used as gateway to break into the host and/or other systems.
- They can leak information of the host that is meant to be private.
- They can use more resources (e.g. RAM, CPU, Network bandwidth ...) of the host and/or let it crash.<br>
**The same problems all hold when honeypots are incorrectly used, so make sure to read the section on [Usage](#Usage).**<br>
We will try to avoid all of these problems in beerpot.

See also [License and requests](#License and request) for more information about how you are allowed to use beerpot and how you can contribute.

## Installation

The only dependency is docker. How to install docker depends of which OS you are using, multiple guides are available online.<br>
This is how I do it on a Ubuntu 20.04 or Mint 20:<br>*(I use the official version, the procedure to install the one offered by Ubuntu is easier.)*
```bash
    apt-get -y install apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && \
    apt-get update && apt-get -y install docker-ce && \
    echo '{ "storage-driver": "overlay2" }' > /etc/docker/daemon.json && apt-get -y install docker-compose docker-ce-cli containerd.io && \
    echo "Installation OK" || echo "Installation Failed"
    After this I give my user permission to use docker and restart it
    usermod -G docker -a myUsername
```

Now that you have docker (or if you already had it) the installation of Beerpot is easy:

- You can just run `docker build -t beerpot .` *(Don't forget the trailing dot)*

- But you probaly want to use `docker build --build-owner OWNER="Your name" -t beerpot .` instead<br>
By supplying like this argument your name will appear in the honeypot everywhere it's talking about the owner.<br>
*Otherwise it would just mention "Somebody"*

- And if you want to change the default username (`user`) or password (`pass`) you can add `--build-arg USER=newusername --build-arg='new password'`

**Advanced:** You can change the filesystem by changing the files in `/rootfs`. The files here will end up in `/`.<br>
Note that string `---OWNER---` everywhere in `/rootfs/etc/motd` will be replaced by the contents of the buildargument `OWNER`

## Usage

**WARNING**: Running the code as mentioned in the methods below places NO restriction on resources.<br>
This means that the attacker can crash your host or in the worst case even damage the hardware.
*[My question on StackOverflow](https://stackoverflow.com/questions/70395953/how-can-i-limit-a-docker-container-resources) can provide some information on how to do this.<br>
At this moment it only contains my assumptions. Chances are that some of them are wrong. Once I get confirmation I will update the command below to a safe version<br>
If you have experience in limiting resources on docker containers, you can add answers there and they will also be posted here if they get enough upvotes to be trusted.*

- You can just run `docker run -d --rm -p 22:22 --name beerpot beerpot`.<br>*You can now alsosee the connections (and attempts) are visible with `docker logs beerpot`*

- When you are using a firewall, the following is also an interesting setup:<br>*It makes sure that connections from IP's you trust end up on the ssh-server of the host while the rest of the internet will end up at honeypot*

    - Change the `-p` option to `-p someOtherPort:22`<br>*(Set `someOtherPort` to a number above 1024 or you might run into problems)*

    - Change the firewall rule for the portward to tcp/22 on your host in such a way that only connections from IP's you trust are forwarded

    - Add a rule that forwards the traffic from the rest of the internet to `someOtherPort`

## Support

- Contact me (username <code>garo</code>) on the IRC network [Libera.Chat](https://libera.chat/) for a quick question.
- Place a more advanced question on [Serverfault](https://serverfault.com/) (this is a part of StackExchange)
- [File an issue](https://gitlab.com/ngaro/beerpot/-/issues/new) if you have a good reason to assume there is a bug.

*A suggested read before asking questions is: ["How To Ask Questions The Smart Way"](http://catb.org/~esr/faqs/smart-questions.html)<br>
These guidelines hold for most questions in the free software world or even IT in general*

## Project status and roadmap

Under heavy development and barely usable...

## Authors and acknowledgment

For now I am the only author, tester and user.<br>
But I would already like to thank any future contributor. Whether is for programming, documenting, testing, popularizing, ...

## License and requests

- This project is licensed under GPLv3. See the <code>LICENSE</code> for details.<br>
For this project a really important of the license is the one that boils down: **"Don't blame me if you end up in problems."**
- The following requests should only be treated as *requests*. You are free to ignore them, but I would certainly appreciate following them:
    - If you make changes in your version of this project and you assume others might be interested:<br>Please send a [Merge Request](https://gitlab.com/ngaro/beerpot/-/merge_requests/new). *Even if your assume your changes ar only usable to a small part of the user. In that case I might create an extra branch for them*
    - If you notice bugs:<br>[File an issue in this repository](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: "BUG: "
    - If you have a feature request:<br>[File an issue in this repository](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: "FR: "
    - If you can think of an interesting use case (not yet mentioned in [Usage](#Usage)):<br>[File an issue in this repository](https://gitlab.com/ngaro/beerpot/-/issues/new) and start the title with: "INFO: "

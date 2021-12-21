#!/bin/bash

#Check if we have docker
docker=$(which docker)
if [[ ! -x "$docker" ]] ; then
	echo "You do not have docker installed. Quitting..."
	exit 1
fi


#Ask all settings
read -p "What should be the name of the Beerpot image ? [beerpot] : " image
if [[ -z "$image" ]] ; then image="beerpot" ; fi
read -p "Which name should be mentioned as owner of the Beerpot ? (this is mentioned in e.g. /etc/motd) [Somebody] : " owner
if [[ -z "$owner" ]] ; then owner="Somebody" ; fi
read -p "What should the username be of the regular user in the Beerpot ? [user] : " user
if [[ -z "$user" ]] ; then user="user" ; fi
read -p "What should the password of $user be ? [pass] : " pass
if [[ -z "$pass" ]] ; then pass="pass" ; fi
read -p "Do you want to use the default ssh host keys ? [Yn] : " defaultkeys
if [[ -z "$defaultkeys" ]] ; then defaultkeys="y" ; fi
read -p "Should $user be allowed to forward ports over ssh ? [yN] : " enableportforwards
if [[ -z "$enableportforwards" ]] ; then enableportforwards="n" ; fi
shopt -s nocasematch


#Generate Dockerfile
cat << ENDOFNEWDOCKERFILE > Dockerfile
FROM alpine
RUN adduser -D $user && echo "$user:$pass" | chpasswd
COPY /rootfs /
RUN sed -i "s/---OWNER---/$owner/g" /etc/motd && sed -i "s/---USER---/$user/g" /etc/motd
RUN apk update && apk add openssh-server
ENDOFNEWDOCKERFILE

if [[ $enableportforwards == "y" || $enableportforwards == "yes" ]] ; then
cat << ENDOFNEWDOCKERFILE >> Dockerfile
RUN sed -i "s/^AllowTcpForwarding no/AllowTcpForwarding yes/" /etc/ssh/sshd_config
ENDOFNEWDOCKERFILE
fi

if [[ $defaultkeys == "n" || $defaultkeys == "no" ]] ; then
cat << ENDOFNEWDOCKERFILE >> Dockerfile
RUN rm /etc/ssh/ssh_host_rsa_key &&     ssh-keygen -f /etc/ssh/ssh_host_rsa_key     -N '' -t rsa && \
    rm /etc/ssh/ssh_host_ecdsa_key &&   ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key   -N '' -t ecdsa && \
    rm /etc/ssh/ssh_host_ed25519_key && ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
ENDOFNEWDOCKERFILE
else
cat << ENDOFNEWDOCKERFILE >> Dockerfile
RUN chmod 600 /etc/ssh/ssh_host_*
ENDOFNEWDOCKERFILE
fi

cat << ENDOFNEWDOCKERFILE >> Dockerfile
ENTRYPOINT /usr/sbin/sshd -D -e
ENDOFNEWDOCKERFILE

#build the image
$docker build -t $image .
if [[ $? == 0 ]] ; then
	echo "Beerpot image '$image' has been created."
else
	echo "Creation of Beerpot image'$image' has failed."
	exit 1
fi

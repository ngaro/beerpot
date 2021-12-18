FROM alpine
ARG USER=user
ARG PASS=pass
ARG OWNER=Somebody
RUN adduser -D $USER && echo "$USER:$PASS" | chpasswd
COPY /rootfs /
RUN sed -i "s/---OWNER---/$OWNER/g" /etc/motd && sed -i "s/---USER---/$USER/g" /etc/motd
RUN apk update && apk add openssh-server
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key     -N '' -t rsa && \
    ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key   -N '' -t ecdsa && \
    ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
ENTRYPOINT /usr/sbin/sshd -D -e

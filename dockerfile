FROM ubuntu:18.04
MAINTAINER dwesthuis <info@denniswesthuis.nl>

#INSTALL REQUIRED PACKAGES
RUN apt-get -qq update && \
apt-get install -yq gdisk xmount nano dc3dd openssh-server ewf-tools mdadm dcfldd gddrescue libewf-dev netcat afflib-tools lvm2 binutils xxd lshw lsscsi hdparm sleuthkit nmap python testdisk scalpel libregf-dev host curl dnsutils whois gcc g++ flex libssl-dev && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#SET ARGUMENTS
ARG UBUNTU_VERSION=18.04
ARG SSH_PASSWORD='SSH-P@SSw0rd!!'


RUN mkdir /var/run/sshd
RUN echo 'root:$SSH_PASSWORD' | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

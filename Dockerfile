FROM base

# Set up ssh 
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN /usr/sbin/sshd

# ssh login from vagrant without no password
RUN useradd vagrant
RUN mkdir -p /home/vagrant/.ssh
RUN chown vagrant /home/vagrant/.ssh
RUN chmod 700 /home/vagrant/.ssh

# ADD /home/vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys
# -> Not found
ADD ./id_rsa.pub /home/vagrant/.ssh/authorized_keys
RUN chown vagrant /home/vagrant/.ssh/authorized_keys
RUN chmod 700 /home/vagrant/.ssh/authorized_keys


CMD ["/usr/sbin/sshd", "-D"]

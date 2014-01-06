FROM base

# Set up ssh 
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN /usr/sbin/sshd
CMD ["/usr/sbin/sshd", "-D"]

# ssh login from OS X
RUN useradd taichi
RUN mkdir -p /home/taichi/.ssh
RUN chown taichi /home/taichi/.ssh
RUN chmod 700 /home/taichi/.ssh
# ADD /home/taichi/.ssh/id_rsa.pub /home/taichi/.ssh/authorized_keys
# -> Not found
ADD ./id_rsa.pub /home/taichi/.ssh/authorized_keys
RUN chown taichi /home/taichi/.ssh/authorized_keys
RUN chmod 700 /home/taichi/.ssh/authorized_keys

# sudo
RUN echo taichi:pass | chpasswd
RUN echo "taichi   ALL=(ALL)   ALL" > /etc/sudoers.d/taichi

# test package install 
RUN apt-get -y install git

EXPOSE 22
# ssh login from vagrant without no password
# RUN useradd vagrant
# RUN mkdir -p /home/vagrant/.ssh
# RUN chown vagrant /home/vagrant/.ssh
# RUN chmod 700 /home/vagrant/.ssh
# # ADD /home/vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys
# # -> Not found
# ADD ./id_rsa.pub /home/vagrant/.ssh/authorized_keys
# RUN chown vagrant /home/vagrant/.ssh/authorized_keys
# RUN chmod 700 /home/vagrant/.ssh/authorized_keys

# sudo
# RUN echo vagrant:vagrant | chpasswd
# RUN echo "vagrant   ALL=(ALL)   ALL" > /etc/sudoers.d/vagrant

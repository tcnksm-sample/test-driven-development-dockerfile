FROM base
MAINTAINER tcnksm "https://github.com/tcnksm"

# --------------------------------------------
# Setting for serverspec (ssh, sudoer)
# --------------------------------------------

# Install ssh
RUN apt-get update
RUN apt-get install -y openssh-server

# Setting ssh
RUN mkdir /var/run/sshd
RUN /usr/sbin/sshd
EXPOSE 22

# Creating user and setting its password
RUN useradd taichi
RUN echo taichi:pass | chpasswd

# Setting ssh login without password (from OSX)
RUN mkdir -p /home/taichi/.ssh
RUN chown taichi /home/taichi/.ssh
RUN chmod 700 /home/taichi/.ssh
ADD ./id_rsa.pub /home/taichi/.ssh/authorized_keys
RUN chown taichi /home/taichi/.ssh/authorized_keys
RUN chmod 600 /home/taichi/.ssh/authorized_keys

# Setting sudoer
RUN echo "taichi   ALL=(ALL)   ALL" > /etc/sudoers.d/taichi


# --------------------------------------------
# Build your own image
# --------------------------------------------

# e.g., package installation tested by serverspec
RUN apt-get -y install git

# e.g., docker specific command tested by docker remote api
WORKDIR /home/taichi
ENV TEST test
CMD ["sshd"]

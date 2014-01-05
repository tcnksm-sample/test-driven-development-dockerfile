# Test Dockerfile by Serverspec

Sample project TDD for Dockerfile with [serverspec](https://github.com/serverspec/serverspec)

## Usage



## serverspec

Init

```
$ bundle serverspec-init
Select OS type:

  1) UN*X
  2) Windows

Select number: 1

Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 1

Vagrant instance y/n: n
Input target host name: 192.168.50.4 # <- Use vagrant private network ip
```

Edit `~/.ssh/config`

```
Host 192.168.50.4
  HostName 192.168.50.4
  User taichi
  Port 7654
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /Users/taichi/.ssh/id_rsa
  IdentitiesOnly yes
  LogLevel FATAL
```

Set environmental variable

```
export SUDO_PASSWORD="pass"
```

## ssh

#### ssh from vagrant VM

```
# Dockerfile
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
```

Run container with portforward setting, 0.0.0.0:7654->22/tcp

```
docker run -p 7654:22 -d serverspec /usr/sbin/
```

Login with ssh

```
ssh vagrant@localhost -p 7654
```

## Reference

- [serverspec - home](http://serverspec.org/)
- [Experimenting with test driven development for docker](http://blog.wercker.com/2013/12/23/Test-driven-development-for-docker.html)
- [serverspecでサーバ環境のテストを書いてみよう](http://www.slideshare.net/ikedai/serverspec)
- [Docker (土曜日に podcast します) - naoyaのはてなダイアリー](http://d.hatena.ne.jp/naoya/20130620/1371729625)

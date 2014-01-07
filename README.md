# Sample TDD of Dockerfile by RSpec

This is sample project for Test Driven Development (TDD) of Dockerfile by RSpec. This means developing dockerfile by below cycle, 

- Write Rspec test
- Build Docker image and run test -> `RED`
- Edit Dockerfile
- Build Docker image and run test -> `GREEN`
- ...

When developing Dockerfile, docker image, we should test pakage installation and dockerfile specific command like `CMD` or `EXPOSE`. To do this I use belows,

- To test package installation, [serverspec](https://github.com/serverspec/serverspec)
- To test docker specific command, [docker-api](https://github.com/swipely/docker-api) which is [Docker Remote API]() wrapper.


## Environment

- OSX
- Docker on Vagrant VM

## Usage

```
$ ./build_and_test.sh
```

This script executes belows,

1. Build image, `docker -H :5422 build -t tcnksm/sample /vagrant/.`
1. Run container, `docker -H :5422 run -p 7654:22 -d serverspec /usr/sbin/sshd -D`
1. Run rspec test, `bundle exec rspec`
1. Delete container, `docker stop` and `docker rm`

## serverspec

### settings (ssh, sudoer)

To use serverspec, we need to prepare docker image which is prepared ssh and sudo user, see `Dockerfile`. In `Dockerfile`, to login the docker container by ssh without password, use public key on your localhost, prepare `id_rsa.pub` in project directory.

### serverspec

To install,

```
$ gem install serverspec
```

Initialize, 

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
Input target host name: 192.168.50.4
```

In `Vagrantfile`, private network IP "192.168.50.4" is assined to Vagrant VM. You should use it for target host name.

Edit `~/.ssh/config`, using vagrant private network IP. 

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

Set environmental variable for sudo, 

```
export SUDO_PASSWORD="pass"
```

or

```
export ASK_SUDO_PASSWORD=1
```

## Docker Remote API

[swipely/docker-api](https://github.com/swipely/docker-api)

To use remote API, need to change bind address, see `docker.conf`


## Reference

- [serverspec - home](http://serverspec.org/)
- [Experimenting with test driven development for docker](http://blog.wercker.com/2013/12/23/Test-driven-development-for-docker.html)
- [serverspecでサーバ環境のテストを書いてみよう](http://www.slideshare.net/ikedai/serverspec)
- [Docker (土曜日に podcast します) - naoyaのはてなダイアリー](http://d.hatena.ne.jp/naoya/20130620/1371729625)
- [Dockerで立てたコンテナにsshで接続する - $shibayu36->blog;](http://shibayu36.hatenablog.com/entry/2013/12/07/233510)

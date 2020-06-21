# Fish

Once you've cloned this repo `git clone https://github.com/wdiechmann/fish.git`
you'll have a basic Phoenix app with rudimentary
user registration/signin/-out, backed in Surface, TailwindCSS, and authorization using
OAuth (which will allow your users to authorize using eg Twitter, GitHub, et al),
ready to be deployed on your favorite hosting partners VM.

For you to hit the tarmac running all you have to do is follow this recipe (and I apologise if
your hosting provider does not provide you with a VM flavour supporting this 100%). Should you have a
fully operational server with Dokku on your hands already,
skip to the [Phoenix container](#phoenix_container) paragraph below!

## Basic server install

This recipe will not detail every step but point you towards recipes - who knows, you might decide to
buy into [Amazon](https://aws.amazon.com/), [Google](https://cloud.google.com/), [Microsoft Cloud](https://azure.microsoft.com/) provisions - or perhaps use guys like [UpCloud](upcloud.com) (I'm in no way
affiliated, or receiving any kickbacks, their just one example in a 'clouded' crowd).

You are, however, perfectly able to setup your own hardware and build your own (albeit small scale)
cloud provision.

- start by installing [VMWARE](https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.vsphere.solutions.doc%2FGUID-0A264828-3933-4F4F-82D7-B5006A90CDBA.html) on your hardware

- build your [first VM](https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.vsphere.solutions.doc%2FGUID-0A264828-3933-4F4F-82D7-B5006A90CDBA.html) (virtual machine) using [an image of Debian](https://www.debian.org/distrib/netinst) 9 - somewhat like [alain3888 do here](https://community.spiceworks.com/how_to/135817-install-debian-on-esxi)

By now you have a server installed and I guess/suggest you did [install/enabled](https://phoenixnap.com/kb/how-to-enable-ssh-on-debian) SSH!

## Docker and Dokku install

Docker affords managing any number (well theoretically at least) of containers on your VM (and yes this is
starting to look a lot like 'Russian Doll' but trust me, it works rather well!) and Dokku makes it easy
on your sore fingers to deploy containers.

- the nice guys at upcloud wrote a very nice and concise recipe on [installing both Docker and Dokku](https://upcloud.com/community/tutorials/get-started-dokku-debian/), heck it even includes a small test at the end allowing you to get your feet wet already!

<h2 id="phoenix_container">Phoenix container</h2>

This was quite a detour - but not the last I'm afraid even if I really try to restrain myself :)

In fact here is one more for you already! This repo uses a MySQL kind'a DB and if you are a PostgreSQL
guy you probably will start by changing the 'db driver' - and you might be tempted to fire up something like [this patching thing](https://www.pair.com/support/kb/paircloud-diff-and-patch/), but here's the thing: it's basically literally 1 line - and then changing passwords, but who's counting ;)

```
diff -r postgress/config/dev.exs mysql/config/dev.exs
4,6c4,6
< config :postgress, Postgress.Repo,
<   username: "postgres",
<   password: "postgres",
---
> config :mysql, Mysql.Repo,
>   username: "root",
>   password: "",
diff -r postgress/config/test.exs mysql/config/test.exs
8,10c8,10
< config :postgress, Postgress.Repo,
<   username: "postgres",
<   password: "postgres",
---
> config :mysql, Mysql.Repo,
>   username: "root",
>   password: "",
diff -r postgress/mix.exs mysql/mix.exs
39c39
<       {:postgrex, ">= 0.0.0"},
---
>       {:myxql, ">= 0.0.0"},

```

## Starting the Fish App

To start your cloned fish repo you have options:

- start it like any ordinary Phoenix App in development mode using `iex -S mix phx.server`
- release it and start it with something like `_build/dev/fish/bin/fish start`
- use the container(s) and start it with `docker-compose up`

That last option does however require that you have Docker Desktop installed on your local computer!

## Deployment

Read my post on https://cunnin.gs - retrofit the clone to your choice of db, server, etc and enjoy with a
single `git push dokku master`

## Notes

Below you will find a few references and quick notes I did while researching for this deploy

### Install

`docker-compose run web mix ecto.create`

`docker-compose run web mix ecto.migrate`

### Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

### MySQL

https://medium.com/@chrischuck35/how-to-create-a-mysql-instance-with-docker-compose-1598f3cc1bee
https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql

`docker exec -it fish_db mysql -uroot -p`
`CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';`
`GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';`
`flush privileges;`

\$ docker-compose exec db /bin/bash
root@a2b9625f63ab:/# ps
bash: ps: command not found
root@a2b9625f63ab:/# mysql  
Welcome to the MySQL monitor. Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.20 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use mysql;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> select host,user from user;
+-----------+------------------+
| host | user |
+-----------+------------------+
| localhost | mysql.infoschema |
| localhost | mysql.session |
| localhost | mysql.sys |
| localhost | root |
+-----------+------------------+
4 rows in set (0.00 sec)

mysql> create user 'root'@'%' identified by '';
Query OK, 0 rows affected (0.01 sec)

mysql> grant all privileges to 'root'@'%';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'to 'root'@'%'' at line 1
mysql> grant all privileges on _._ to 'root'@'%';
Query OK, 0 rows affected (0.01 sec)

mysql> flush privileges;
Query OK, 0 rows affected (0.01 sec)

mysql> exit
Bye
root@a2b9625f63ab:/# exit

### Ecto & binary IDs

https://www.annkissam.com/elixir/alembic/posts/2019/01/04/ecto-and-binary-ids.html
https://mysqlserverteam.com/mysql-8-0-uuid-support/

### Pow Assent - login with OAuth

https://github.com/pow-auth/pow_assent

### Docker

prepare project with `mix dockerize.init`

remove unused images with:
`docker rmi \$(docker images --filter "dangling=true" -q --no-trunc)`

verify Dockerfile with a linter:
`docker run --rm -i hadolint/hadolint < Dockerfile`

create database (with the container running)
`docker-compose run web mix ecto.create`

#### hub.docker.com

create a repo

```
docker tag fish:fish1 wdiechmann/fish:fish1
docker push wdiechmann/fish:fish1
```

#### Kubernetes

https://medium.com/backbase/kubernetes-in-local-the-easy-way-f8ef2b98be68

### GDPR, EULA, etc

https://www.privacypolicies.com/blog/gdpr-compliance-saas/

### Elixir knowledge

https://thepugautomatic.com/

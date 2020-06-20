# Fish

Once you've cloned this repo you'll have a basic Phoenix app with rudimentary
user registration/signin/-out

To start your Phoenix server:

- Setup the project with `mix setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

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

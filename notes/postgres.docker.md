---
id: bddjplm2ttahwwd1on84pos
title: Docker
desc: ''
updated: 1676630051956
created: 1676549111600
---

Setup guide: https://github.com/bitnami/containers/tree/main/bitnami/postgresql#how-to-use-this-image

```bash
{
    mkdir -p /var/data/postgresql
    sudo chown root:docker /var/data/postgresql/
    sudo chmod g+w /var/data/postgresql/
    sudo chmod o+w /var/data/postgresql/
}
```

```bash
docker stop postgresql && docker rm postgresql
docker network create postgresql --driver bridge
docker run -v /var/data/postgresql/:/bitnami/postgresql \
     --name postgresql \
     --env ALLOW_EMPTY_PASSWORD=yes \
     -p 5432:5432 -d  \
     --network postgresql \
     bitnami/postgresql:latest

# pg client 
docker run -it --rm \
    --network postgresql \
    bitnami/postgresql:latest psql -h postgresql -U postgres

# or pgcli 

sudo apt install pgcli
pgcli -h localhost -U postgres

```

# Sample database (rental)

```bash
# import rental db
# https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/

pgcli -h localhost -U postgres
postgres=# CREATE DATABASE dvdrental;

wget https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip
sudo apt install postgresql-client-common postgresql-client-14 -y
pg_restore -U postgres -h localhost -d dvdrental ./dvdrental.tar
```
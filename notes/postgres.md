---
id: p80m23ea3tceg4js2734k84
title: Postgres
desc: ''
updated: 1696179013708
created: 1676451216830
---

# get large field
```sql
\copy (select properties from orders where name='abc' AND CAST(properties as text) LIKE '%XYZ%' limit 1) to stdout
```

# Update array
```sql
UPDATE "users" SET props = ARRAY['user'] WHERE email = 't@abc.com'; 
```

# Dates

```sql
update orders set expired_at = expired_at + INTERVAL '14 day' where id = 1;
```

# Row count estimates
```sql
SELECT reltuples :: bigint AS estimate FROM pg_class WHERE relname = 'events';
#or 
select relpages, reltuples from pg_class where relname='tbl'; # includes number of pages

```

# Connectivity and psql
```bash
# psql postgresql://user@127.0.0.1:5432/db
# sudo apt install postgresql-client
# sudo apt install pgcli

# list tabels / constraints

# =# \d+ instances
#OR
# 
# SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';


```
## Copy to file
```sql
# \copy (SELECT id from orders) TO '/root/sources.csv' With CSV DELIMITER ',' HEADER;
```

## pgcli

```bash
apt update && apt install -y postgresql-client pgcli

pgcli -h localhost -U user db -p 49157
```

# sequence troubleshooting

```sql
SELECT MAX("id")FROM orders;
SELECT nextval('db."id_seq"');
SELECT setval('db.id_seq', 948);
--SELECT nextval('id_seq'::regclass)
SELECT last_value from "db".id_seq;
```
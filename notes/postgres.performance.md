---
id: 7hzbpgtawvnvjfqk7c8bom2
title: Performance
desc: ''
updated: 1696178964106
created: 1662635557650
---

##  PostgresSQL Azure Managed Service

1. Go to https://portal.azure.com/#home
2. Navigate to Azure Database for PostgreSQL -> production -> Query Performance Insight, you can get ids of the top long running queries. To see the actual query, go to the production database and connect the system database `azure_sys` (`\c azure_sys`). You can see the query behind an id with

```
select * from query_store.qs_view where query_id = <id>;
```

More info at https://docs.microsoft.com/en-us/azure/postgresql/concepts-query-store#access-query-store-information

## PostgresSQL Query Plan

### Simple query plan review
* Review plan proposed by optimizer
```
EXPLAIN SELECT * FROM orders WHERE orders.id = 4;
```
* Run query and review actual plan and statistics
```
EXPLAIN ANALYZE SELECT * FROM orders WHERE orders.id = 4;

```

### Full-featured query plan troubleshooting

This website provides visualization for json representation of query plan. https://explain.dalibo.com/

Theory: https://www.interdb.jp/pg/pgsql03.html
- cost of random and sequential reads (HDD vs SSD) https://amplitude.engineering/how-a-single-postgresql-config-change-improved-slow-query-performance-by-50x-85593b8991b0

* Connect to Production database through pod.
* in psql repl set output to file 
```
\o plan.js
```
* Run query with EXPLAIN options
```
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) SELECT * FROM orders WHERE orders.id = 4;
```
* in psql repl restore stdout
```
\o
```
* Plan will be saved locally in container filesystem, so to copy file to local filesystem run
```
kubectl cp namespace/pod-name:plan.json ./plan.json
```
* Upload plan.json and query to https://explain.dalibo.com/ and review the details.

### Statistics
* Review if statistics are up to date
```
SELECT schemaname, relname, last_analyze, last_autoanalyze
  FROM pg_stat_user_tables
```
To list the databases:

```
# in the terminal:
$> psql -l
```

```
# in psql CLI
jarodmeng=# \l
```

To switch to a database:

```
# in psql CLI
jarodmeng=# \c postgres
```

To list tables within a database:

```
# in psql CLI
jarodmeng=# \dt
```

To show current schema:

```
# in psql CLI
jarodmeng=# SELECT CURRENT_SCHEMA();
```

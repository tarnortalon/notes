To list the databases:

```
# in the terminal:
$> psql -l
```

```
# in psql CLI
jarodm=# \l
```

To switch to a database:

```
# in psql CLI
jarodm=# \c postgres
```

To list tables within a database:

```
# in psql CLI
jarodm=# \dt
```

To show current schema:

```
# in psql CLI
jarodm=# SELECT CURRENT_SCHEMA();
```

Presto works with various datawarehouses. To enable Presto for a particular
datawarehouse, we need to create a [connector](https://prestodb.io/docs/current/connector.html).

## PostgreSQL connector

[documentation](https://prestodb.io/docs/current/connector/postgresql.html)

To configure the connector, we need to create a catalog properties file in
`etc/catalog` named `postgresql.properties`.

The `etc/catalog` folder can be accessed via
`$(brew --prefix)/opt/prestodb/libexec/etc/catalog`. On my machine, it evaluates
to the following folder.

```
/usr/local/opt/prestodb/libexec/etc/catalog
```

The content of the `postgresql.properties` file is the following.

```
connector.name=postgresql
connection-url=jdbc:postgresql://127.0.0.1:5432/<my database>
connection-user=<my username>
connection-password=<my password>
```

After this is done, we can access the database in Presto.

```
presto --catalog postgresql --schema public
```

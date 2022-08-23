# PostgreSQL on mac

## Install

```
brew install postgresql
```

## Setup

To initialize the physical space to allocate databases, we need to run the following. Note that Homebrew automatically runs this when installing `postgresql`.

```
initdb /usr/local/var/postgres
```

What Homebrew automatically runs:

```
initdb --locale=C -E UTF-8 /usr/local/var/postgres
```

The default file has a default database called `postgres`. It's meant to be the default database for any third-party tools that you are using in combination with PostgreSQL.

## Running

To start the server:

```
brew services restart postgresql
```

Or start the server in the foreground:

```
pg_ctl -D /usr/local/var/postgres start
```

And to stop the server:

```
pg_ctl -D /usr/local/var/postgres stop
```

## Databases

Once the server is up and running, we can create a database.

```
createdb mydatabasename
```

## Server

To check the port:

```
# in psql CLI
jarodmeng=# SHOW port;
```

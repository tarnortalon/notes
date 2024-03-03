# PostgreSQL on mac

## Install

```
brew install postgresql
```

## Setup

To initialize the physical space to allocate databases, we need to run the following. Note that Homebrew automatically runs this when installing `postgresql`.

```
initdb --locale=C -E UTF-8 /usr/local/var/postgresql@14
```

The default file has a default database called `postgres`. It's meant to be the default database for any third-party tools that you are using in combination with PostgreSQL.

## Running

To start the server:

```
brew services start postgresql@14
```

## User

To check the list of users:

```
# run `psql` into CLI first
jarodm=# \du
```

## Databases

Once the server is up and running, we can create a database before we can run
`psql`.

```
createdb jarodm
```

## Server

To check the port:

```
# in psql CLI
jarodmeng=# SHOW port;
```

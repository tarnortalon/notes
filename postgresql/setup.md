# PostgreSQL

## Install

Get the latest installation command from [Ubuntu
download](http://www.postgresql.org/download/linux/ubuntu/).

I installed postgreSQL 9.4 using`apt-get install postgresql-9.4`.

## Post-installation setup

1. Add PostgreSQL's `bin` path to the system `PATH` environment.

   For my installation, PostgreSQL is installed in `/usr/lib/postgresql/9.4`, so
I added the following lines to `/etc/profile`.

     > PATH=/usr/lib/postgresql/9.4/bin:$PATH  
     > export PATH

2. Create a folder to house the database cluster.

   It [is
recommended](http://www.postgresql.org/docs/9.4/interactive/creating-cluster.htm
l) in the documentation to use `/usr/local/pgsql/data`. I also give owner rights
to the `postgres` user account automatically created during the installation.

     > mkdir /usr/local/pgsql/data  
     > chown postgres /usr/local/pgsql/data

3. Initiate a database cluster

   Since by default only the `postgres` user account have superuser access, I
need to switch to `postgres` for the initialization.

   > sudo su - postgres

   I use the command `initdb` to initialize a database cluster.

   > initdb -D /usr/local/pgsql/data

4. Start the database server (in the background)

   Before anyone can access the database, I need to [start the
server](http://www.postgresql.org/docs/9.4/interactive/server-start.html). The
database server program is simply `postgres`.

   > postgres -D /usr/local/pgsql/data >logfile 2>&1 &

5. Add myself as a super user

   It's not very convenient if I have to switch to `postgres` user
account every time I need to use PostgreSQL. So I would like to add
myself as a super user. User management of PostgreSQL is documented
[here](http://www.postgresql.org/docs/9.4/static/user-manag.html).

   > createuser --superuser jarodmeng

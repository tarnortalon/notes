[Presto](https://prestodb.io) is a distributed SQL query engine.

## Install on Mac

I use `homebrew` to install Presto on my mac (see [article](https://medium.com/macoclock/installing-prestodb-on-mac-within-3-mins-84720d9b5b45)). The formulae can be found [here
](https://formulae.brew.sh/formula/prestodb)

```shell
brew install prestodb
```

Note that `prestodb` is not to be confused with `prestosql` which is a different program ([brew formulae](https://formulae.brew.sh/formula/prestosql), [homepage](https://trino.io/)). `prestosql` can also be installed using `homebrew`.

```shell
brew install prestosql
```

These two programs conflict with each other, so we can only use one of them at a time.

### Installation outputs

The main folder can be accessed via `$(brew --prefix)/opt/prestodb`. On my machine, it evaluates to the following folder.

```
/usr/local/opt/prestodb
```

This is actually a link to another folder.

```shell
~ % ls -l /usr/local/opt/prestodb
lrwxr-xr-x  1 jarodm  admin  26 Feb 24 20:40 /usr/local/opt/prestodb -> ../Cellar/prestodb/0.285.1
```

So the actual folder is

```
/usr/local/Cellar/prestodb/0.285.1
```

We can list all the files in the folder.

```shell
~ % ls -l /usr/local/Cellar/prestodb/0.285.1
total 416
-rw-r--r--  1 jarodm  admin    6174 Feb 24 20:40 INSTALL_RECEIPT.json
-rw-r--r--  1 jarodm  admin  191539 Dec 30 12:33 NOTICE
-rw-r--r--  1 jarodm  admin     126 Dec 30 12:33 README.txt
drwxr-xr-x  4 jarodm  admin     128 Feb 24 20:40 bin
-rw-r--r--  1 jarodm  admin     684 Feb 24 20:40 homebrew.mxcl.prestodb.plist
-rw-r--r--  1 jarodm  admin     218 Feb 24 20:40 homebrew.prestodb.service
drwxr-xr-x  7 jarodm  admin     224 Dec 30 12:33 libexec
```

The `bin` folder has two executable scripts.

```shell
~ % ls -l /usr/local/Cellar/prestodb/0.285.1/bin
total 16
-r-xr-xr-x  1 jarodm  admin  224 Feb 24 20:40 presto
-r-xr-xr-x  1 jarodm  admin  195 Feb 24 20:40 presto-server
```

`presto` invokes the Presto command line.

```shell
~ % cat /usr/local/Cellar/prestodb/0.285.1/bin/presto
#!/bin/bash
export JAVA_HOME="${JAVA_HOME:-/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home}"
exec "${JAVA_HOME}/bin/java"  -jar "/usr/local/Cellar/prestodb/0.285.1/libexec/presto-cli-0.285.1-executable.jar" "$@"
```

It basically calls a `jar` executable which is the command line tool for Presto.

`presto-server` starts the Presto server.

```shell
~ % cat /usr/local/Cellar/prestodb/0.285.1/bin/presto-server
#!/bin/bash
JAVA_HOME="${JAVA_HOME:-/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home}" PATH="$JAVA_HOME/bin:$PATH" exec "/usr/local/Cellar/prestodb/0.285.1/libexec/bin/launcher"  "$@"
```

This script calls the `launcher` command to start the server.

### The `JAVA_HOME` environment variable

I define `JAVA_HOME` in my `.zshenv` file using the `java_home` command (see [article](https://mkyong.com/java/how-to-set-java_home-environment-variable-on-mac-os-x/a)).

```shell
~ % cat ~/.zshenv
export JAVA_HOME=$(/usr/libexec/java_home)
```

The variable evaluates to the following folder.

```shell
~ % echo $JAVA_HOME
/Library/Java/JavaVirtualMachines/jdk-15.0.1.jdk/Contents/Home
```

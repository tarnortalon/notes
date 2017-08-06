# How to sync a forked repo with upstream repo on Github

1. Change the current directory to the local project. If there's no local
project, clone the forked repo to a local directory first.

```
git clone https://github.com/jarodmeng/<repo name>.git
```

2. (optional) Set up upstream repo for the local project of the forked repo.

```
git remote add upstream https://github.com/<original repo owner>/<repo name>.git
```

3. Fetch the branches and their commits from the upstread repository.

```
git fetch upstream
```

Commits to the original repo's `master` branch are now stored in a local branch,
`upstream/master`.

4. Merge the changes from `upstream/master` into local `master` branch. You may
need to resolve any potential conflicts.

## Reference

* [Syncing a fork](https://help.github.com/articles/syncing-a-fork/)

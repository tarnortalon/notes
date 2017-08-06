# How to start a new github repo

1. [Create a new repo](https://github.com/new) on github.com.
2. Create a new folder to house the local repo.
```
mkdir <repo name>
```
3. Initialize the local repo.
```
git init
```
4. Add the github repo as remote for the local repo.
```
git remote add origin https://github.com/jarodmeng/<repo name>.git
```
5. Add files to the local repo and commit.
6. Push commits to the remote repo.
```
git push -u origin master
```

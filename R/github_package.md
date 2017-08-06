# How to contribute to an R package development on Github

1. Fork the package project (with the right branch, usually `master`) on Github.
2. Clone the forked repo into a local directory.

```
git clone https://github.com/jarodmeng/<repo name>.git
```

3. Configure a remote that points to the upstream repo.

```
git remote add upstream https://github.com/<original repo owner>/<repo name>.git
```

4. Create a feature or bug fix branch in the local directory.

```
git checkout -b <feature or bug fix branch name>
```

5. Make changes and commit.
6. Push local commits to the remote origin branch.

```
git push origin <feature or bug fix branch name>
```

7. Create a pull request.

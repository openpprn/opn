# Merging Upstream Changes

Changes are pulled from the master branch of https://github.com/openpprn/opn

## Check that upstream exists

```
git remote -v
```

If you only get

```console
origin  git@github.com:myapnea/www.myapnea.org.git (fetch)
origin  git@github.com:myapnea/www.myapnea.org.git (push)
```

Then you need to add the upstream branch

```
git remote add upstream https://github.com/openpprn/opn.git
```

You should now get

```
$ git remote -v

origin  git@github.com:myapnea/www.myapnea.org.git (fetch)
origin  git@github.com:myapnea/www.myapnea.org.git (push)
upstream  https://github.com/openpprn/opn.git (fetch)
upstream  https://github.com/openpprn/opn.git (push)
```


## Pulling Changes from Upstream

```
git fetch upstream

git checkout master

git merge upstream/master
```

Make sure to resolve any conflicts and rebase the master

```
git fetch upstream
```

Merge the new content:

```
git checkout master
git rebase upstream/master
```

Update your fork:
```
git push origin master
```

#!/bin/bash

# Refer https://ben.lobaugh.net/blog/202412/replace-one-git-branch-with-the-contents-of-another
# Refer https://stackoverflow.com/questions/30105210/git-overwrite-master-with-branch/41490301

OLD_BRANCH=$1
NEW_BRANCH=$2

git checkout $NEW_BRANCH
git merge -s ours --no-commit $OLD_BRANCH
git commit -m "Merging $OLD_BRANCH into $NEW_BRANCH"
git checkout $OLD_BRANCH
git merge $NEW_BRANCH
echo "Now run: git push origin $OLD_BRANCH"

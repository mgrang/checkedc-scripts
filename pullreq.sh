COMMIT_ID=`git rev-parse HEAD`
BRANCH=upstream

git remote show $BRANCH > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
  git remote add $UPSTREAM
fi

git remote update

git rev-parse --verify $BRANCH >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
  git checkout -b upstream upstream/master
else
  git checkout $BRANCH
fi

git cherry-pick $COMMIT_ID
git push origin $BRANCH

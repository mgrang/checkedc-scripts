# For new git forks, add upstream to remote, eg:
# git remote add upstream https://github.com/microsoft/checkedc-llvm-test-suite.git

COMMIT_ID=`git rev-parse HEAD`
BRANCH=upstream

git remote show $BRANCH > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
  error "First create an upstream fork"
  exit 1
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

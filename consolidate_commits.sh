#!/bin/bash

# Ensure a branch name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <branch-name> <new-commit-message>"
  exit 1
fi

# Ensure a new commit message is provided
if [ -z "$2" ]; then
  echo "Usage: $0 <branch-name> <new-commit-message>"
  exit 1
fi

BRANCH_NAME=$1
NEW_COMMIT_MESSAGE=$2

# Check out the branch
git checkout $BRANCH_NAME || exit 1

# Start an interactive rebase from the root commit and squash all commits
# The following command creates an auto-generated rebase instruction file,
# changes 'pick' to 'squash' for all but the first commit, then runs the rebase
git rebase -i --root <<EOF
$(sed '2,$ s/^pick /squash /' <(git log --reverse --oneline))
EOF

# Edit the commit message to use the new message
git commit --amend -m "$NEW_COMMIT_MESSAGE"

echo "All commits on branch '$BRANCH_NAME' have been consolidated into one commit with the new message: $NEW_COMMIT_MESSAGE"


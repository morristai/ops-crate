#!/bin/bash

# Get a list of all your forked repositories with their default branches
repos=$(gh repo list --fork --json nameWithOwner,defaultBranchRef -q '.[] | "\(.nameWithOwner) \(.defaultBranchRef.name)"')

# Loop through each repository and its default branch
while read -r repo default_branch; do
    echo "Synchronizing $repo with its upstream using default branch $default_branch"

    # Use the GitHub CLI to sync the fork with the upstream branch
    gh repo sync "$repo" -b "$default_branch" --force

    echo "Synchronization of $repo completed."
done <<< "$repos"

echo "All forks have been synchronized."


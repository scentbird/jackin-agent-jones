# Run `git pull` in every immediate subdirectory that is a git repo, in parallel.
# Non-repo dirs are reported with a yellow warning instead of being silently skipped.
git_pull_all() {
  for dir in $(ls -d */); do
    (
      cd "$dir" || exit
      if [[ -d .git ]]; then
        echo "\e[1;37mUpdating $dir\e[0m"
        git pull
      else
        echo "\e[1;33mSkipping $dir (not a git repo)\e[0m"
      fi
    ) &
  done
  wait
}

# Run `git push` in every immediate subdirectory that is a git repo, in parallel.
git_push_all() {
  for dir in $(ls -d */); do
    (
      cd "$dir" || exit
      if [[ -d .git ]]; then
        echo "\e[1;37mPushing $dir\e[0m"
        git push
      else
        echo "\e[1;33mSkipping $dir (not a git repo)\e[0m"
      fi
    ) &
  done
  wait
}

# Push to both `origin` and `gitlab` remotes in every git subdir, in parallel.
# Repos without a `gitlab` remote are pushed to origin only (with a yellow warning).
git_push_origin_gitlab_all() {
  for dir in $(ls -d */); do
    (
      cd "$dir" || exit
      if [[ -d .git ]]; then
        echo "\e[1;37mPushing $dir\e[0m"
        if git remote get-url gitlab &>/dev/null; then
          git push origin && git push gitlab
        else
          echo "\e[1;33m  $dir has no 'gitlab' remote, pushing to origin only\e[0m"
          git push origin
        fi
      else
        echo "\e[1;33mSkipping $dir (not a git repo)\e[0m"
      fi
    ) &
  done
  wait
}

# Run `git status` in every immediate subdirectory that is a git repo.
# Serial on purpose — parallel `git status` output would interleave unreadably.
git_status_all() {
  for dir in $(ls -d */); do
    (
      cd "$dir" || exit
      if [[ -d .git ]]; then
        echo "\e[1;37mStatus $dir\e[0m"
        git status
      else
        echo "\e[1;33mSkipping $dir (not a git repo)\e[0m"
      fi
    )
  done
}

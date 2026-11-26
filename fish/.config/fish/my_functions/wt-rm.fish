function wt-rm --description 'Remove a worktree of the current repo and its branch'
    set -l branch $argv[1]
    if test -z "$branch"
        echo "usage: wt-rm <branch>  (run inside the repo)"; return 1
    end
    set -l git_common_dir (git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    or begin; echo "not in a git repo"; return 1; end
    set -l repo_dir (path dirname $git_common_dir)
    set -l worktree_dir $repo_dir-(string lower -- (string replace -a / - -- $branch))
    string match -q -- "$worktree_dir*" $PWD; and cd $repo_dir
    git -C $repo_dir worktree remove $worktree_dir; or return
    git -C $repo_dir branch -d $branch
end

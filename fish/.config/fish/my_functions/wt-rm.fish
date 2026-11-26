function wt-rm --description 'Remove a worktree of the current repo and its branch'
    set -l branch $argv[1]
    if test -z "$branch"
        echo "usage: wt-rm <branch>  (run inside the repo)"; return 1
    end
    set -l common (git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    or begin; echo "not in a git repo"; return 1; end
    set -l main (path dirname $common)
    set -l dir $main-(string lower -- (string replace -a / - -- $branch))
    string match -q -- "$dir*" $PWD; and cd $main
    git -C $main worktree remove $dir; or return
    git -C $main branch -d $branch
end

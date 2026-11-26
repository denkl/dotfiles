function wt --description 'Create or open a worktree for a branch of the current repo'
    set -l branch $argv[1]
    if test -z "$branch"
        echo "usage: wt <branch>  (run inside the repo)"; return 1
    end
    set -l common (git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    or begin; echo "not in a git repo"; return 1; end
    set -l main (path dirname $common)
    set -l dir $main-(string lower -- (string replace -a / - -- $branch))
    if not test -d $dir
        git -C $main fetch origin; or return
        if git -C $main show-ref --verify --quiet refs/heads/$branch
            git -C $main worktree add $dir $branch
        else if git -C $main show-ref --verify --quiet refs/remotes/origin/$branch
            git -C $main worktree add --track -b $branch $dir origin/$branch
        else
            set -l base (git -C $main symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null)
            for b in origin/main origin/master
                test -n "$base"; and break
                git -C $main show-ref --verify --quiet refs/remotes/$b; and set base $b
            end
            git -C $main worktree add --no-track -b $branch $dir $base
        end; or return
    end
    cd $dir
end

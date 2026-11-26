function wt --description 'Create or open a worktree for a branch of the current repo'
    set -l branch $argv[1]
    if test -z "$branch"
        echo "usage: wt <branch>  (run inside the repo)"; return 1
    end
    set -l git_common_dir (git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    or begin; echo "not in a git repo"; return 1; end
    set -l repo_dir (path dirname $git_common_dir)
    set -l worktree_dir $repo_dir-(string lower -- (string replace -a / - -- $branch))
    if not test -d $worktree_dir
        git -C $repo_dir fetch origin; or return
        if git -C $repo_dir show-ref --verify --quiet refs/heads/$branch
            git -C $repo_dir worktree add $worktree_dir $branch
        else if git -C $repo_dir show-ref --verify --quiet refs/remotes/origin/$branch
            git -C $repo_dir worktree add --track -b $branch $worktree_dir origin/$branch
        else
            set -l default_branch (git -C $repo_dir symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null)
            or begin; echo "origin/HEAD is not set: git remote set-head origin --auto"; return 1; end
            git -C $repo_dir worktree add --no-track -b $branch $worktree_dir $default_branch
        end; or return
    end
    cd $worktree_dir
end

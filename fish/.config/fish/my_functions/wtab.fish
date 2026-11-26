function wtab --description 'Open a kitty tab for a worktree'
    set -l title (string split -- - $argv[1])[-1]
    kitty @ focus-tab --match "title:^$title\$" 2>/dev/null; and return
    set -l prev $PWD
    wt $argv[1]; or return
    set -l worktree_dir $PWD
    cd $prev
    set -l win (kitty @ launch --type=tab --tab-title $title --cwd $worktree_dir fish -C nvim)
    kitty @ launch --match window_id:$win --cwd $worktree_dir fish -C 'claude --continue; or claude'
    kitty @ launch --match window_id:$win --cwd $worktree_dir
    kitty @ focus-window --match id:$win
end

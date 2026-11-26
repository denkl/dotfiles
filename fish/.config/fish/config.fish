if status is-interactive

    set --global --prepend fish_function_path ~/.config/fish/my_functions

    fish_add_path /opt/homebrew/bin

    set --global fish_greeting
    set --global --export EDITOR nvim
    set --global --export MANPAGER "nvim +Man!"
    set --global --export LC_ALL en_US.UTF-8
    set --export GPG_TTY (tty)

    set --global tide_right_prompt_items status cmd_duration context jobs direnv python go terraform

    set --global --export RIPGREP_CONFIG_PATH $HOME/.ripgreprc

    set --global --export DOCKER_HOST "unix://$HOME/.colima/default/docker.sock"

    fish_add_path $HOME/.cargo/env

    bind '$' __history_previous_command_arguments
    bind 0 __history_previous_command_name

    abbr -a gss --position anywhere --function _gss
    abbr -a gsm --position anywhere --function _gsm
    abbr -a gsu --position anywhere --function _gsu

    abbr --add e nvim

    abbr --add pref pre-commit run --files
    abbr --add pyq pytest --show-capture=no

    abbr --command git s status
    abbr --command git nb checkout -b
    abbr --command git dc diff --cached
    abbr --command git rs restore --staged
    abbr --command git uncommit reset --soft HEAD^
    abbr --command git c --set-cursor commit -m '"%"'
    abbr --command git C --set-cursor commit -m '"$(git branch --show-current) %"'
    abbr --command git p push origin '$(git branch --show-current)'
    abbr --command git l log --oneline --all --graph --reflog

    abbr -a chs "nvim -c 'lua vim.defer_fn(function() vim.cmd(\"Pick buf_lines\") end, 100)' ~/workspace/github/chsh/README.md"

end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/denkl/.google-cloud-sdk/path.fish.inc' ]; . '/Users/denkl/.google-cloud-sdk/path.fish.inc'; end

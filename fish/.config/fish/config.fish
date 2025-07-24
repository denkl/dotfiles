if status is-interactive

    fish_add_path /opt/homebrew/bin

    set --global fish_greeting
    set --global --export EDITOR nvim
    set --global --export LC_ALL en_US.UTF-8
    set --export GPG_TTY (tty)

    set --global tide_right_prompt_items status cmd_duration context jobs direnv python go terraform

    pyenv init --path | source
    pyenv init - | source
    pyenv virtualenv-init - | source
    set --global --export PYENV_VIRTUALENV_DISABLE_PROMPT 1

    fish_add_path $HOME/.cargo/env

    function __history_previous_command
        switch (commandline -t)
            case "!"
                commandline -t $history[1]; commandline -f repaint
            case "*"
                commandline -i !
        end
    end

    function __history_previous_command_arguments
        switch (commandline -t)
            case "!"
                commandline -t ""
                commandline -f history-token-search-backward
            case "*"
                commandline -i '$'
        end
    end

    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments

    bind W nextd-or-forward-word

    abbr --add e nvim

    abbr --add pref pre-commit run --files

    abbr --command git s status
    abbr --command git nb checkout -b
    abbr --command git dc diff --cached
    abbr --command git rs restore --staged
    abbr --command git uncommit reset --soft HEAD^
    abbr --command git c --set-cursor commit -m '"%"'
    abbr --command git C --set-cursor commit -m '"$(git branch --show-current) %"'
    abbr --command git p push origin '$(git branch --show-current)'
    abbr --command git l log --oneline --all --graph --reflog

end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/denkl/.google-cloud-sdk/path.fish.inc' ]; . '/Users/denkl/.google-cloud-sdk/path.fish.inc'; end

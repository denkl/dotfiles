if status is-interactive

    set --global fish_greeting
    set --global --export EDITOR nvim
    set --export GPG_TTY (tty)

    starship init fish | source

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

    fzf_key_bindings

    bind W nextd-or-forward-word

    abbr --add --global e nvim

end

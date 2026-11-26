function __history_previous_command_name
    switch (commandline -t)
        case "!"
            commandline -t (string split -f1 ' ' -- $history[1]); commandline -f repaint
        case "*"
            commandline -i 0
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here

    source "$HOME/.cargo/env.fish"

    starship init fish | source

    zoxide init fish | source
    alias cd="z"

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # some useful aliases
    alias :q="exit"
    alias lgit="lazygit"
end

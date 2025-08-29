oh-my-posh init fish --config ~/.poshthemes/test1.json | source

set -U fish_greeting ""
if status is-interactive
    # Commands to run in interactive sessions can go here
end

if type -q fastfetch
    fastfetch
end

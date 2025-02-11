if status is-interactive
   set -x EDITOR emacs
   set -x VISUAL emacs
   # starship init fish | source
end

alias ls='echo "==========================================" && pwd && echo "==========================================" && echo "" && eza --color=always --icons=always -1 -a'

alias fetch='clear && echo "Hello, $USER!" && fastfetch'

bind \cF fzf
bind \b backward-kill-word

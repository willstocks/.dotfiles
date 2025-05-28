#
# ~/.bashrc
#

eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash --cmd cd)"

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nano
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

nerdfetch

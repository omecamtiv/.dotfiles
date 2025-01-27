# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/data/data/com.termux/files/home/.zshrc'

# Set Git Completion
zstyle ':completion:*:*:git:*' script $HOME/.git-completion.bash
fpath+=$HOME/.zsh/site-functions

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Typewritten Prompt
fpath+=$HOME/.zsh/typewritten
export TYPEWRITTEN_PROMPT_LAYOUT="singleline_verbose"
autoload -Uz promptinit
promptinit
prompt typewritten

# Aliases
alias l='lsd -F'
alias la='lsd -A'
alias ll='lsd -alF'
alias lt='lsd --tree'
alias lg='lazygit'

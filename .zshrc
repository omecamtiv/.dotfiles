# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/omecamtiv/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Set Git Completion
fpath+=$HOME/.zsh/site-functions

# Typewritten Prompt
fpath+=$HOME/.zsh/typewritten
export TYPEWRITTEN_PROMPT_LAYOUT="singleline_verbose"
autoload -Uz promptinit
promptinit
prompt typewritten

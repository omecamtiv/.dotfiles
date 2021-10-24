setopt PROMPT_SUBST
export TERM=xterm-24bits

# Set Git Completion
zstyle ':completion:*:*:git:*' script $HOME/.git-completion.bash
fpath=($HOME/.zsh/site-functions $fpath)
autoload -U compinit
compinit -i

# # Set virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/WorkSpace/Python
# source /data/data/com.termux/files/usr/bin/virtualenvwrapper.sh

# Aliases
alias str='tree --dirsfirst -a -C -I ".git|.cache|build"'
alias ec='emacsclient -t -s ~/.emacs.d/server'

# Banner
clear
echo -e '\n'
figlet -d ~/.figlet-font -f 3-d -c 'TERMUX'|toilet -f term --gay
echo -e '\n'

# Typewritten Prompt
fpath+=$HOME/.zsh/typewritten
autoload -Uz promptinit
promptinit
prompt typewritten

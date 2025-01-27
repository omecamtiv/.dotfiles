# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/omecamtiv/.zshrc'

# End of lines added by compinstall

# Set Git Completion
zstyle ':completion:*:*:git:*' script $HOME/.git-completion.bash
fpath+=$HOME/.zsh/site-functions

autoload -Uz compinit
compinit

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
alias ld='lazydocker'
alias sudo='sudo -E'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$PATH:/opt/nvim-linux64/bin"

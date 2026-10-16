export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys"
plugins=(
    git
    # zsh-autosuggestions
    # zsh-syntax-highlighting
    # fast-syntax-highlighting
    # zsh-autocomplete
)
source $ZSH/oh-my-zsh.sh

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
# i do not want to share history between tmux sessions sometimes
# setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

/usr/bin/keychain --nogui ~/.ssh/id_ed25519
source $HOME/.keychain/$HOST-sh

bindkey -s ^f "tmux-sessionizer\n"
alias ta="tmux attach"

# etc
eval "$(direnv hook zsh)"

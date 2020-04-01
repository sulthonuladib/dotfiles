export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias cppcom="g++ -std=c++17 -stdlib=libc++ ./**.cpp -o ../bin/Main.out; cd ../bin/ ./Main.out; cd ../src/"
alias ccom="clang ./**.c -o ../bin/app && ../bin/app"
alias my="mysql -u root -pBedokkok11,."
alias bstart="brew services start"
alias bstop="brew services stop"
alias python=python3
alias pip=pip3
rmd () {
  pandoc $1 | lynx -stdin
}

export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/sbin:$PATH"
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

TERM=xterm-256color

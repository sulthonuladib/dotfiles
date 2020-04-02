# zsh shell configuration
# created by Sulthonul Adib
# github link: github.com/sulthonuladib

# export rbenv for manage ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Some shit alias
alias cppcom="g++ -std=c++17 -stdlib=libc++ ./**.cpp -o ../bin/Main.out; cd ../bin/ ./Main.out; cd ../src/"
alias ccom="clang ./**.c -o ../bin/app && ../bin/app"
alias my="mysql -u root -pBedokkok11,."
alias bstart="brew services start"
alias bstop="brew services top"
alias python=python3
alias pip=pip3

# rmd to see markdown files
# install it first on homebrew
# then execute rmd <filename>
rmd () {
  pandoc $1 | lynx -stdin
}

# Fix shitty brew
export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/sbin:$PATH"

# Python virtual env
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# Android sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

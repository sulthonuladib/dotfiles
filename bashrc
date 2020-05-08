# load rbenv
eval "$(rbenv init -)"

# Some shit alias
alias cppcom="g++ -std=c++17 -stdlib=libc++ ./**.cpp -o ../bin/Main.out; cd ../bin/ ./Main.out; cd ../src/"
alias ccom="clang ./**.c -o ../bin/app && ../bin/app"
alias my="mysql -u root -pBedokkok11,."
alias bstart="brew services start"
alias bstop="brew services top"
alias python=python3
alias pip=pip3
alias gfxutil="~/hackintosh/utils/gfxutil"
alias iasl="~/hackintosh/utils/iasl"

# rmd to see markdown files
# install lynx and pandoc first with homebrew
# then execute rmd <filename>
rmd () {
  pandoc $1 | lynx -stdin
}

# Fix shitty brew
export EDITOR='vim'
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/sbin:$PATH"

# android sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# GO PATH
export GOPATH=$HOME/programming/go
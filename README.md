# Cool macOS Configuration
a very bad documentation & very-very bad english
back to bash ! fucking slow zsh on Catalina
## 0. Initialization
- Clone or download it first !!
- ```
  git clone https://github.com/sulthonuladib/mac_dotfiles
  ```
- Then enter its directory
- ```
  cd mac_dotfiles
  ```

## 1. Restore installed brew
  - ``` 
    brew bundle 
    ```

## 2. Restore tmux configuration
  - Copy to default tmux configuration directory
  - ``` 
    cp ./tmux.conf ~/.tmux.conf
    ```

## 3. Restore Vim configuration
- Install vim plug first
  - ```sh
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
- Copy and install all configured dependency
  - Copy to default Vim configuration directory
  - ```
    cp ./vimrc ~/.vimrc
    ```
  - Enter Vim and execute
  - ```
    :PlugInstall
    ```

## Restore zsh configuration
- If u still wanna use bash or already install it just skip this
- or if u wanna use my zsh config install it first
  - ```
    brew install zsh
    ```
- Then use it as your default shell
- Copy my zsh configuration to your home
  - ```
    cp ./zshrc ~/.zshrc
    ```
  - ```
    source ~/.zshrc
    ```

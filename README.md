Installation
============

```sh
git clone this_repo_url  /path/to/vim/portable/direcotry

# For example
git clone git@github.com:oplatek/dotfiles-vim.git $HOME/.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -E -c PlugInstall -c qall    # Run it from shell. It installs Vim plugins.
```


*Pull requests are welcome!*

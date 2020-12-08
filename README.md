Installation
============

```sh
git clone this_repo_url  /path/to/vim/portable/direcotry
# For example
git clone git@github.com:oplatek/dotfiles-vim.git $HOME/.vim
vim -E -c BundleInstall -c qall    # Run it from shell. It installs Vim plugins.
cd .vim/bundle/YouCompleteMe
python3 ./install.py --clang-completer   # Tested with 4496153a3efdb0891dac24510ac1ee519f1778a6   
# Tested with YouCompleteMe with Vim 8.2 compiled with Python3.9 support
```


*Pull requests welcomed!*

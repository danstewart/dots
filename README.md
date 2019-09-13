# What to do
```
git clone git@github.com:danstewart/dots.git
cd dots
perl links.pl <machine> --force
```

---

# Other Programs

## [Neovim](https://github.com/neovim/neovim)
```
sudo dnf install neovim
sudo pip3 install neovim
```

Install [vim-plug](https://github.com/junegunn/vim-plug)
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then run `:PlugInstall`, restart then `:UpdateRemotePlugins`

---

## [Vim](https://github.com/vim/vim)
```
sudo dnf install vim
```

Install [vim-plug](https://github.com/junegunn/vim-plug)
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then run `:PlugInstall` and restart

---

## [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
```
mkdir ~/bin
curl -o ~/bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod 755 ~/bin/diff-so-fancy
```

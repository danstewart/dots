### Update
```
sudo apt -y update && sudo apt -y upgrade
```


### Via apt
```
sudo apt -y install git curl vim fzf gnupg2 jq python3-dev python3-venv python3-pip gedit nautilus net-tools
```

### Other
**[Spotify](https://www.spotify.com/us/download/linux/)**
```
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
```

**[Nextcloud](https://launchpad.net/~nextcloud-devs/+archive/ubuntu/client)**
```
sudo add-apt-repository ppa:nextcloud-devs/client
sudo apt-get update
sudo apt install nextcloud-client
```

**[diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)**
```
mkdir ~/bin
curl -o ~/bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod 755 ~/bin/diff-so-fancy
```


### Manual
- [VS Code](https://code.visualstudio.com/docs/setup/linux)
- [MS Teams](https://www.microsoft.com/en-gb/microsoft-teams/download-app)
- [Obsidian](https://obsidian.md/)
- [GitHub CLI](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
- [forgit](https://github.com/wfxr/forgit)
- [git-open](https://github.com/paulirish/git-open)

##### Docker and docker-compose
https://docs.docker.com/engine/install/ubuntu/

```shell
# Install Docker
# NOTE: Double check ubuntu release
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add to group
sudo groupadd docker
sudo usermod -aG docker $USER

# Now log out and back in
```

---

### Dots

https://github.com/danstewart/dots

---

### vim/neovim


**[Neovim](https://github.com/neovim/neovim)**
```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

sudo pip3 install neovim
```

Install [vim-plug](https://github.com/junegunn/vim-plug)
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then run `:PlugInstall`, restart then `:UpdateRemotePlugins`

---

**[Vim](https://github.com/vim/vim)**
```
sudo apt install vim
```

Install [vim-plug](https://github.com/junegunn/vim-plug)
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then run `:PlugInstall` and restart

---

### Gnome extensions
```
sudo apt-get install libproxy1-plugin-networkmanager gnome-shell-extension-system-monitor
```
- [Night Light Slider](https://extensions.gnome.org/extension/1276/night-light-slider/)


### Update
```shell
sudo dnf update
```


### Via dnf
```shell
sudo dnf -y install git curl fzf gnupg2 jq net-tools python3-devel python3-pip
```

### Via Flatpak

```shell
# Enable flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Spotify
flatpak install flathub com.spotify.Client

# Slack
flatpak install flathub com.slack.Slack

# Nextcloud
flatpak install flathub com.nextcloud.desktopclient.nextcloud

# Teams
flatpak install flathub com.microsoft.Teams

# Obsidian
flatpak install flathub com.microsoft.Teams
```

### Neovim

```shell
sudo dnf install -y neovim python3-neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then run `:PlugInstall`, restart then `:UpdateRemotePlugins`, finally run `:CocInstall coc-pyright`


### Other
**[diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)**
```shell
mkdir ~/bin
curl -o ~/bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod 755 ~/bin/diff-so-fancy
```

- [VS Code](https://code.visualstudio.com/docs/setup/linux)
- [GitHub CLI](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
- [Docker](https://docs.docker.com/engine/install/fedora/)
- [forgit](https://github.com/wfxr/forgit)
- [git-open](https://github.com/paulirish/git-open)

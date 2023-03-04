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

### Fonts

```shell
sudo ln -fs /usr/share/fontconfig/conf.avail/10-autohint.conf /etc/fonts/conf.d
sudo ln -fs /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -fs /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d

# Install better fonts: https://copr.fedorainfracloud.org/coprs/hyperreal/better_fonts/
sudo dnf copr enable hyperreal/better_fonts -y
sudo dnf install fontconfig-font-replacements -y
sudo dnf install fontconfig-enhanced-defaults -y

fc-cache --force
# And now reboot...
```


### Other

**[diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)**

```shell
mkdir ~/bin
curl -o ~/bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod 755 ~/bin/diff-so-fancy
```

**[glow](https://github.com/charmbracelet/glow)**

```shell
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo

sudo dnf install glow
```

---

- [VS Code](https://code.visualstudio.com/docs/setup/linux)
- [GitHub CLI](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
- [Docker](https://docs.docker.com/engine/install/fedora/)
- [forgit](https://github.com/wfxr/forgit)
- [git-open](https://github.com/paulirish/git-open)
- [logiops](https://github.com/PixlOne/logiops)

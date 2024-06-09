

#!/usr/bin/env bash

set -e

[[ ! -d ~/bin ]] && mkdir ~/bin

curl --silent https://raw.githubusercontent.com/wfxr/forgit/master/forgit.plugin.zsh -o ~/.forgit.bash
curl --silent https://raw.githubusercontent.com/wfxr/forgit/master/bin/git-forgit -o ~/bin/git-forgit
chmod 0755 ~/bin/git-forgit

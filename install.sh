sudo apt install git tmux zsh wget python3-venv silversearcher-ag neovim

curl -LO https://github.com/guusec/nvim-config/raw/main/nvim.tar.gz
tar xf nvim.tar.gz -C $HOME/.config/

if [ -e "$HOME/.zshrc" ]; then
  echo ".zshrc already exists"
else
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
cat <<POG >> ~/.zshrc
autoload -U +X compinit && compinit
compdef _gf gf

function _gf {
    _arguments "1: :(\$(gf -list))"
}

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# history setup
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[3~' delete-char
POG
fi

source ~/.zshrc

if [ -e "$HOME/.tmux.conf" ]; then
  echo ".tmux.conf already exists"
else
cat <<POG >> ~/.tmux.conf
set -g prefix C-a
unbind-key C-b
bind-key C-a send-prefix

set -g base-index 1
setw -g pane-base-index 1

set-option -sa terminal-overrides ',xterm-256color:RGB'
set-option -sg escape-time 10
set-option -g focus-events on

setw -g automatic-rename on
set -g renumber-windows on
POG
fi

wget https://go.dev/dl/go1.22.5.linux-arm64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.5.linux-arm64.tar.gz

sudo chsh -s $(which zsh) $USER

git clone https://github.com/danielmiessler/SecLists.git ~/SecLists

go install github.com/ffuf/ffuf/v2@latest
go install github.com/tomnomnom/gf@latest
git clone https://github.com/guusec/gf-configs.git ~/.gf/
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/BishopFox/jsluice/cmd/jsluice@latest
go install github.com/bitquark/shortscan/cmd/shortscan@latest
go install github.com/tomnomnom/assetfinder@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest
go install github.com/denandz/sourcemapper@latest
go install github.com/003random/getJS/v2@latest

wget https://cdn.mullvad.net/app/desktop/releases/2024.4/MullvadVPN-2024.4_arm64.deb
sudo dpkg -i MullvadVPN-2024.4_arm64.deb

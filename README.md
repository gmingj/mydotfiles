# Dotfiles

Development environment configuration for vim, tmux, zsh...

## Prerequisite

```shell
sudo apt update && sudo apt install -y curl git tmux zsh vim bat cloc net-tools \
    autojump silversearcher-ag global universal-ctags \
    python3-dev python3-pip python3-pygments \
    pandoc pandoc-plantuml-filter texlive texlive-fonts-recommended texlive-fonts-extra \
    build-essential cmake linux-headers-$(uname -r) libncurses-dev 
```

## Usage

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/install.sh)"
```

with proxy (optional)
```shell
PROXYDNS=<IPADDR>
export https_proxy="http://${PROXYDNS}:7890"; export http_proxy="http://${PROXYDNS}:7890"; export all_proxy="socks5://${PROXYDNS}:7890"; export ALL_PROXY="socks5://${PROXYDNS}:7890"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/install.sh)" -- $PROXYDNS
```

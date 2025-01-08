# Dotfiles

Development environment configuration for vim, tmux, zsh...

## Prerequisite

```shell
sudo apt update && sudo apt install -y curl git tmux zsh vim \
    autojump silversearcher-ag global universal-ctags xclip \
    build-essential cmake autoconf automake libtool pkg-config \
    pandoc pandoc-plantuml-filter texlive texlive-fonts-recommended texlive-fonts-extra \
    doxygen graphviz \
    python3-dev python3-pip python3-pygments \
    iproute2 iputils-ping cloc bat
```

## Usage

```shell
curl -sL https://raw.githubusercontent.com/gmingj/mydotfiles/main/install.sh | bash
```

with proxy (optional)
```shell
PROXYDNS=<IPADDR>
export https_proxy="http://${PROXYDNS}:7890"; export http_proxy="http://${PROXYDNS}:7890"; export all_proxy="socks5://${PROXYDNS}:7890"; export ALL_PROXY="socks5://${PROXYDNS}:7890"

curl -sL https://raw.githubusercontent.com/gmingj/mydotfiles/main/install.sh | bash -s -- $PROXYDNS
```

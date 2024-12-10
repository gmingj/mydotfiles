# Dotfiles

Development environment configuration for vim, tmux, zsh...

## Dependence

```shell
sudo apt update && sudo apt install -y curl git tmux zsh vim autojump bat silversearcher-ag global cmake build-essential python3-dev python3-pip universal-ctags
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

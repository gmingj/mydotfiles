#!/bin/bash

# Check if HOSTIP is provided as an argument
if [ -z "$1" ]
then
    echo "Error: HOSTIP not provided. Please provide the HOSTIP as an argument."
    exit 1
fi

HOSTIP=$1

# Set up proxy
export https_proxy="http://${HOSTIP}:7890"
export http_proxy="http://${HOSTIP}:7890"
export all_proxy="socks5://${HOSTIP}:7890"
export ALL_PROXY="socks5://${HOSTIP}:7890"

# Test proxy connectivity
if ! curl -I www.google.com | head -n 1 | grep "200 OK" >/dev/null; then
    echo "Proxy setup failed. Please check your proxy settings and try again."
    exit 1
fi

# Install tmux
git clone --depth=1 https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~
cp ~/.tmux/.tmux.conf.local ~

# Install oh-my-zsh and related plugins/themes
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git -b v0.7.0 ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git -b 0.8.0 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git -b v1.20.0 ~/.oh-my-zsh/custom/themes/powerlevel10k

# Modify zshrc by replacing lines containing ZSH_THEME and plugins
sed -i -e "/ZSH_THEME=/s/.*/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/" \
    -e "/^plugins=/s/.*/plugins=(\n    git\n    autojump\n    zsh-autosuggestions\n    zsh-syntax-highlighting\n    tmux\n)/" ~/.zshrc

# Install fzf
git clone --depth=1 https://github.com/junegunn/fzf.git -b 0.53.0 ~/.fzf
~/.fzf/install

# Setup vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

echo "Development environment deployment completed!"

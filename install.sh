#/bin/sh

set -e

# source proxyenv
# setp

# install dev utils
echo "-----> Installing dev utils..."
apt install -y net-tools inetutils-tools curl git vim build-essential cmake tldr htop bat exa zsh silversearcher-ag autojump global

# install vimrc
echo "-----> Installing vimrc..."
git clone --recursive --depth=1 https://github.com/gmingj/vimrc.git -b myvimrc ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# install ohmyzsh
gmingj/ohmyzsh
echo "-----> Installing ohmyzsh..."
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmingj/ohmyzsh/myohmyzsh/tools/install.sh)"

echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "-----> Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "-----> Installing zsh theme 'powerlevel10k'..."
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# p10k configure

# install tmux
git clone --depth=1 https://github.com/gmingj/.tmux.git -b mytmux ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/.tmux/.tmux.conf.local ~/.tmux.conf.local


#/bin/sh

set -e

# source proxyenv
# setp

# install dev utils
echo "-----> Installing dev utils..."
apt install -y net-tools inetutils-tools curl git vim build-essential cmake tldr htop bat exa zsh silversearcher-ag autojump global

echo "-----> Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install vimrc
echo "-----> Installing vimrc..."
git clone --recursive --depth=1 https://github.com/gmingj/vimrc.git -b myvimrc ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# install ohmyzsh
echo "-----> Installing ohmyzsh..."
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmingj/ohmyzsh/myohmyzsh/tools/install.sh)"

echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "-----> Installing zsh theme 'powerlevel10k'..."
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# p10k configure

echo "-----> Customizing ohmyzsh..."
sed -i '/ZSH_THEME=\"robbyrussell\"/cZSH_THEME=\"powerlevel10k/powerlevel10k\"' $HOME/.zshrc
sed -i '/plugins=(git)/cplugins=(git autojump zsh-autosuggestions zsh-syntax-highlighting)' $HOME/.zshrc
append_text() {
  echo $1 >> $HOME/.zshrc
}
append_text ""
append_text "# Set/Unset proxy aliases"
append_text "HOSTIP=\$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')"
append_text 'export https_proxy="http://${HOSTIP}:7890"; export http_proxy="http://${HOSTIP}:7890"; export all_proxy="socks5://${HOSTIP}:7890"; export ALL_PROXY="socks5://${HOSTIP}:7890";'
append_text 'unset https_proxy; unset http_proxy; unset all_proxy; unset ALL_PROXY;'
append_text ""
append_text "# Fzf"
append_text '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'
append_text "export FZF_DEFAULT_COMMAND='ag -i --hidden -l -g \"\"'"
append_text "export FZF_DEFAULT_OPTS=\"--layout=reverse --preview '(bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500'\""

# install tmux
echo "-----> Installing tmux..."
git clone --depth=1 https://github.com/gmingj/.tmux.git -b mytmux ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/.tmux/.tmux.conf.local ~/.tmux.conf.local

#!/usr/bin/env bash

PROXYDNS=$1

# Test connectivity
if ! curl -I www.google.com | head -n 1 | grep "200 OK" >/dev/null; then
    echo "Connectivity test failed. Please check your proxy settings and try again."
    exit 1
fi

# Setup tmux (ohmytmux), if needed install tmux plugins mannually: <prefix> + I
git clone --depth=1 https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~
cp ~/.tmux/.tmux.conf.local ~
sed -i -e "/^tmux_conf_theme=enabled$/s/enabled/disabled/" \
    -e "/^tmux_conf_copy_to_os_clipboard=false$/s/false/true/" \
    -e "/^tmux_conf_update_plugins_on_launch=true$/s/true/false/" \
    -e "/^tmux_conf_update_plugins_on_reload=true$/s/true/false/" \
    -e "/^tmux_conf_uninstall_plugins_on_reload=true$/s/true/false/" \
    -e "/^#set -g status-keys vi$/s/#//" \
    -e "/^#set -g mode-keys vi$/s/#//" \
    -e "/^# set -gu prefix2$/s/# //" \
    -e "/^# unbind C-a$/s/# //" \
    -e "/^# unbind C-b$/s/# //" \
    -e "s/^# set -g prefix C-a/set -g prefix C-x/g" \
    -e "/^# -- custom variables/i\set -g @plugin 'nordtheme/tmux'\nbind-key g setw synchronize-panes" ~/.tmux.conf.local

# Setup oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git -b v0.7.0 ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git -b 0.8.0 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git -b v1.20.0 ~/.oh-my-zsh/custom/themes/powerlevel10k

sed -i -e "/^ZSH_THEME=/s/.*/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/" \
    -e "/^plugins=/s/.*/plugins=(git autojump zsh-autosuggestions zsh-syntax-highlighting tmux)/" \
    -e "/^source \$ZSH\/oh-my-zsh.sh/i\ZSH_TMUX_AUTOQUIT=false" ~/.zshrc

if [ -n "$PROXYDNS" ]; then
cat << EOF >> ~/.zshrc
# Setup proxy
export https_proxy="http://${PROXYDNS}:7890"; export http_proxy="http://${PROXYDNS}:7890"; export all_proxy="socks5://${PROXYDNS}:7890"; export ALL_PROXY="socks5://${PROXYDNS}:7890";
alias setp='export https_proxy="http://${PROXYDNS}:7890"; export http_proxy="http://${PROXYDNS}:7890"; export all_proxy="socks5://${PROXYDNS}:7890"; export ALL_PROXY="socks5://${PROXYDNS}:7890";'
alias unsetp='unset https_proxy; unset http_proxy; unset all_proxy; unset ALL_PROXY;'
EOF
fi

cat << EOF >> ~/.zshrc
# Fzf
export FZF_DEFAULT_COMMAND='ag -i --hidden -l -a -g ""'
export FZF_DEFAULT_OPTS="--height 80% --layout reverse --preview '(bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500'"

# if no session is started, start a new session, better than 'ZSH_TMUX_AUTOSART'
if command -v tmux > /dev/null 2>&1 && [ -z \${TMUX} ]; then
    tmux new-session
fi
EOF

# Install fzf
git clone --depth=1 https://github.com/junegunn/fzf.git -b 0.53.0 ~/.fzf
~/.fzf/install

# Setup vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
git clone --depth 1 https://github.com/nordtheme/vim.git -b v0.19.0 ~/.vim_runtime/my_plugins/nordtheme
git clone --depth 1 https://github.com/Yggdroot/LeaderF.git -b v1.25 ~/.vim_runtime/my_plugins/LeaderF
ln -s ~/.fzf ~/.vim_runtime/my_plugins/fzf
git clone --depth 1 https://github.com/preservim/tagbar.git -b v3.1.1 ~/.vim_runtime/my_plugins/tagbar
git clone --depth 1 https://github.com/easymotion/vim-easymotion.git -b v3.0.1 ~/.vim_runtime/my_plugins/vim-easymotion
git clone --depth 1 https://github.com/SirVer/ultisnips.git -b 3.2 ~/.vim_runtime/my_plugins/ultisnips
# git clone --depth 1 https://github.com/ycm-core/YouCompleteMe.git ~/.vim_runtime/my_plugins/YouCompleteMe
# cd ~/.vim_runtime/my_plugins/YouCompleteMe
# git submodule update --init --recursive
# python3 install.py --clangd-completer
curl -o ~/.vim_runtime/my_configs.vim -L https://raw.githubusercontent.com/gmingj/mydotfiles/main/my_configs.vim

# Setup git
# git config --global user.email x@gmail.com
# git config --global user.name x
git config --global core.editor vim

# Setup bat
if [ ! -e "/usr/bin/batcat" ]; then
    echo "Warning: 'batcat' is not found. Please make sure it exists."
elif [ ! -e "/usr/bin/bat" ]; then
    echo "Need root privilege to caeate symbolic link 'bat'"
    sudo ln -s /usr/bin/batcat /usr/bin/bat
    echo "Symbolic link 'bat' to 'batcat' created successfully."
else
    echo "Warning: Symbolic link 'bat' already exists."
fi

echo "Development environment deployment completed! Please reboot..."

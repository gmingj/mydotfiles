#/bin/bash

set -e

echo "-----> Customizing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# customize ohmyzsh
echo "-----> Customizing ohmyzsh..."
git clone --recursive --depth=1 https://github.com/gmingj/ohmyzsh.git -b myohmyzsh $HOME/.oh-my-zsh
sh $HOME/.oh-my-zsh/tools/install.sh --unattended

# customize tmux
echo "-----> Customizing tmux..."
git clone --depth=1 https://github.com/gmingj/.tmux.git -b mytmux $HOME/.tmux
ln -s -f $HOME/.tmux/.tmux.conf $HOME/.tmux.conf
ln -s -f $HOME/.tmux/.tmux.conf.local $HOME/.tmux.conf.local

# install vimrc
echo "-----> Customizing vimrc..."
git clone --recursive --depth=1 https://github.com/gmingj/vimrc.git -b myvimrc $HOME/.vim_runtime
sh $HOME/.vim_runtime/install_awesome_vimrc.sh

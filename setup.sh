#!/usr/bin/env bash

# WSL/Debian Development Environment Setup
# Usage:
#   Install: curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash
#   Install with proxy: curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- PROXY_IP
#   Uninstall: curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- --uninstall

set -e

# ============================================================================
# Configuration & Argument Parsing
# ============================================================================

PROXY_DNS=""
ACTION="install"

for arg in "$@"; do
    case $arg in
        --uninstall) ACTION="uninstall"; shift ;;
        --help|-h) ACTION="help"; shift ;;
        *) if [[ "$arg" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then PROXY_DNS="$arg"; fi; shift ;;
    esac
done

# ============================================================================
# Helper Functions
# ============================================================================

show_usage() {
    cat << 'EOF'
WSL/Debian Development Environment Setup

USAGE:
  # Install
  curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash

  # Install with proxy
  curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- YOUR_PROXY_IP

  # Uninstall
  curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- --uninstall

FEATURES:
  - tmux with oh-my-tmux configuration
  - zsh with oh-my-zsh + powerlevel10k theme
  - vim with awesome vimrc + plugins
  - fzf fuzzy finder
  - Essential development tools
EOF
}

setup_proxy() {
    if [ -n "$PROXY_DNS" ]; then
        echo "🌐 Setting up proxy: $PROXY_DNS"
        export https_proxy="http://${PROXY_DNS}:7890"
        export http_proxy="http://${PROXY_DNS}:7890"
        export all_proxy="socks5://${PROXY_DNS}:7890"
        export ALL_PROXY="socks5://${PROXY_DNS}:7890"
    fi
}

# ============================================================================
# Installation Functions
# ============================================================================

install_packages() {
    echo "📦 Installing required packages..."
    sudo apt update
    sudo apt install -y curl git tmux zsh autojump silversearcher-ag global universal-ctags xclip \
        build-essential cmake libtool pkg-config python3-dev python3-pip python3-pygments libncurses-dev\
        iproute2 iputils-ping cloc bat figlet htop bmon jq

    echo "⚒️  Building vim from source..."
    # Remove existing vim package to avoid conflicts
    sudo apt remove -y vim vim-tiny vim-common

    # Clone vim source code
    if [ -d "/tmp/vim" ]; then
        rm -rf /tmp/vim
    fi
    cd /tmp
    git clone --depth=1 https://github.com/vim/vim.git
    cd vim

    # Configure and build vim with full features
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-python3interp=yes \
                --with-python3-config-dir=$(python3-config --configdir) \
                --prefix=/usr/local

    # Build with all available CPU cores
    make -j$(nproc)

    # Install vim
    sudo make install

    # Update alternatives to use the new vim
    sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/vim 60
    sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 60

    # Clean up temporary files
    cd ~
    rm -rf /tmp/vim

    echo "✅ Vim built and installed from source successfully!"
}

setup_tmux() {
    echo "🔧 Setting up tmux..."
    rm -rf ~/.tmux ~/.tmux.conf ~/.tmux.conf.local
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
        -e "/^# -- custom variables/i\set -g @plugin 'nordtheme/tmux'\nbind-key g setw synchronize-panes" \
        -e "/^# -- custom variables/i\bind-key p run-shell \"tmux set-buffer \\\"\$(xclip -o -selection clipboard)\\\"; tmux paste-buffer\"" \
        ~/.tmux.conf.local
}

setup_zsh() {
    echo "🐚 Setting up zsh..."
    rm -rf ~/.oh-my-zsh ~/.zshrc
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

    sed -i -e "/^ZSH_THEME=/s/.*/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/" \
        -e "/^plugins=/s/.*/plugins=(git autojump zsh-autosuggestions zsh-syntax-highlighting tmux)/" \
        -e "/^source \$ZSH\/oh-my-zsh.sh/i\ZSH_TMUX_AUTOQUIT=false" ~/.zshrc

    # Set zsh as default shell
    echo "🔧 Setting zsh as default shell..."
    if [ "$SHELL" != "$(which zsh)" ]; then
        echo "$(which zsh)" | sudo tee -a /etc/shells > /dev/null
        sudo chsh -s $(which zsh) $USER
        echo "✅ Default shell changed to zsh. You'll need to restart your terminal or login again to take effect."
    else
        echo "✅ zsh is already the default shell."
    fi

    # Add custom configurations
    cat << 'EOF' >> ~/.zshrc

# FZF configuration
export FZF_DEFAULT_COMMAND='ag -i --hidden -l -a -g ""'
export FZF_DEFAULT_OPTS="--height 80% --layout reverse --preview '(bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500'"

EOF

    # Add proxy configuration if provided
    if [ -n "$PROXY_DNS" ]; then
        cat << EOF >> ~/.zshrc

# Proxy configuration
export https_proxy="http://${PROXY_DNS}:7890"
export http_proxy="http://${PROXY_DNS}:7890"
export all_proxy="socks5://${PROXY_DNS}:7890"
export ALL_PROXY="socks5://${PROXY_DNS}:7890"
alias setp='export https_proxy="http://${PROXY_DNS}:7890"; export http_proxy="http://${PROXY_DNS}:7890"; export all_proxy="socks5://${PROXY_DNS}:7890"; export ALL_PROXY="socks5://${PROXY_DNS}:7890";'
alias unsetp='unset https_proxy; unset http_proxy; unset all_proxy; unset ALL_PROXY;'
EOF
    fi
}

setup_fzf() {
    echo "🔍 Setting up fzf..."
    rm -rf ~/.fzf
    git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
}

create_vim_config() {
    cat << 'EOF' > ~/.vim_runtime/my_configs.vim

set nu rnu nowrap nowrapscan noshowmode cc=81

colorscheme nord
let g:lightline.colorscheme = 'nord'
let g:lightline.active.left = [
    \ [ 'mode', 'paste' ],
    \ [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ]
let g:lightline.active.right = [
    \ [ 'lineinfo' ],
    \ [ 'percent' ],
    \ [ 'fileformat', 'fileencoding', 'filetype' ] ]
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.component.lineinfo = '%3l,%-2c'
let g:lightline.component.percent = '%3p%%/%L'

try
    unmap <leader>f
catch
endtry

inoremap jk <Esc>

nmap <silent> <leader>tt :TagbarToggle<CR>
let g:tagbar_position = 'left'

" LeaderF configuration
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "", 'right': "" }
let g:Lf_ShowDevIcons = 1
let g:Lf_PopupShowStatusline = 0
let g:Lf_ShowHidden = 1
let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
    \}
let g:Lf_ExternalCommand = 'ag -g "%s" -i -a --hidden'
let g:Lf_PopupColorscheme = 'onedark'
let g:Lf_StlColorscheme = 'onedark'

let g:Lf_ShortcutF = '<leader>ff'
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s --bottom --cword --regexMode", "")<CR><CR>

let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fg :<C-U><C-R>=printf("Leaderf! gtags -g %s", expand("<cword>"))<CR><CR>
noremap <leader>fG :<C-U><C-R>=printf("Leaderf gtags %s", "")<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Clipboard integration
nnoremap <silent> <leader>P :%!xclip -o -selection clipboard<CR>
vnoremap <silent> <leader>Y :w !xclip -selection clipboard<CR><CR>

EOF
}

setup_vim() {
    echo "✏️  Setting up vim..."
    rm -rf ~/.vim_runtime ~/.vimrc
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    bash ~/.vim_runtime/install_awesome_vimrc.sh
    create_vim_config

    echo "📥 Installing vim plugins..."
    ln -s ~/.fzf ~/.vim_runtime/my_plugins/fzf
    git clone --depth 1 https://github.com/nordtheme/vim.git ~/.vim_runtime/my_plugins/nordtheme
    git clone --depth 1 https://github.com/Yggdroot/LeaderF.git ~/.vim_runtime/my_plugins/LeaderF
    git clone --depth 1 https://github.com/preservim/tagbar.git ~/.vim_runtime/my_plugins/tagbar
    git clone --depth 1 https://github.com/easymotion/vim-easymotion.git ~/.vim_runtime/my_plugins/vim-easymotion
    git clone --depth 1 https://github.com/SirVer/ultisnips.git ~/.vim_runtime/my_plugins/ultisnips
}

setup_git_and_bat() {
    echo "⚙️  Configuring git and bat..."
    git config --global core.editor vim
    if [ ! -e "/usr/bin/batcat" ]; then
        echo "⚠️  Warning: 'batcat' not found"
    elif [ ! -e "/usr/bin/bat" ]; then
        sudo ln -s /usr/bin/batcat /usr/bin/bat
    fi
}

# ============================================================================
# Uninstall Functions
# ============================================================================

uninstall_environment() {
    echo "🗑️  Starting development environment uninstall..."

    echo "📁 Removing installed configurations..."
    rm -rf ~/.tmux ~/.oh-my-zsh ~/.fzf ~/.vim_runtime
    rm -f ~/.tmux.conf ~/.tmux.conf.local ~/.vimrc

    if [ -L "/usr/bin/bat" ] && [ "$(readlink /usr/bin/bat)" = "/usr/bin/batcat" ]; then
        echo "🔗 Removing bat symlink..."
        sudo rm -f /usr/bin/bat
    fi

    if [ -f ~/.zshrc ]; then
        echo "🧹 Cleaning zsh configurations..."
        sed -i '/^# Proxy configuration$/,/^$/d' ~/.zshrc
        sed -i '/^# FZF configuration$/,/^fi$/d' ~/.zshrc

        if [ $(grep -c '^[^#]' ~/.zshrc 2>/dev/null || echo 0) -lt 5 ]; then
            rm -f ~/.zshrc
        fi
    fi

    echo "✅ Uninstall completed!"
    echo "📝 Note: Installed packages were not removed. To remove them manually:"
    echo "   sudo apt remove tmux zsh vim autojump silversearcher-ag global universal-ctags xclip"
}

# ============================================================================
# Main Functions
# ============================================================================

show_font_installation_info() {
    echo ""
    echo "📝 IMPORTANT: Windows Font Installation Guide"
    echo "======================================================"
    echo "For the best terminal display experience, please install the following fonts on Windows:"
    echo ""
    echo "🔗 Recommended font download links:"
    echo "   • Nerd Fonts (MesloLGS NF): https://github.com/ryanoasis/nerd-fonts/releases"
    echo "   • JetBrains Mono Nerd Font: https://github.com/ryanoasis/nerd-fonts/releases"
    echo "   • Fira Code Nerd Font: https://github.com/ryanoasis/nerd-fonts/releases"
    echo ""
    echo "📋 Installation steps:"
    echo "   1. Download font files (.ttf or .otf)"
    echo "   2. Right-click on font files → Select 'Install'"
    echo "   3. Configure font in Windows Terminal:"
    echo "      - Open Windows Terminal settings"
    echo "      - Select your WSL profile"
    echo "      - Set font to installed Nerd Font in 'Appearance'"
    echo ""
    echo "💡 Recommended settings:"
    echo "   Font: MesloLGS NF"
    echo "   Size: 11-12pt"
    echo "   Enable ligatures: Yes"
    echo "======================================================"
}

install_environment() {
    echo "🚀 Starting WSL/Debian Development Environment Setup..."

    setup_proxy
    install_packages
    setup_tmux
    setup_zsh
    setup_fzf
    setup_vim
    setup_git_and_bat

    echo ""
    echo "✅ Installation completed successfully!"
    echo "🔄 Please restart your terminal or run: exec zsh"
    echo "📚 Key shortcuts:"
    echo "   Ctrl-x    : tmux prefix"
    echo "   jk        : vim escape"
    echo "   <leader>tt: vim tagbar toggle"
    echo "   <leader>ff: vim file finder"

    # Show font installation information
    show_font_installation_info
}

main() {
    case $ACTION in
        "help") show_usage ;;
        "uninstall") uninstall_environment ;;
        "install") install_environment ;;
        *) echo "❌ Unknown action: $ACTION"; show_usage; exit 1 ;;
    esac
}

# Run main function
main

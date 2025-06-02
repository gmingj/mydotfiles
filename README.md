# WSL/Debian Development Environment

🚀 **One-command deployment of complete development environment**

## Features

- **Single file solution**: All functionality integrated in one script
- **One-command install**: `curl -fsSL ... | bash`
- **One-command uninstall**: `curl -fsSL ... | bash -s -- --uninstall` 
- **Proxy support**: Optimized for restricted network environments
- **Comprehensive tools**: tmux, zsh, vim, fzf and development tools

## Included Tools

### System Tools
- `tmux` with oh-my-tmux configuration (Ctrl-x prefix)
- `zsh` with oh-my-zsh + powerlevel10k theme
- `vim` with awesome vimrc + plugin ecosystem
- `fzf` fuzzy finder
- `git`, `bat`, `htop`, `ag` and other essential tools

### Vim Plugins
- Nord theme for unified interface
- LeaderF file navigation (`<leader>ff`)
<!-- - YouCompleteMe code completion -->
- Tagbar code structure (`<leader>tt`)
- EasyMotion fast navigation
<!-- - Codeium AI assistance -->
- UltiSnips code snippets

## Quick Start

### Installation

```bash
# Basic installation
curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash

# Installation with proxy
curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- YOUR_PROXY_IP
```

### Uninstall

```bash
# Complete uninstall
curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- --uninstall
```

### Help

```bash
# View usage instructions
curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- --help
```

## Project Structure

```
mydotfiles/
├── setup.sh            # Single file solution (includes install/uninstall/config)
├── README.md           # Documentation
└── LICENSE             # License file
```

## Key Shortcuts

### Tmux
- `Ctrl-x`: tmux prefix key (replaces default Ctrl-b)
- `Ctrl-x g`: synchronize input across all panes
- `Ctrl-x p`: paste from system clipboard

### Vim
- `jk`: exit insert mode
- `<leader>tt`: toggle tagbar
- `<leader>ff`: file finder (LeaderF)
- `<leader>fm`: recent files
- `<leader>fb`: buffer list
- `<leader>P`: paste from system clipboard
- `<leader>Y`: copy to system clipboard

### Automatic Features
- vim integration with fzf file finder
- System clipboard integration
- Automatic proxy configuration (setp/unsetp aliases)

## Proxy Configuration

### Install with Proxy
```bash
curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- YOUR_PROXY_IP
```

### Runtime Proxy Switching
After installation, use these aliases:
```bash
setp     # Enable proxy
unsetp   # Disable proxy
```

## Troubleshooting

### Check Installation
```bash
which zsh tmux vim fzf git ag
ls -la ~/.oh-my-zsh ~/.vim_runtime ~/.fzf
```

### YouCompleteMe Issues
```bash
cd ~/.vim_runtime/my_plugins/YouCompleteMe
python3 install.py --clangd-completer
```

### Proxy Connection Test
```bash
curl -s --connect-timeout 5 https://www.google.com
```

### Reinstallation
```bash
# First uninstall
curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash -s -- --uninstall

# Then reinstall
curl -fsSL https://raw.githubusercontent.com/gmingj/mydotfiles/main/setup.sh | bash
```

## System Requirements

- Debian/Ubuntu system (designed for WSL)
- sudo privileges for package installation
- Internet connectivity (or proxy access)

## Technical Features

- **Modular design**: Clear functional blocks
- **Error handling**: Automatic stop on errors
- **Idempotent**: Safe to run multiple times
- **Clean removal**: Complete configuration cleanup on uninstall

## License

MIT License - see [LICENSE](LICENSE) file for details

# Dotfiles
Development environment configuration for vim, tmux, zsh...

## Dependence
- curl
- git
- vim
- zsh
- autojump

## Frequently used utils
```shell
apt install -y net-tools inetutils-tools curl git vim build-essential cmake tldr htop bat exa zsh silversearcher-ag autojump global
```

## Usage
```shell
apt update && apt install -y curl git vim autojump zsh
git clone --depth=1 https://github.com/gmingj/mydotfiles.git && cd mydotfiles
source proxyenv
setp
sh install.sh < input
zsh # startup with p10k configure
```

## Example
```
-----> Installing fzf...
Cloning into '/root/.fzf'...
remote: Enumerating objects: 114, done.
remote: Counting objects: 100% (114/114), done.
remote: Compressing objects: 100% (108/108), done.
remote: Total 114 (delta 2), reused 34 (delta 0), pack-reused 0
Receiving objects: 100% (114/114), 253.05 KiB | 233.00 KiB/s, done.
Resolving deltas: 100% (2/2), done.
Downloading bin/fzf ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0
100 1345k  100 1345k    0     0   192k      0  0:00:07  0:00:07 --:--:--  342k
  - Checking fzf executable ... 0.41.1
Do you want to enable fuzzy auto-completion? ([y]/n) y
Do you want to enable key bindings? ([y]/n) y

Generate /root/.fzf.bash ... OK
Generate /root/.fzf.zsh ... OK

Do you want to update your shell configuration files? ([y]/n) y

Update /root/.bashrc:
  - [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    + Added

Update /root/.zshrc:
  - [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    + Added

Finished. Restart your shell or reload config file.
   source ~/.bashrc  # bash
   source ~/.zshrc   # zsh

Use uninstall script to remove fzf.

For more information, see: https://github.com/junegunn/fzf
-----> Installing vimrc...
Cloning into '/root/.vim_runtime'...
remote: Enumerating objects: 2268, done.
remote: Counting objects: 100% (2268/2268), done.
remote: Compressing objects: 100% (1760/1760), done.
remote: Total 2268 (delta 260), reused 2024 (delta 208), pack-reused 0
Receiving objects: 100% (2268/2268), 4.64 MiB | 1.09 MiB/s, done.
Resolving deltas: 100% (260/260), done.
Submodule 'my_plugins/LeaderF' (https://github.com/Yggdroot/LeaderF.git) registered for path 'my_plugins/LeaderF'
Submodule 'my_plugins/fzf' (https://github.com/junegunn/fzf.git) registered for path 'my_plugins/fzf'
Submodule 'my_plugins/tagbar' (https://github.com/preservim/tagbar.git) registered for path 'my_plugins/tagbar'
Submodule 'my_plugins/vim-easymotion' (https://github.com/easymotion/vim-easymotion) registered for path 'my_plugins/vim-easymotion'
Submodule 'my_plugins/vim-one' (https://github.com/rakr/vim-one.git) registered for path 'my_plugins/vim-one'
Cloning into '/root/.vim_runtime/my_plugins/LeaderF'...
remote: Enumerating objects: 6924, done.
remote: Counting objects: 100% (901/901), done.
remote: Compressing objects: 100% (310/310), done.
remote: Total 6924 (delta 502), reused 853 (delta 478), pack-reused 6023
Receiving objects: 100% (6924/6924), 1.96 MiB | 351.00 KiB/s, done.
Resolving deltas: 100% (4157/4157), done.
Cloning into '/root/.vim_runtime/my_plugins/fzf'...
remote: Enumerating objects: 12281, done.
remote: Counting objects: 100% (1402/1402), done.
remote: Compressing objects: 100% (265/265), done.
remote: Total 12281 (delta 1179), reused 1293 (delta 1127), pack-reused 10879
Receiving objects: 100% (12281/12281), 4.98 MiB | 1001.00 KiB/s, done.
Resolving deltas: 100% (7809/7809), done.
Cloning into '/root/.vim_runtime/my_plugins/tagbar'...
remote: Enumerating objects: 3895, done.
remote: Counting objects: 100% (232/232), done.
remote: Compressing objects: 100% (117/117), done.
remote: Total 3895 (delta 101), reused 212 (delta 86), pack-reused 3663
Receiving objects: 100% (3895/3895), 2.27 MiB | 491.00 KiB/s, done.
Resolving deltas: 100% (1614/1614), done.
Cloning into '/root/.vim_runtime/my_plugins/vim-easymotion'...
remote: Enumerating objects: 3772, done.
remote: Counting objects: 100% (44/44), done.
remote: Compressing objects: 100% (39/39), done.
remote: Total 3772 (delta 7), reused 38 (delta 4), pack-reused 3728
Receiving objects: 100% (3772/3772), 1.45 MiB | 664.00 KiB/s, done.
Resolving deltas: 100% (1880/1880), done.
Cloning into '/root/.vim_runtime/my_plugins/vim-one'...
remote: Enumerating objects: 633, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 633 (delta 3), reused 10 (delta 2), pack-reused 621
Receiving objects: 100% (633/633), 3.82 MiB | 1.03 MiB/s, done.
Resolving deltas: 100% (259/259), done.
Submodule path 'my_plugins/LeaderF': checked out '5746281bb6467522e959f75939976e98da277f1e'
Submodule path 'my_plugins/fzf': checked out '94999101e358385f3ca67a6ec9512f549196b802'
Submodule path 'my_plugins/tagbar': checked out 'be563539754b7af22bbe842ef217d4463f73468c'
Submodule path 'my_plugins/vim-easymotion': checked out 'b3cfab2a6302b3b39f53d9fd2cd997e1127d7878'
Submodule path 'my_plugins/vim-one': checked out '187f5c85b682c1933f8780d4d419c55d26a82e24'
Installed the Ultimate Vim configuration successfully! Enjoy :-)
-----> Installing ohmyzsh...
Cloning Oh My Zsh...
remote: Enumerating objects: 1343, done.
remote: Counting objects: 100% (1343/1343), done.
remote: Compressing objects: 100% (1293/1293), done.
remote: Total 1343 (delta 32), reused 1160 (delta 27), pack-reused 0
Receiving objects: 100% (1343/1343), 1.99 MiB | 495.00 KiB/s, done.
Resolving deltas: 100% (32/32), done.
From https://github.com/gmingj/ohmyzsh
 * [new branch]      master     -> origin/master
 * [new branch]      myohmyzsh  -> origin/myohmyzsh
Branch 'myohmyzsh' set up to track remote branch 'myohmyzsh' from 'origin'.
Switched to a new branch 'myohmyzsh'
/

Looking for an existing zsh config...
Found /root/.zshrc. Backing up to /root/.zshrc.pre-oh-my-zsh
Using the Oh My Zsh template file and adding it to /root/.zshrc.

Time to change your default shell to zsh:
Do you want to change your default shell to zsh? [Y/n] Y
Changing your shell to /usr/bin/zsh...
Shell successfully changed to '/usr/bin/zsh'.

         __                                     __
  ____  / /_     ____ ___  __  __   ____  _____/ /_
 / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/
                        /____/                       ....is now installed!


Before you scream Oh My Zsh! look over the `.zshrc` file to select plugins, themes, and options.

• Follow us on Twitter: https://twitter.com/ohmyzsh
• Join our Discord community: https://discord.gg/ohmyzsh
• Get stickers, t-shirts, coffee mugs and more: https://shop.planetargon.com/collections/oh-my-zsh

➜  / exit
-----> Installing zsh plugin 'zsh-syntax-highlighting'...
Cloning into '/plugins/zsh-autosuggestions'...
remote: Enumerating objects: 72, done.
remote: Counting objects: 100% (72/72), done.
remote: Compressing objects: 100% (63/63), done.
remote: Total 72 (delta 9), reused 37 (delta 3), pack-reused 0
Receiving objects: 100% (72/72), 35.52 KiB | 118.00 KiB/s, done.
Resolving deltas: 100% (9/9), done.
Cloning into '/plugins/zsh-syntax-highlighting'...
remote: Enumerating objects: 368, done.
remote: Counting objects: 100% (368/368), done.
remote: Compressing objects: 100% (300/300), done.
remote: Total 368 (delta 299), reused 103 (delta 54), pack-reused 0
Receiving objects: 100% (368/368), 180.58 KiB | 148.00 KiB/s, done.
Resolving deltas: 100% (299/299), done.
-----> Installing zsh theme 'powerlevel10k'...
Cloning into '/themes/powerlevel10k'...
remote: Enumerating objects: 93, done.
remote: Counting objects: 100% (93/93), done.
remote: Compressing objects: 100% (79/79), done.
remote: Total 93 (delta 13), reused 60 (delta 10), pack-reused 0
Receiving objects: 100% (93/93), 414.43 KiB | 945.00 KiB/s, done.
Resolving deltas: 100% (13/13), done.
-----> Customizing ohmyzsh...
-----> Installing tmux...
Cloning into '/root/.tmux'...
remote: Enumerating objects: 11, done.
remote: Counting objects: 100% (11/11), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 11 (delta 0), reused 8 (delta 0), pack-reused 0
Receiving objects: 100% (11/11), 27.05 KiB | 82.00 KiB/s, done.
```

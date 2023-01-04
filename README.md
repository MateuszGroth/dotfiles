## Setup

1. Install Apple's Command line tools

```shell
    xcode-select --install
```

2. Clone dotfiles repo

> HTTPS

```shell
    git clone https://github.com/MateuszGroth/dotfiles.git ~/.dotfiles
```

> SSH

```shell
    git clone git@github.com:MateuszGroth/dotfiles.git ~/.dotfiles
```

3. Bootstrap the machine

```shell
    ./scripts/bootstrap.sh
```

### Manual linking

```shell
    ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/git/gitignore ~/.gitignore
    ln -s ~/.dotfiles/hyper/.hyper.js ~/.hyper.js
    ln -s ~/.dotfiles/zsh/rc.zsh ~/.zshrc
```

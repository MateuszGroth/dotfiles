## Setup

1. Install Apple's Command line tools

```shell
    xcode-select --install
```

2. Install brew

```shell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the instructions to add brew to path and then

3. Install git with brew

```shell
    brew install git
```

4. Clone dotfiles repo

> HTTPS

```shell
    git clone https://github.com/MateuszGroth/dotfiles.git ~/.dotfiles
```

> SSH

```shell
    git clone git@github.com:MateuszGroth/dotfiles.git ~/.dotfiles
```

5. Install brew in case it wasn't installed in the previous steps

```shell
    bash ./brew/install.sh
```

Follow the instructions to add brew to path and then

```shell
    brew bundle --file ~/.dotfiles/brew/Brewfile
```

4. Bootstrap the machine (linking)

```shell
    bash ./install/bootstrap.sh
```

5. Install oh my zsh

```shell
    bash ./oh-my-zsh/install.sh
```

6. setup git ssh connection

```shell
    cd ~/.ssh && ssh-keygen -t rsa
```

Create the key as you wish (name, phrase).
Add the key to the ssh agent

Put the following code into your _~/.ssh/config_ file

```shell
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/<token name>
```

Copy the public key.
Go to Account > Settings > SSH and GPK Keys, or (link)[https://github.com/settings/keys]
Click on New SSH Key
Add a title and put the public key into the Key textfield

### Manual linking

```shell
    ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/git/gitignore ~/.gitignore
    ln -s ~/.dotfiles/hyper/.hyper.js ~/.hyper.js
    ln -s ~/.dotfiles/zsh/rc.zsh ~/.zshrc
    ln -s ~/.dotfiles/lvim/config.lua ~/.config/lvim/config.lua
```

### Env variables

Put you environment variables into ~/.env.sh

### Brew bundle

```
    brew bundle dump
```

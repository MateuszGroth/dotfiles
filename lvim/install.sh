#!/usr/bin/env bash
# brew install lua

# install cargo
curl https://sh.rustup.rs -sSf | sh

LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
#!/bin/sh

# Enable shell script strictness
set -eu

# Enable command tracing
set -x

# Ensure config directory exists
mkdir -p ~/.config

# Link Git config if it doesn’t exist
[ ! -e ~/.config/git ] && ln -s "$PWD/config/git" ~/.config/git

# Add the Zsh config file if it doesn’t exist
[ ! -e ~/.zshrc ] && ln -s "$PWD/config/zshrc" ~/.zshrc

# Add the neovim config file if it doesn’t exist
[ ! -e ~/.config/nvim ] && ln -s "$PWD/config/nvim" ~/.config/nvim

# Add the emacs config file if it doesn’t exist
[ ! -e ~/.config/emacs ] && ln -s "$PWD/config/emacs" ~/.config/emacs

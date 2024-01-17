#!/bin/sh

# Enable shell script strictness
set -eu

# Enable command tracing
set -x

# Ensure config directory exists
mkdir -p ~/.config

# Link Git config if it doesn’t exist
# [ ! -e ~/.config/git ] && ln -s "$PWD/config/git" ~/.config/git
ln -sf "$PWD/config/git" ~/.config/git

# Add the Zsh config file if it doesn’t exist
# [ ! -e ~/.zshrc ] && ln -s "$PWD/config/zshrc" ~/.zshrc
ln -sf "$PWD/config/zshrc" ~/.zshrc

# Add the neovim config if it doesn’t exist
# [ ! -e ~/.config/nvim ] && ln -s "$PWD/config/nvim" ~/.config/nvim
ln -sf "$PWD/config/nvim" ~/.config/nvim

# Add the tmux config if it doesn’t exist
# [ ! -e ~/.tmux.conf ] && ln -s "$PWD/config/tmux.conf" ~/.tmux.conf
ln -sf "$PWD/config/tmux.conf" ~/.tmux.conf

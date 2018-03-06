#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"

# Make utilities available
PATH="$DOTFILES_DIR/bin:$PATH"

# Check for zsh installation
if ! is-executable zsh; then
  echo 'Install zsh first'; exit 1;
fi

# Install oh-my-zsh if needed
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Update dotfiles itself first
#if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi

# Bunch of symlinks
ln -sfv "$DOTFILES_DIR/.zshrc" ~
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.gitignore_global" ~

# Symbolic links to custom zsh plugins
ZSH_CUSTOM=$ZSH/custom
DOTFILES_CUSTOM=$DOTFILES_DIR/custom
for CUSTOM in `ls $DOTFILES_CUSTOM`; do
  ln -sfv $DOTFILES_CUSTOM/$CUSTOM $ZSH_CUSTOM/$CUSTOM.zsh
done
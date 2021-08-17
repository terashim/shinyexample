#!/bin/bash

set -eux

DOTFILES_ROOT=$(dirname $(readlink -f $0))
cd $DOTFILES_ROOT

LINK_PATH="/home/rstudio/.config/rstudio"
FILE_PATH="$DOTFILES_ROOT/.config/rstudio"
sudo -u rstudio mkdir -p $(dirname $LINK_PATH)
sudo -u rstudio ln -sfnv "$FILE_PATH" "$LINK_PATH"

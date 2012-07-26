#!/bin/sh

OPTION=""
DRYRUN=""
while getopts nfv OPT
do
  case $OPT in
    "n" ) DRYRUN="echo"       ;;  # dryrun
    "f" ) OPTION="$OPTION -f" ;;  # force
    "v" ) OPTION="$OPTION -v" ;;  # verbose
      *   ) echo "usage: $0 [-fvn]"
          exit 1;;
  esac
done

if [ -n "$DRYRUN" ]; then
    echo "***dryrun***"
fi

for f in \
    .ctags \
    .dir_colors \
    .gdbinit \
    .gitconfig \
    .gitignore.global \
    .inputrc \
    .lesskey \
    .my.cnf \
    .percol.d \
    .screenrc \
    .tmux.conf \
    .vimrc \
    .zshenv \
    .zshrc
do
    $DRYRUN ln -s $OPTION $PWD/$f $HOME/$f
done

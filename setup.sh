#!/bin/sh

cd `dirname $0`
F=`pwd |sed -e "s#$HOME/\?##"`

for P in *
do
  # skip gitignore and README
  if [[ "$P" == .gitignore ]]; then continue; fi
  if [[ "$P" == README.md ]]; then continue; fi

  # ensure permissions
  chmod -R o-rwx,g-rwx $P

  # skip existing links
  if [ -h "$HOME/.$P" ]; then continue; fi

  # move existing dir out of the way
  if [ -e "$HOME/.$P" ]; then
    if [ -e "$HOME/__$P" ]; then
      echo "want to override $HOME/.$P but backup exists"
      continue;
    fi

    echo -n "Backup "
    mv -v "$HOME/.$P" "$HOME/__$P"
  fi

  # create link
  echo -n "Link "
  ln -v -s "$F/$P" "$HOME/.$P"
done

# install brew
which -s brew
if [[ $? != 0 ]] ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  brew update
fi

# install a couple of brew packages
brew install git
brew install git-completion
brew install autojump

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install fonts
if [ -h "$HOME/dotfiles/vim/fonts" ]; then
  continue;
else
  git clone https://github.com/powerline/fonts.git $HOME/dotfiles/vim/fonts
  $HOME/dotfiles/vim/fonts/install.sh
fi

echo "
Set up is mostly complete! To finish up:

1. Pick the terminal theme you'd like and set it as default.
2. Turn off marks in terminal: View > Hide Marks.
3. Remember to generate and add ssh keys: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
"

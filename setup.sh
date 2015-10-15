#!/bin/sh

cd `dirname $0`
F=`pwd |sed -e "s#$HOME/\?##"`

for P in *
do
  # skip gitignore file
  if [[ "$P" == .gitignore ]]; then continue; fi

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

# install macvim
brew install macvim --with-cscope --with-luajit

# install neobundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# install powerline fonts
git clone git@github.com:powerline/fonts.git ~/powerline-fonts && ~/powerline-fonts/install.sh

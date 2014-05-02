cd ~

git clone git@github.com:Gonzih/dotfiles.git
mv ~/dotfiles/* -t ~/ -f
mv ~/dotfiles/.* -t ~/ -f
rm ~/dotfiles -rf
git reset --hard

git clone git@github.com:Gonzih/.vim.git ~/.vim
git clone git@github.com:Gonzih/.mc.git ~/.config/mc
git clone git@github.com:Gonzih/.fish.git ~/.config/fish
git clone git@github.com:Gonzih/.xmonad.git ~/.xmonad
git clone git@github.com:Gonzih/.mutt.git ~/.mutt

sh ~/.vim/init.sh
sh ~/.mutt/init.sh

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

vim -c "execute 'BundleInstall!' | q | q"

fish

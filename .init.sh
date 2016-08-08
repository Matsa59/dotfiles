cd ~

git clone git@github.com:Gonzih/dotfiles.git
mv ~/dotfiles/* -t ~/ -f
mv ~/dotfiles/.* -t ~/ -f
rm ~/dotfiles -rf
git reset --hard

sudo ansible-playbook provision.yml

sh ~/.vim/init.sh
# sh ~/.mutt/init.sh

cd ~/.vim/bundle/vimproc.vim && make && cd
vim +NeoBundleInstall +qall

fish

echo -n "input where you clone zsh repository: "
read _dir

cd $_dir
mkdir -p plugins/bd
mkdir -p completion
wget -O $_dir/completion/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
wget -O $_dir/completion/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
wget -O $_dir/plugins/bd/bd.zsh https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh
cd ~
ln -s $_dir/.zshrc .zshrc


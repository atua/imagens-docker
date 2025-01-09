#!/bin/bash


COMPLETION="/usr/share/git-core/contrib/completion"

mkdir -p $COMPLETION
cd $COMPLETION

wget -nc https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
wget -nc https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh

chmod +r git-completion.bash git-prompt.sh


BASHRC="/root/.bashrc"

echo "source $COMPLETION/git-completion.bash" >> $BASHRC
echo "export GIT_PROMPT_ONLY_IN_REPO=1" >> $BASHRC
echo "export GIT_PS1_SHOWDIRTYSTATE=1" >> $BASHRC
echo "export GIT_PS1_SHOWSTATHSTATE=1" >> $BASHRC
echo "export GIT_PS1_SHOWUNTRACKEDFILES=1" >> $BASHRC
echo "export GIT_PS1_SHOWUPSTREAM=\"auto\"" >> $BASHRC
echo "export GIT_PS1_SHOWCOLORHINTS=1" >> $BASHRC
echo "source $COMPLETION/git-prompt.sh" >> $BASHRC
echo "export PS1=\"\\\$(__git_ps1 '[%s]')\$PS1\"" >> $BASHRC

git config --global safe.directory '*'

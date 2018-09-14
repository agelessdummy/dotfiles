alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias dotclone='alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME" && echo ".dotfiles.git" >> .gitignore && /usr/bin/git --bare https://github.com/agelessdummy/dotfiles.git --work-tree=$HOME && /usr/bin/git checkout --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME && /usr/bin/git config --local status.showUntrackedFiles no --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias dotcommit="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME commit -m"
alias dotrm="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME rm"
alias dotadd="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME add"
alias dotupdate="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME add -u"
alias dotpush="dotfiles push -u origin master"

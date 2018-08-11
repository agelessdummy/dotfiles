
# Debian and Ubuntu Systems
#alias update="sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get autoremove && sudo apt-get autoclean"
alias dupdate="sudo apt-get update && sudo apt-get -y upgrade && sudo apt autoremove"
alias apt-get="sudo apt-get"
alias dpkg="sudo dpkg"
#alias store="dpkg --get-selections > ~/.dotfiles/backups/packages.list"
#alias restore="dpkg --get-selections < ~/.dotfiles/backups/packages.list && sudo apt-get -y update && sudo apt-get dselect-upgrade"
#alias restore="apt-get install -y $(cat  ~/.dotfiles/backups/package.list | awk '{print $1}')"

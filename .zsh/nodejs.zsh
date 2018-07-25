#█▓▒░ node version manager
#source ~/.nvm/nvm.sh

# NPM packages in homedir
NPM_PACKAGES="$HOME/.npm-packages"

# Tell our environment about user-installed node tools
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Tell Node about these packages
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

#█▓▒░ aliases
alias node="sudo node"
alias npm="sudo npm"
alias npminstall="sudo rm -rf node_modules && sudo npm cache clear && sudo npm cache clean && npm install"
# alias npminstall="sudo rm -rf node_modules && sudo npm cache clear && sudo npm cache clean && sudo PYTHON=/usr/bin/python2 npm install"

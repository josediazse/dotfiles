#!/bin/bash

# Update pkg lists
echo "Updating package lists..."
# sudo apt-get update

# zsh install
which zsh > /dev/null 2>&1
if [[ $? -eq 0 ]] ; then
echo ''
echo "zsh already installed..."
else
echo "zsh not found, now installing zsh..."
echo ''
sudo apt install zsh -y
fi

# Installing git completion
echo ''
echo "Installing git and bash-completion"
sudo apt-get install git bash-completion -y

echo ''
echo "Configuring git-completion..."
GIT_VERSION=`git --version | awk '{print $3}'`
URL="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
echo ''
echo "Downloading git-completion for git version: $GIT_VERSION..."
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
  echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
fi

# oh-my-zsh install
if [ -d ~/.oh-my-zsh/ ] ; then
echo ''
echo "oh-my-zsh is already installed..."
read -p "Would you like to update oh-my-zsh now?" -n 1 -r
echo ''
  if [[ $REPLY =~ ^[Yy]$ ]] ; then
  cd ~/.oh-my-zsh && git pull
    if [[ $? -eq 0 ]]
    then
      echo "Update complete..." && cd
    else
      echo "Update not complete..." >&2 cd
    fi
  fi
else
echo "oh-my-zsh not found, installing oh-my-zsh..."
echo ""
echo ''
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# powerlevel9k install
echo ''
echo "Installing powerlevel9k..."
echo ''
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Helpful notes
echo "NOTES:"
echo "Set zsh as your default shell chsh -s $(which zsh)"
echo "HyperT go to .hyper.js and set shell: 'C:\\Windows\\System32\\wsl.exe', shellArgs: ['~'],"
echo "Remember to download the appropriate fonts, install them on Windows and update the .hyper.js file"
echo "VS Code 'terminal.integrated.shell.window': 'C:\\Windows\\sysnative\\wsl.exe'"
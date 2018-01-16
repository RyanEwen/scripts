#!/bin/bash

set -e

if [ $SUDO_USER ]; then
  echo "Error: Do not run this with sudo!"
  exit 1
fi

# Install Git if needed
if [ -z "$(which git)" ]; then
    sudo apt-get update
    sudo apt-get install -y git
fi

# Setup Git if needed
if [ -z "$(git config --global user.name)" ] || [ -z "$(git config --global user.email)" ]; then
  echo "Setting up Git..."
  read -p "Enter your full name (e.g. John Doe): " git_username
  read -p "Enter your Evertz email address (e.g. johndoe@evertz.com): " git_email
  git config --global user.name "$git_username"
  git config --global user.email $git_email
  echo
fi

# Install Docker if needed
if [ -z "$(which docker)" ]; then
  echo "Installing latest version of Docker..."
  curl -sSL https://get.docker.com | sudo bash
  sudo usermod -aG docker $USER
  echo
fi

# Install docker-compose if needed
if [ -z "$(which docker-compose)" ]; then
  echo "Installing latest version of docker-compose..."
  COMPOSE_VER=$(curl -s -o /dev/null -I -w "%{redirect_url}\n" https://github.com/docker/compose/releases/latest | grep -oP "[0-9]+(\.[0-9]+)+$")
  sudo curl -o /usr/local/bin/docker-compose -L http://github.com/docker/compose/releases/download/$COMPOSE_VER/docker-compose-$(uname -s)-$(uname -m)
  sudo chmod +x /usr/local/bin/docker-compose
  echo
  echo "Installing latest version of docker-compose TAB completion for BASH..."
  sudo curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
  echo
fi

# Create SSH key if needed
if [ ! -f $HOME/.ssh/id_rsa ]; then
  echo "Creating an SSH key to use with Github etc..."
  ssh-keygen -N '' -f $HOME/.ssh/id_rsa > /dev/null
  echo "Public key:"
  cat $HOME/.ssh/id_rsa.pub
  echo "Please copy your public key from the line above (ssh-rsa ...) into your Github account:"
  echo "https://github.com/settings/keys"
  echo
  read -p "Press enter to continue"
  echo
fi

echo "Done!"

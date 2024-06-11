#!/bin/bash
export TERM=xterm
export DEBIAN_FRONTEND=noninteractive
current_user=$(whoami)
echo "Current user is: $current_user"

# Update package lists and install required packages
sudo apt-get update && sudo apt-get install -y \
autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev \
postgresql postgresql-client postgresql-contrib libpq-dev

# Install Ruby 2.6.6 using apt
if ! ruby -v | grep -q "2.6.6"; then
    echo "Installing Ruby 2.6.6"
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository -y ppa:brightbox/ruby-ng
    sudo apt-get update
    sudo apt-get install -y ruby2.6 ruby2.6-dev
else
    echo "Ruby 2.6.6 is already installed"
fi

# Update alternatives to use Ruby 2.6.6
sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.6 1
sudo update-alternatives --set ruby /usr/bin/ruby2.6

# Install Bundler 2.0.1
if ! gem list bundler -i -v 2.0.1 > /dev/null 2>&1; then
    echo "Installing Bundler 2.0.1"
    sudo gem install bundler -v 2.0.1
else
    echo "Bundler 2.0.1 is already installed"
fi


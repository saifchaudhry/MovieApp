#!/bin/bash
export TERM=xterm
export DEBIAN_FRONTEND=noninteractive
current_user=$(whoami)
echo "Current user is: $current_user"

# Check if rbenv is installed
if [ ! -d "$HOME/.rbenv" ]; then
    sudo apt-get update && sudo apt-get install -y \
    autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev \
    postgresql postgresql-client postgresql-contrib libpq-dev nodejs
    
    # Install rbenv and ruby-build
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
else
    echo "rbenv is already installed"
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Install Ruby 2.6.6
if ! rbenv versions | grep -q 2.6.6; then
    echo "Installing Ruby 2.6.6"
    rbenv install 2.6.6
else
    echo "Ruby 2.6.6 is already installed"
fi

# Set global Ruby version
rbenv global 2.6.6

# Install Bundler 2.0.1
if ! gem list bundler -i -v 2.0.1 > /dev/null 2>&1; then
    echo "Installing Bundler 2.0.1"
    gem install bundler -v 2.0.1
else
    echo "Bundler 2.0.1 is already installed"
fi

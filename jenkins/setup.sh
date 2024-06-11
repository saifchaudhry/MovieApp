#!/bin/bash
export TERM=xterm
export DEBIAN_FRONTEND=noninteractive
current_user=$(whoami)
echo "Current user is: $current_user"

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if running as root
if [ "$current_user" != "root" ]; then
    echo "Please run as root or use sudo"
    exit 1
fi

# Install system dependencies
apt-get update && apt-get install -y \
autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev \
postgresql postgresql-client postgresql-contrib libpq-dev git curl

# Check if rbenv is installed
if ! command_exists rbenv; then
    echo "rbenv could not be found, installing..."
    git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv
    cd /usr/local/rbenv && src/configure && make -C src
    echo 'export PATH="/usr/local/rbenv/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
    source /etc/profile.d/rbenv.sh
    git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build
    echo 'export PATH="/usr/local/rbenv/plugins/ruby-build/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    source /etc/profile.d/rbenv.sh
else
    echo "rbenv is already installed"
fi

export PATH="/usr/local/rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Install Ruby 2.6.6
if [ "$(ruby -v | awk '{print $2}' | cut -d 'p' -f 1)" != "2.6.6" ]; then
    echo "Installing Ruby 2.6.6"
    rbenv install 2.6.6
    rbenv global 2.6.6
else
    echo "Ruby 2.6.6 is already installed"
fi

# Install Bundler 2.0.1
if ! gem list bundler -i -v 2.0.1 > /dev/null 2>&1; then
    echo "Installing Bundler 2.0.1"
    gem install bundler -v 2.0.1
else
    echo "Bundler 2.0.1 is already installed"
fi

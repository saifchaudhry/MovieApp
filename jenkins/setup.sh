#!/bin/bash
export TERM=xterm
export DEBIAN_FRONTEND=noninteractive
current_user=$(whoami)
echo "Current user is: $current_user"

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
export PATH=$(echo $PATH | awk -v RS=: -v ORS=: '!($0 in seen) {seen[$0]; print}')
source ~/.bashrc

apt-get update && apt-get install -y \
autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev \
postgresql postgresql-client postgresql-contrib libpq-dev

if  [ "$(ruby -v | awk '{print $2}' | cut -d 'p' -f 1)" == "3.1.0" ]; then
    echo "Ruby 3.1.0 is installed"
else
    echo "Ruby 3.1.0 not found!"
    rbenv install 3.1.0
    rbenv global 3.1.0
fi

if gem list bundler -i -v 2.0.1 > /dev/null 2>&1; then
    echo "Bundler 2.0.1 is installed"
else
    echo "Bundler 2.0.1 not found!"
    gem install bundler -v 2.0.1
fi

bundle install

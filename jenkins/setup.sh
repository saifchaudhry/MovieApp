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

if  [ "$(ruby -v | awk '{print $2}' | cut -d 'p' -f 1)" == "2.6.6" ]; then
    echo "Ruby 2.6.6 is installed"
else
    echo "Ruby 2.6.6 not found!"
    rbenv install 2.6.6
    rbenv global 2.6.6
fi

if gem list bundler -i -v 2.5.11 > /dev/null 2>&1; then
    echo "Bundler 2.5.11 is installed"
else
    echo "Bundler 2.5.11 not found!"
    gem install bundler -v 2.5.11
fi

bundle install

#!/bin/bash
export TERM=xterm
export DEBIAN_FRONTEND=noninteractive
current_user=$(whoami)
echo "Current user is: $current_user"

# Check if rbenv is installed
if ! command -v rbenv &> /dev/null
then
    echo "rbenv could not be found, installing..."
    sudo apt-get update && sudo apt-get install -y \
    git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
    libcurl4-openssl-dev libffi-dev postgresql-client-common postgresql-client libpq-dev 
    
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

# Verify PostgreSQL libraries and headers are installed
if ! dpkg -s libpq-dev > /dev/null 2>&1; then
    echo "libpq-dev is not installed. Installing..."
    sudo apt-get install -y libpq-dev
else
    echo "libpq-dev is already installed"
fi

# Ensure PostgreSQL client is installed correctly
if ! command -v pg_config &> /dev/null; then
    echo "pg_config could not be found. Installing PostgreSQL client..."
    sudo apt-get install -y postgresql-client
else
    echo "pg_config is available"
fi

# Export PostgreSQL binary path
export PATH="/usr/lib/postgresql/12/bin:$PATH"

# Check pg_config path
echo "pg_config path: $(which pg_config)"

# Display current environment variables for debugging
echo "Environment variables:"
printenv

# Install pg gem
if ! gem list pg -i -v '1.5.6' > /dev/null 2>&1; then
    echo "Installing pg gem version 1.5.6"
    gem install pg -v '1.5.6' -- --with-pg-config=$(which pg_config)
else
    echo "pg gem version 1.5.6 is already installed"
fi

# Ensure PostgreSQL service is running (optional if you need the server running)
if ! sudo service postgresql status > /dev/null 2>&1; then
    echo "Starting PostgreSQL service..."
    sudo service postgresql start
else
    echo "PostgreSQL service is already running"
fi


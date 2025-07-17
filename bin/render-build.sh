#!/usr/bin/env bash
# bin/render-build.sh

# Exit on error and show commands
set -ex

# Install specific Node.js version
if [ ! -d "$HOME/.nvm/versions/node/v16.20.2" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install 16.20.2
  nvm use 16.20.2
fi

# Install dependencies
bundle config set without 'development test'
bundle install --jobs 4 --retry 3
yarn install --ignore-engines --frozen-lockfile

# Precompile assets
RAILS_ENV=production NODE_ENV=production NODE_OPTIONS=--openssl-legacy-provider bundle exec rails assets:precompile

# Clean old assets (keep last 2 versions)
bundle exec rails assets:clean[2]

# Verify compilation
if [ ! -f public/assets/.sprockets-manifest-*.json ]; then
  echo "ERROR: Asset compilation failed!"
  exit 1
fi

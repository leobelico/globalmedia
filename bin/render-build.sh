#!/usr/bin/env bash
# bin/render-build.sh

# Exit immediately if any command fails
set -o errexit

# Install Node.js 16.20.2 if not present
if [ ! -d "$HOME/.nvm/versions/node/v16.20.2" ]; then
  echo "Installing Node.js 16.20.2..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install 16.20.2
  nvm use 16.20.2
fi

# Install Ruby dependencies
echo "Installing Ruby gems..."
bundle install

# Install JavaScript dependencies
echo "Installing Yarn packages..."
yarn install --ignore-engines

# Precompile assets
echo "Precompiling assets..."
RAILS_ENV=production NODE_ENV=production bundle exec rails assets:precompile

# Verify assets were compiled
if [ ! -f "public/assets/.sprockets-manifest-*.json" ]; then
  echo "Error: Assets failed to precompile!"
  exit 1
fi

echo "Build completed successfully!"

#!/usr/bin/env bash
set -ex

# Instala Node.js 16.x con NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16.20.2
nvm use 16.20.2

# Instala dependencias de Ruby y JS
bundle install
yarn install --ignore-engines

# Precompila assets
echo "⚙️ Precompilando assets..."
RAILS_ENV=production bundle exec rails assets:precompile

# Verifica que se haya generado el manifest
if [ ! -f public/assets/manifest.json ]; then
  echo "❌ Error: Asset compilation failed!"
  exit 1
fi

echo "✅ Build terminado correctamente."

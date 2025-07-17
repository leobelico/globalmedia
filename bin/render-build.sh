# Modifica tu render-build.sh para usar esta versión:
#!/usr/bin/env bash
set -ex

# Configura Node.js 16.x (compatible con Webpacker 5)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16.20.2
nvm use 16.20.2

# Instala dependencias
bundle install
yarn install --ignore-engines

# Precompila assets (sin NODE_OPTIONS que causan conflicto)
RAILS_ENV=production bundle exec rails assets:precompile

# Verifica la compilación
if [ ! -f public/assets/manifest.json ]; then
  echo "Error: Asset compilation failed!"
  exit 1
fi
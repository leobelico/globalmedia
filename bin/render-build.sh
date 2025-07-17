#!/usr/bin/env bash
set -ex

# Instala Node.js 16.x con NVM (Webpacker 5 requiere Node <= 16)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16.20.2
nvm use 16.20.2

# Instala dependencias Ruby y JS
bundle install
yarn install --ignore-engines

# Precompila assets solo si no existen ya
if [ -f public/assets/manifest.json ]; then
  echo "✅ Assets ya precompilados. No se compilan de nuevo."
else
  echo "⚙️ Compilando assets en producción..."
  RAILS_ENV=production bundle exec rails assets:precompile
fi

echo "✅ Build completo"

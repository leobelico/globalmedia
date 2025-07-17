#!/usr/bin/env bash
set -ex

# Instala Node.js 16.x (requerido por Webpacker 5)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16.20.2
nvm use 16.20.2

# Instala dependencias
bundle install
yarn install --ignore-engines

# Prueba si Logger funciona en Ruby
ruby test_logger.rb

# Usa los assets precompilados si ya existen
if [ -f public/assets/manifest.json ]; then
  echo "✅ Assets ya precompilados. No se compilan de nuevo."
else
  echo "⚠️ No se encontraron assets. Ejecutando precompilación..."
  RAILS_ENV=production ruby -r logger -S bundle exec rails assets:precompile

fi

echo "✅ Build finalizado"

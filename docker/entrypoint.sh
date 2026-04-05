#!/bin/sh

set -e

# 1. Roda o entrypoint original em background (copia arquivos, cria wp-config.php)
docker-entrypoint.sh php-fpm &
PID=$!

# 2. Espera o wp-config.php existir
while [ ! -f /var/www/html/wp-config.php ]; do
  sleep 1
done

# 3. Instala o WordPress só se ainda não foi instalado
if ! wp core is-installed --allow-root; then
  wp core install \
    --title="The Website" \
    --admin_user="user" \
    --admin_password="password" \
    --admin_email="email@email.com" \
    --url="localhost" \
    --skip-email \
    --allow-root
fi

# Generate the plugin files
wp scaffold plugin $PLUGIN_SLUG --allow-root --force

cd wp-content/plugins/$PLUGIN_SLUG

# Install composer dependencies
composer require --dev phpunit/phpunit ^9.6
composer install

# 4. Traz o php-fpm pra frente
wait $PID
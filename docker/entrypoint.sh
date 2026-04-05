#!/bin/sh

set -e


# 1. Roda o entrypoint original em background (copia arquivos, cria wp-config.php)
docker-entrypoint.sh php-fpm &
PID=$!

# 2. Espera o wp-config.php existir
while [ ! -f /var/www/html/wp-config.php ]; do
  sleep 1
done

bash /install-wp-tests.sh wordpress_test root 'wordpress' mysql latest

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

composer config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true

composer require --dev phpunit/phpunit:^9.6 --no-install
composer require --dev yoast/phpunit-polyfills:^2.0 --no-install
composer require --dev squizlabs/php_codesniffer:^3.7 --no-install
composer require --dev wp-coding-standards/wpcs:^3.0 --no-install
composer require --dev phpcompatibility/phpcompatibility-wp:^2.1 --no-install

# 4. Traz o php-fpm pra frente
wait $PID
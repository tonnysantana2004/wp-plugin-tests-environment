#!/bin/sh

set -e

echo ---------------------------------
printf "\033[44m\033[1m Starting the wordpress instalation... \033[0m\n"
echo ---------------------------------

sleep 2

docker-entrypoint.sh php-fpm &
PID=$!

while [ ! -f /var/www/html/wp-config.php ]; do
  sleep 1
done

echo ---------------------------------
printf "\033[44m\033[1m Installing the wordpress test environment... \033[0m\n"
echo ---------------------------------

sleep 2

bash /install-wp-tests.sh wordpress_test root 'wordpress' mysql latest

sleep 2

if ! wp core is-installed --allow-root; then
  
  echo ---------------------------------
  printf "\033[44m\033[1m Setting up the wordpress credentials... \033[0m\n"
  echo ---------------------------------

  wp core install \
    --title="The Website" \
    --admin_user="user" \
    --admin_password="password" \
    --admin_email="email@email.com" \
    --url="localhost" \
    --skip-email \
    --allow-root
fi

echo ---------------------------------
printf "\033[44m\033[1m Generating the plugin files! \033[0m\n"
echo ---------------------------------

sleep 2

if ! wp plugin is-installed $PLUGIN_SLUG --allow-root; then
  wp scaffold plugin $PLUGIN_SLUG --allow-root
fi
cd wp-content/plugins/$PLUGIN_SLUG

composer config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true

composer require --dev phpunit/phpunit:^9.6 --no-install
composer require --dev yoast/phpunit-polyfills:^2.0 --no-install
composer require --dev squizlabs/php_codesniffer:^3.7 --no-install
composer require --dev wp-coding-standards/wpcs:^3.0 --no-install
composer require --dev phpcompatibility/phpcompatibility-wp:^2.1 --no-install

echo ---------------------------------
printf "\033[42m\033[1m Instalation complete. Keep going! \033[0m\n"
echo ---------------------------------

wait $PID
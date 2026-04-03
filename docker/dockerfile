# This image will be responsible for creating the 2 Environments:

# - A fresh instalation with the files on the path above.
# - A copy from the first one, where we will load the php unit tests.

# Parent image
FROM wordpress:php8.2-fpm-alpine

# Installing dependencies
RUN apk add --no-cache subversion mysql-client

# Installing phpunit
RUN wget -O phpunit https://phar.phpunit.de/phpunit-11.phar&& \
    chmod +x phpunit && \
    mv phpunit /usr/local/bin/phpunit

# Copy shell script
COPY install-wp-tests.sh /install-wp-tests.sh

# Generate tests dependencies
# @todo use env to the parameters
RUN bash /install-wp-tests.sh wordpress wordpress 'wordpress' mysql latest true
# Testing Environment for Wordpress plugins.

A complete environment for wordpress plugins development using Docker and PHPUnit.

## Getting Started

#### Open the termninal Clone this repository
```
git clone git@github.com:tonnysantana2004/wp-plugin-testing-environment.git
```

#### Navigate to the folder "Docker"
```
cd docker
```

#### Open the .env file and change the plugin slug to the one that you want

```
PLUGIN_SLUG=my-plugin
```

#### Start the dev environment runnig the docker compose on the terminal

```
docker compose up
```
This will create two folders, which are the docker volums for the wordpress and database instalation.

Futhermore, it will excecute the script responsible for generating the wordpress testing environment with phpunit.

#### Once the wordpress container is ready, enter the container bash 

#### Install the plugin core dependencies
```
composer install 
```
Follow the cli instructions to ensure that everything was installed correctly.

## How to use

#### Use the following commands to test your code:
```
vendor/bin/phpcs
vendor/bin/phpunit
```

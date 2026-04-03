# Testing Environment for Wordpress plugins

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
1. PLUGIN_SLUG=my-plugin
```

#### Start the dev environment runnig the docker compose on the terminal

```
docker compose up
```

#### Once the wordpress container is ready, enter the container bash 

```
docker-compose exec -it wordpress bash
```

#### Generate the plugin files, changing "my-plugin" to your plugin slug

```
wp scaffold plugin my-plugin --allow-root
```
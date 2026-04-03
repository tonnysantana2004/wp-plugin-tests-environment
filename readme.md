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

```
docker-compose exec -it wordpress bash
```

#### Generate the plugin files, changing "my-plugin" to your plugin slug

```
wp scaffold plugin my-plugin --allow-root
```
follow the steps requesteds by the cli.

#### Navigate to the plugin created folder
```
cd wp-content/plugins/my-plugin# 
```

#### Open the file "composer.json" and add change the dev dependencies to the following ones:
```
"require-dev": {
    "phpunit/phpunit": "^9.6",
    "yoast/phpunit-polyfills": "^2.0",
    "wp-coding-standards/wpcs": "3.0",
    "phpcompatibility/phpcompatibility-wp": "^2.1"
  },
```

#### Install the plugin core dependencies
```
composer install -W
```
Follow the cli instructions to ensure that everything was installed correctly.

#### Open the file phpunit.xml.dist, and change the field testsuites to this:
```
<testsuites>
	<testsuite name="testing">
		<directory suffix="Test.php">./tests/</directory>
	</testsuite>
</testsuites>
```

#### Inside the folder "/tests", on the file test-sample.php, change the file name to "SampleTest.php". And also the class name from TestSample to SampleTest.
```
/tests/SampleTest.php*

<?php
/**
 * Class SampleTest
 *
 * @package My_Plugin
 */

/**
 * Sample test case.
 */
class SampleTest extends WP_UnitTestCase {

	/**
	 * A single example test.
	 */
	public function test_sample() {
		// Replace this with some actual testing code.
		$this->assertTrue( true );
	}
}

```
#### Try running on the terminal the command "phpunit", If it causes an error about the  PHPUnit Polyfills Library, you need to add this code on the top of the tests/bootstrap.php file:

```
// ========= Remove this

// Forward custom PHPUnit Polyfills configuration to PHPUnit bootstrap file.
$_phpunit_polyfills_path = getenv( 'WP_TESTS_PHPUNIT_POLYFILLS_PATH' );
if ( false !== $_phpunit_polyfills_path ) {
	define( 'WP_TESTS_PHPUNIT_POLYFILLS_PATH', $_phpunit_polyfills_path );
}

// ========= Add the following

$_phpunit_polyfills_path = getenv( 'WP_TESTS_PHPUNIT_POLYFILLS_PATH' );

if ( $_phpunit_polyfills_path === true  ) {
	define( 'WP_TESTS_PHPUNIT_POLYFILLS_PATH', $_phpunit_polyfills_path );
}else {
 	define( 'WP_TESTS_PHPUNIT_POLYFILLS_PATH', dirname( __FILE__ ) . '/../vendor/yoast/phpunit-polyfills/' );
}

```

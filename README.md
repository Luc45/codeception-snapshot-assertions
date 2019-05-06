# Codeception Snapshot Assertions
Leverage Codeception snapshot support to make snapshot testing in Codeception projects easier.

## Code example
```php
<?php
class WidgetTest extends Codeception\TestCase\Test
{
    use tad\Codeception\SnapshotAssertions\SnapshotAssertions;
    public function testDefaultContent(){
        $widget = new Widget() ;

        $this->assertMatchesHtmlSnapshot($widget->html());
    }
    
    public function testOutput(){
       $widget = new Widget(['title' => 'Test Widget', 'content' => 'Some test content']) ;

       $this->assertMatchesHtmlSnapshot($widget->html());
    }
}
```

## Requirements
The package is based on the snapshot support added in Codeception since version `2.5.0`, as such the library requirments are:
* PHP 5.6+
* Codeception 2.5+

## Installation
Install the package using [Composer](https://getcomposer.org/):
```bash
composer install lucatume/codeception-snapshot-assertions
``` 
Codeception is a requirement for the package to work and will be installed as a dependency if not specified in the project Composer configuration file (`composer.json`).

## What is snapshot testing?
Snapshot testing is a convenient way to test code by testing its output.  
Snapshot testing is faster than full-blown visual end-to-end testing (and not a replacement for it) but less cumbersome to write than lower lever unit testing (and, again, not a replacement for it).  
This kind of testing lends itself to be used in unit and integration testing to automate the testing of output.  
Read more about snapshot testing here: 
* [Sitepoint article about snapshot testing](https://www.sitepoint.com/snapshot-testing-viable-php/)
* [Snapshot testing package from Spatie](https://hackernoon.com/a-package-for-snapshot-testing-in-phpunit-2e4558c07fe3); and the corresponding [GitHub repository](https://github.com/spatie/phpunit-snapshot-assertions).
* [Codeception introduction of snapshot testing](https://codeception.com/09-24-2018/codeception-2.5.html)

### How is this different from what Codeception does?
First of all snapshots do not require writing a class dedicated to it, you can just `use` the `tad\Codeception\SnapshotAssertions\SnapshotAssertions` trait in your test case and one of the `assertMatches...` methods it provides.  
Secondly it supports string and HTML snapshot testing too.

### How is this different from what the Spatie package does?
It leverages Codeception own snapshot implementation, hence it **not** work on vanilla [PhpUnit](https://phpunit.de/ "PHPUnit – The PHP Testing Framework"), and lowers the library requirement from PHP 7.0 to PHP 5.6.

## Usage
The package supports the following type of assertions:
1. string snapshot assertions, to compare a string to a string snapshot with the `assertMatchesStringSnapshot` method.
2. HTML snapshot assertions, to compare an HTML fragment to an HTML fragment snapshot  with the `assertMatchesHtmlSnapshot` method.
3. JSON snapshot assertions, to compare a JSON string to a stored JSON snapshot with the `assertMatchesJsonSnapshot` method.

The first time an `assert...` method is called the library will generate a snapshot file in the same directory as the tests, in the `__snapshots__` folder.  
As an example if the following test case lives in the `tests/Output/WidgetTest.php` file then when the `testDefaultContent` method runs the library will generate the `tests/Output/WidgetTest__testDefaultContent__0.snapshot.html`  file; you can regenerate failing snapshots by running Codeception tests in debug mode (using the `--debug` flag of the `run` command).

### String assertions
This kind of assertion is useful when the output of a method is a plain string.  
The snapshot produced by this kind of assertion will have the `.snapshot.txt` file extension.  
Usage example;

```php
<?php
class ErrorMessageTest extends Codeception\TestCase\Test
{
    use tad\Codeception\SnapshotAssertions\SnapshotAssertions;
    
    public function testClassAndMethodOutput(){
        $errorMessage = new ErrorMessage(__CLASS__, 'foo') ;

        $this->assertMatchesStringSnapshot($errorMessage->message());
    }
    
    public function testClassOnlyOutput(){
        $errorMessage = new ErrorMessage(__CLASS__) ;

        $this->assertMatchesStringSnapshot($errorMessage->message());
    }
}
```

### HTML assertions
This kind of assertion is useful when the output of a method is an HTML document or HTML fragment.  
The snapshot produced by this kind of assertion will have the `.snapshot.html` file extension.  
Usage example;

```php
<?php
class WidgetTest extends Codeception\TestCase\Test
{
    use tad\Codeception\SnapshotAssertions\SnapshotAssertions;
    
    public function testDefaultContent(){
        $widget = new Widget() ;

        $this->assertMatchesHtmlSnapshot($widget->html());
    }
    
    public function testOutput(){
       $widget = new Widget(['title' => 'Test Widget', 'content' => 'Some test content']) ;

       $this->assertMatchesHtmlSnapshot($widget->html());
    }
}
```

### JSON assertions
This kind of assertion is useful when the output of a method is a JSON string.  
The snapshot produced by this kind of assertion will have the `.snapshot.html` file extension.  
The method used to make JSON snapshot assertions is ````
Usage example;

```php
<?php
class ApiTest extends Codeception\TestCase\Test
{
    use tad\Codeception\SnapshotAssertions\SnapshotAssertions;
    
    public function testGoodResponse(){
        $this->givenTheUserIsAuthenticated();
        $request = new Request([
            'me' => [
                'name'   
            ]
        ]);
        
        $api = new API() ;

        $this->assertMatchesJsonSnapshot($api->handle($request));
    }

    public function testMissingAuthResponse(){
        $request = new Request([
            'me' => [
                'name'   
            ]
        ]);
        
        $api = new API() ;

        $this->assertMatchesJsonSnapshot($api->handle($request));
    }
}
```

# Regression Framework Suite

## Quick Start
* Install Firefox
* Install Git
* Pull down the repository to your local computer (git clone)
* Get ruby setup.  
	* Windows: http://railsinstaller.org/en
	* OSX: http://rvm.io/rvm/install
* `gem install bundler` if bundler is not already installed
* `bundle` to install required gems.  (You need to run this whenever pulling down this repo with new changes)
* `rspec spec/signup_spec.rb` to run a single test and verify it's working
* `rspec` to run all tests.

## Download and Install ChromeDriver
* You will need to put ChromeDriver in your PATH
	* [Download ChromeDriver](http://chromedriver.storage.googleapis.com/index.html) (choose the latest version)
	* Extract it to some directory, e.g., c:\utils\chromedriver
	* Now go put c:\utils\chromedriver in the PATH (start : edit environment variables for your account : edit the 'Path' variable and append that directory to it)

## Frameworks

#### Page-Object

We're using the [page-object](https://github.com/cheezy/page-object) gem to wrap around watir-webdriver.  You can always drop down and use the watir browser object, but page-object provides some nice abstractions.

* [Elements](https://github.com/cheezy/page-object/wiki/Elements)
* [Simple DSL](https://github.com/cheezy/page-object/wiki/Simple-DSL)
* [Ajax Calls](https://github.com/cheezy/page-object/wiki/Ajax-Calls)

#### jqueryui_widgets

The Page-Object gem creator has created a widget for [jqueryui elements](https://github.com/cheezy/jqueryui_widgets/tree/master/lib/jqueryui_widgets). There is no clear documentation but there are good examples.

#### faker
The [faker](https://github.com/stympy/faker) can be used to generate random fake data within tests.

#### RSpec

* [RSpec Expecations syntax](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)

## Writing Tests

#### Structure
* **lib/pages** contains objects that represent a page in ops.  Example: home_page.rb maps to the home page in EZ Contactor.
* **spec/** contains the tests

#### Rules
1. A given lib/pages/whatever_page.rb file should map to a single web page.
1. Test in watir the absolute minimum that's required since these tests are slow and more brittle than hitting the database directly.
 
#### Things to consider when writing tests
1. We've run into several scenarios where workflows are very similar or an abstraction could be made. We decided simplicity, readability, and accessibility are more valuable than conciseness in many cases. If you have a series of tests with a bunch of if conditions trying to determine what state the tests need to run, it's probably better to duplicate that test for each mode. 

## Run tests in Docker container
```bash
$ docker run -v /local/rspec/directory/:/specs image-name
```

This mounts the directory at `/local/rspec/directory` on the docker host to the
`/specs` directory in the docker container. Note that the host directory must be
the full path.


## Selenium Grid

- Install [Docker Compose](https://docs.docker.com/compose/install/)

- Install `parallel_tests` gem

- Start selenium grid. Omit the -d flag if you want to see the output of the
individual browser nodes. This can be helpful for debugging and verifying
that tests are being distributed correctly.

```bash
docker-compose -d up
```


- Scale firefox or chrome nodes

```bash
docker-compose scale \
	firefox=num_of_nodes \
	chrome=num_of_nodes
```

- Initialize your Watir script with a remote browser. The URL is the
location of the Selenium grid. The Selenium grid will handle
distributing tests to individual nodes.

```ruby
browser = Watir::Browser.new(
	:remote,
	:url => "http://localhost:4444/wd/hub"
)
```


- Run tests in parallel

```bash
parallel_rspec -n num_of_threads spec
```

## Overview

Basic skeleton Cucumber framework written in Ruby


## Getting Started

### Install Ruby 

Install Ruby and Gem (This has been tested with version 2.4.x of MRI Ruby) using the 
appropriate packages for your operating system

Install bundler locally using the following command

```
gem install --user-install bundler
```

Ensure that the local gem bin location is in your path, for example on UNIX/Linux/Mac

```
export PATH=$PATH:$HOME/.gem/ruby/2.4.0/bin
```

Or on Windows

```
set PATH=%PATH%;%HOME%\.gem\ruby\2.0.0\bin
```

### Install Any Gems

Since all required gems are listed in the Gemfile they can be loaded with the bundler by running the following command

```
bundle install --path ~/.gem
```

You should get an output like this

```
Using rake 12.0.0
Using public_suffix 2.0.5
Using builder 3.2.3
Using mime-types-data 3.2016.0521
Using mini_portile2 2.1.0
Using rack 2.0.1
Using ffi 1.9.18
Using gherkin 4.0.0
Using cucumber-wire 0.0.1
Using diff-lcs 1.3
Using multi_json 1.12.1
Using multi_test 0.1.2
Using hashie 3.5.5
Using jsonschema 2.0.2
Using rspec-support 3.5.0
Using rubyzip 1.2.1
Using websocket 1.2.4
Using bundler 1.14.6
Using addressable 2.5.0
Using mime-types 3.1
Using nokogiri 1.7.0.1
Using rack-test 0.6.3
Using childprocess 0.6.2
Using cucumber-core 1.5.0
Using rspec-expectations 3.5.0
Using xpath 2.0.0
Using selenium-webdriver 3.3.0
Using cucumber 2.4.0
Using capybara 2.12.1
Bundle complete! 8 Gemfile dependencies, 29 gems now installed.
Bundled gems are installed into /Users/angua/.gem.
```

For any subsequent updates you can simply run the command as follows since the previous one caches the install location

```
bundle install
```


### Run the Tests

Run the tests using the following command

```
rake test
```
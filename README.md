# BetterRobots - Better SEO with robots.txt
[![Build Status](https://travis-ci.org/gerrypower/better_robots.png?branch=master)](https://travis-ci.org/gerrypower/better_robots)
[![Code Climate](https://codeclimate.com/github/gerrypower/better_robots.png)](https://codeclimate.com/github/gerrypower/better_robots)

BetterRobots is designed to SEO enhance your robots.txt serving, in particular for situations where
you have multiple domains or subdomains being served from one application. e.g. www.yoursite.com,
assets.yoursite.com, beta.yoursite.com, etc.

## SEO and Your robots.txt

A web application commonly has several subdomains that refer to the same application. For example,
a standard practice to speed browser page load time, is to have multiple asset hosts aliased to your
application, allowing a browser to simultaneously stream multiple assets. In an SEO context, each of
these aliased hosts are considered to be duplicate content. To avoid this, you should have different
robots.txt that exclude search engines for all but your canonical domain.

BetterRobots provides a robots.txt configuration for your conical domain, optional robots.txt for others,
and defaults to disallow for everything that does not have a matching robots.txt.

As a quick example, assume your canonical domain is www.yoursite.com with a subdomain 'assets0' and
'api'. If you rename your robots.txt to www.yoursite.com.robots.txt, the following get requests for
robots.txt will return the following:

    www.yoursite.com/robots.txt -> User-agent: *
                                   Crawl-Delay: 3

    assets0.yoursite.com/robots.txt -> User-agent: *
                                           Disallow: /

    api.yoursite.com/robots.txt -> User-agent: *
                                   Disallow: /


## Installation

Add this line to your application's Gemfile:

    gem 'better_robots'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install better_robots

## Usage

For Rails 3, add a route to config/routes.rb
```ruby
match "/robots.txt" => BetterRobots::Generator
```

For each domain name that you want a robots.txt file served, rename your public/robots.txt to
the *\<fully qualified domain name\>*.robots.txt. e.g. Domain: www.example.org; public/www.example.org.robots.txt
All other domain names will default to:
    User-agent: *
    Disallow: /

## <a name="works_with"></a>Works with:

BetterRobots is a Rack based app, and should work with any Rack compatible framework. It has been tested with
Rails 3.2 and Sinatra 1.3, and on the following Ruby implementations:

* JRuby 1.7.1
* MRI 1.9.2
* MRI 1.9.3
* MRI 2.0.0
* Rubinius 1.2.4
* Ruby EE 1.8.7

### License

better_robots is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Author

* [Gerry Power](https://github.com/gerrypower)




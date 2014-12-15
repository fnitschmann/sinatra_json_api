sinatra_json_api
===============

This app is a little example of an RESTful API with JSON interface built with the Ruby DSL framework [Sinatra](http://www.sinatrarb.com/).
It was created during a project at the Hochschule für Technik und Wirtschaft (HTW) Berlin. 

============================

## Technologies


The app uses different frameworks and technologies to provide the API.

* [DataMapper](http://datamapper.org/) with a small [SQLite3](http://sqlite.org/) database as storage
* [Sinatra](http://www.sinatrarb.com/) framework for the DSL
* [Rake tasks](http://wiki.ruby-portal.de/Rake) for different CLI commands
* [Capistrano](http://capistranorb.com/) for Deployments

============================

## Requirements

* Ruby version ``` 2.1.3 ```

============================

## Installation

1. Install the ` bundler ` Gem with ` gem install bundler `
2. Run ` bundle install ` to install all required Gems
3. Exectute ` rake db:create ` to create the apps' SQLite3 database
4. Execute ` rake app:create:config ` to generate the ` config.yml ` file
5. (optional) Run ` rake app:create:token ` to generate an auth token for the app

============================

## Usage

Check ` app.rb ` for the routes and other details.

To start and test the app locally run ` rackup ` and point your browser to ` http://localhost:9292 `

============================

## License

> Copyright (c) 2014 Florian Nitschmann (s0544677@htw-berlin.de)



 
 
 

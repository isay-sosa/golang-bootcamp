# Golang Bootcamp

`Sinatra` application.

## Ruby version

`Ruby 2.7.2`

## System dependencies

* `Ruby 2.7.2`. It could be installed either via `rbenv` or `rvm`.
* `Bundler` gem. Once `Ruby` is installed, run `gem install bundler`.
* `Sinatra` gem. To install `Sinatra` and the rest of gems, run `bundle install`.

## Run application

This application calls Open Weather API. If you don't have an `API_KEY`, you can use the one sent in the email. 

```bash
$ OPEN_WEATHER_KEY=API_KEY bundle exec rackup -p 4567
```

After running the server, visit `http://localhost:4567`.
`-p` can be changed to any port value.

## How to run the test suite

```bash
$ bundle exec rake test
```

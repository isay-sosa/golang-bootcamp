# frozen_string_literal: true

require_relative 'boot'
require 'sinatra/base'
require_relative '../app/presenters/weather_presenter'

module Bootcamp
  class Application < Sinatra::Application
    set :root, Dir.pwd
    set :views, File.join(root, 'app', 'views')

    configure :production, :development do
      enable :logging
    end

    get '/' do
      erb :'home/index.html', layout: :'layouts/application.html'
    end

    get '/hello-world' do
      @active_item = :hello_world
      erb :'home/show.html', layout: :'layouts/application.html'
    end

    get '/weather' do
      @active_item = :weather
      @weather = ::WeatherPresenter.new
      erb :'weather/show.html', layout: :'layouts/application.html'
    end
  end
end

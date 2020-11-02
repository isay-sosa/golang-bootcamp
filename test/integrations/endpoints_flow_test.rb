# frozen_string_literal: true

require 'minitest/autorun'
require 'webmock/minitest'
require 'rack/test'
require_relative '../../config/application'

class EndpointsFlowTest < MiniTest::Test
  include Rack::Test::Methods

  def setup
    ENV['OPEN_WEATHER_KEY'] = 'test'
    @browser = Rack::Test::Session.new(Rack::MockSession.new(Bootcamp::Application))
  end

  def test_it_says_hello_world_and_weather_api
    @browser.get '/'
    assert @browser.last_response.ok?
    assert_match %r{Hello World}, @browser.last_response.body
    assert_match %r{Weather API}, @browser.last_response.body
  end

  def test_weather_api_endpoint
    stub_request(:get, 'https://api.openweathermap.org/data/2.5/weather?q=Colima&appid=test&units=metric')
      .to_return(body: {
        weather: [
          {
            main: 'Clouds',
            description: 'scattered clouds'
          }
        ],
        main: {
          temp: 20.78,
          feels_like: 24.04,
          temp_min: 20.78,
          temp_max: 20.78,
          pressure: 1013,
          humidity: 98,
          sea_level: 1013,
          grnd_level: 912
        },
        dt: DateTime.now.strftime('%s')
      }.to_json)

    @browser.get '/weather'
    assert_match %r{Weather API - Colima}, @browser.last_response.body
    assert @browser.last_response.ok?
  end
end

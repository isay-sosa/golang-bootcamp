# frozen_string_literal: true

require 'minitest/autorun'
require 'webmock/minitest'
require_relative '../../app/services/weather_service'

class WeatherServiceTest < MiniTest::Test
  def test_issues_a_call_to_open_weather_api
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
        }
      }.to_json)

    refute_empty WeatherService.call('test')
  end

  def test_raise_error_when_api_key_is_not_found
    error = assert_raises(StandardError) { WeatherService.call(nil) }
    assert_equal 'API Key not found', error.message
  end
end

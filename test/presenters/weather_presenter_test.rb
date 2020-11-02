# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../app/presenters/weather_presenter'

class WeatherPresenterTest < MiniTest::Test
  def test_attributes_when_client_response_is_success
    response = {
      weather: [
        {
          main: 'Clouds',
          description: 'scattered clouds',
          icon: '03n'
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
    }
    client_mock = MiniTest::Mock.new
    client_mock.expect(:call, response)
    presenter = WeatherPresenter.new(client_mock)

    assert_equal 'Colima', presenter.city
    assert_equal 'Clouds - scattered clouds', presenter.description
    assert presenter.icon?
    assert_equal 'http://openweathermap.org/img/w/03n.png', presenter.icon_url
    assert_equal 'Min: 20.78 °C / Max: 20.78 °C', presenter.min_max
    assert_equal '20.78 °C', presenter.weather
    assert_mock client_mock
  end

  def test_attributes_when_client_respons_is_empty
    client_mock = MiniTest::Mock.new
    client_mock.expect(:call, {})
    presenter = WeatherPresenter.new(client_mock)

    assert_equal 'Colima', presenter.city
    assert_equal ' - ', presenter.description
    refute presenter.icon?
    assert_equal 'http://openweathermap.org/img/w/.png', presenter.icon_url
    assert_equal 'Min: 0.0 °C / Max: 0.0 °C', presenter.min_max
    assert_equal '0.0 °C', presenter.weather
    assert_mock client_mock
  end
end

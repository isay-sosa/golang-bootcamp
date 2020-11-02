# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require_relative '../services/weather_service'

class WeatherPresenter
  def initialize(weather_service_client = WeatherService)
    @weather_service_client = weather_service_client
  end

  def city
    CITY
  end

  def description
    "#{weather_summary[:main]} - #{weather_summary[:description]}"
  end

  def icon?
    !weather_summary[:icon].nil?
  end

  def icon_url
    "http://openweathermap.org/img/w/#{weather_summary[:icon]}.png"
  end

  def min_max
    "Min: #{response.dig(:main, :temp_min).to_f} °C / Max: #{response.dig(:main, :temp_max).to_f} °C"
  end

  def time
    (Time.now.utc - DateTime.strptime(response[:dt].to_s, '%s').to_time).to_d / MINUTE
  end

  def weather
    @weather ||= "#{response.dig(:main, :temp).to_f} °C"
  end

  private

  CITY = 'Colima'
  MINUTE = 60.to_d

  def response
    @response ||= @weather_service_client.call
  end

  def weather_summary
    @weather_summary ||= Array(response.dig(:weather)).first || {}
  end
end

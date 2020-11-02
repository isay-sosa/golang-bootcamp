# frozen_string_literal: true

require 'net/http'

module WeatherService
  module_function

  URL = 'https://api.openweathermap.org/data/2.5/weather?q=Colima&appid=:api_key&units=metric'

  def call(api_key = ENV['OPEN_WEATHER_KEY'])
    raise 'API Key not found' if api_key.nil? || api_key.empty?

    res = Net::HTTP.get_response(URI(URL.gsub(':api_key', api_key)))
    return JSON.parse(res.body, symbolize_names: true) if res.is_a?(Net::HTTPSuccess)

    {}
  end
end

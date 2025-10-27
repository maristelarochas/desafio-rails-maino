require "net/http"
require "json"

class OmdbService
  BASE_URL = "http://www.omdbapi.com"

  def self.search_movies(title)
    api_key = Rails.application.credentials.omdb[:api_key]
    uri = URI("#{BASE_URL}?apikey=#{api_key}&t=#{URI.encode_www_form_component(title)}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end

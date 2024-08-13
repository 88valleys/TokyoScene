# app/services/spotify_service.rb
require 'rest-client'
require 'json'

class SpotifyService
  SPOTIFY_TOKEN_URL = 'https://accounts.spotify.com/api/token'

  def self.fetch_access_token
    response = RestClient::Request.execute(
      method: :post,
      url: SPOTIFY_TOKEN_URL,
      user: ENV['SPOTIFY_CLIENT_ID'],
      password: ENV['SPOTIFY_CLIENT_SECRET'],
      payload: { grant_type: 'client_credentials' },
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
    )
    JSON.parse(response.body)['access_token']
  end

  def self.search_artist(artist_name)
    access_token = fetch_access_token
    response = RestClient.get(
      "https://api.spotify.com/v1/search",
      { params: { q: artist_name, type: 'artist' },
        Authorization: "Bearer #{access_token}" }
    )
    JSON.parse(response.body)
  end
end


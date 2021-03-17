# frozen_string_literal: true

class LastFmFinder
  # For details on the configuration, see config/last_fm_api_yml
  LASTFM_API = "#{LASTFM['api_url']}&api_key=#{LASTFM['api_key']}&limit=#{LASTFM['limit']}"

  attr_accessor :summary, :error

  def initialize(current_page = '1')
    @current_page = current_page
    @summary = ''
  end

  # Returns the top tracks by artist name, limited by LASTFM['limit']
  def get_top_tracks(artist_name)
    return unless artist_name

    response = get_json('artist.getTopTracks', 'artist', artist_name)
    return unless response

    @summary = response['toptracks']['@attr']
    response['toptracks']['track']
  end

  # Returns the top artists by country name, limited by LASTFM['limit']
  def get_top_artists(country_name)
    return unless country_name

    response = get_json('geo.getTopArtists', 'country', country_name)
    return unless response

    @summary = response['topartists']['@attr']
    response['topartists']['artist']
  end

  private

  ##
  # Calls last_fm_api using:
  # 	api_method	(geo.gettopartists || artist.getTopTracks)
  # 	param_name	(country || artist)
  # 	param_value	(String || nil)
  def get_json(api_method, param_name, param_value)
    url = "#{LASTFM_API}&page=#{@current_page}&method=#{api_method}&#{param_name}=#{param_value}"
    uri = URI(url)

    Rails.cache.fetch([url,
                       { param_name => param_value, 'page' => @current_page }], expires: 2.hour) do
      response = Net::HTTP.get(uri)
      return ActiveSupport::JSON.decode(response)
    end
  end
end

class LastFmFinder
	# For details on the configuration, see config/last_fm_api_yml
	LASTFM_API = "#{ LASTFM['api_url'] }&api_key=#{ LASTFM['api_key'] }&limit=#{ LASTFM['limit'] }"
	
	attr_accessor :pagination, :error

	def initialize(current_page, pagination="", error="")
		@current_page = current_page ||= "1"
		@pagination = pagination
		@error = error
	end

	# Returns the top tracks by artist name, limited by LASTFM['limit']
	def get_top_tracks artist_name
		if artist_name && parsed_json = get_json("artist.getTopTracks", "artist", artist_name)
			@pagination = parsed_json["toptracks"]["@attr"]
			return parsed_json["toptracks"]["track"]
		end
	end

	# Returns the top artists by country name, limited by LASTFM['limit']
	def get_top_artists country_name
		if country_name && parsed_json = get_json("geo.getTopArtists", "country", country_name)
			@pagination = parsed_json["topartists"]["@attr"]
			return parsed_json["topartists"]["artist"]
		end
	end

	private
	
	##
	# Calls last_fm_api using:
	# 	api_method	(geo.gettopartists || artist.getTopTracks)
	# 	param_name	(country || artist)
	# 	param_value	(String || nil)
	def get_json api_method, param_name, param_value
		params = { param_name => param_value, 'page' => @current_page }

		url = "#{ LASTFM_API }&page=#{ @current_page }"		
		url << "&method=#{ api_method }"		
		url << "&#{ param_name }=#{ param_value }"
		uri = URI(url)

		Rails.cache.fetch([url, params], :expires => 2.hour) do
			response = Net::HTTP.get(uri)
			return ActiveSupport::JSON.decode(response)
		end
	end
end

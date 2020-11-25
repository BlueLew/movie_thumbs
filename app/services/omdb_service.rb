class OmdbService
	require 'http'
	require 'json'

	def get_data_by_title(title)
		response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.omdb_api_key}&t=#{title}").to_s
		parsed_response = JSON.parse(response)
	end
end

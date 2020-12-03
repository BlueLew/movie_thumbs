class Movie < ApplicationRecord
  require 'http'
  require 'json'
  after_initialize :init
  validates :title, presence: true
  validates :thumbs_up, presence: true
  validates :thumbs_down, presence: true

  def self.get_movie_titles(title)
    response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.omdb[:omdb_api_key]}&s=#{title.gsub(' ', '%20')}&type=movie").to_s
    parsed_response = JSON.parse(response)['Search']
  end

  def self.get_movie_details(imdb_id)
    response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.omdb[:omdb_api_key]}&i=#{imdb_id}&type=movie").to_s
    parsed_response = JSON.parse(response)
    begin
      new(title: parsed_response['Title'],
          director: parsed_response['Director'],
          release_date: parsed_response['Released'],
          plot: parsed_response['Plot'],
          poster: parsed_response['Poster'])
    rescue StandardError => e
      nil
    end
  end

  def init
    self.thumbs_up ||= 0
    self.thumbs_down ||= 0
  end
end

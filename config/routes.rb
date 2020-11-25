Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, except: [:search]
  get 'search_movie', to: 'movies#search'
  get 'search_details', to: 'movies#search_details'
  post 'thumbs_up_movie', to: 'movies#thumbs_up'
  post 'thumbs_down_movie', to: 'movies#thumbs_down'
end

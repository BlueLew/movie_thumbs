require 'uri'

class MoviesController < ApplicationController
  def search
    if params[:title].present?
      @movies = Movie.get_movie_titles(params[:title])
      if @movies
        respond_to do |format|
          format.js { render partial: 'movies/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'No movie with that title was found'
          format.js { render partial: 'movies/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a movie title to search'
        format.js { render partial: 'movies/result' }
      end
    end
  end

  def search_details
    imdb_id = request.params[:format]
    @movie = Movie.get_movie_details(imdb_id)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def thumbs_up
    @movie = Movie.find_or_initialize_by(
      title: params[:title],
      director: params[:director],
      release_date: params[:release_date],
      plot: params[:plot],
      poster: params[:poster]
    )

    @movie.thumbs_up += 1

    if @movie.save
      flash.now[:success] = 'Your thumbs up was successfully submitted.'
      redirect_to movie_path(@movie)
    else
      flash.now[:danger] = 'Your thumbs up was not submitted.'
      redirect_to move_path(@movie)
    end
  end

  def thumbs_down
    @movie = Movie.find_or_initialize_by(
      title: params[:title],
      director: params[:director],
      release_date: params[:release_date],
      plot: params[:plot],
      poster: params[:poster]
    )

    @movie.thumbs_down += 1

    if @movie.save
      flash.now[:success] = 'Your thumbs down was successfully submitted.'
      redirect_to movie_path(@movie)
    else
      flash.now[:danger] = 'Your thumbs down was not submitted.'
      redirect_to movie_path(@movie)
    end
  end

  private

  def movie_params
    params.permit(:title, :release_date, :director, :poster, :plot, :thumbs_up, :thumbs_down)
  end
end

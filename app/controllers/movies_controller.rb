class MoviesController < ApplicationController
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @movies = Movie.recent_first.page(params[:page]).per(6)
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie was successfully saved!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, notice: "Movie was successfully destroyed!"
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :synopsis, :release_year, :duration, :director, :poster)
  end

  def authorize_user!
    unless @movie.user == current_user
      redirect_to movies_path, alert: "You are not authorized to perform this action."
    end
  end
end

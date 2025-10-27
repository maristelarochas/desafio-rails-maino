class MoviesController < ApplicationController
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @movies = Movie.recent_first.page(params[:page]).per(6)

    if params[:title].present?
      @movies = @movies.where("title ILIKE ?", "%#{params[:title]}%")
    end

    if params[:director].present?
      @movies = @movies.where("director ILIKE ?", "%#{params[:director]}%")
    end

    if params[:release_year].present?
      @movies = @movies.where(release_year: params[:release_year])
    end

    if params[:category_id].present?
      @movies = @movies.joins(:categories).where(categories: { id: params[:category_id] })
    end

    @movies = @movies.page(params[:page]).per(6)
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.title.present?
      omdb_data = OmdbService.search_movies(@movie.title)

      if omdb_data["Response"] == "True"
        @movie.synopsis = omdb_data["Plot"]
        @movie.release_year = omdb_data["Year"]
        @movie.duration = omdb_data["Runtime"].to_s.split(" ").first.to_i
        @movie.director = omdb_data["Director"]
      end
    end

    if @movie.save
      redirect_to @movie, notice: "Filme salvo com sucesso!"
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
    params.require(:movie).permit(:title, :synopsis, :release_year, :duration, :director, :poster, category_ids: [])
  end

  def authorize_user!
    unless @movie.user == current_user
      redirect_to movies_path, alert: "You are not authorized to perform this action."
    end
  end
end

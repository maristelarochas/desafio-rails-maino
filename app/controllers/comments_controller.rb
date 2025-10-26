class CommentsController < ApplicationController
  before_action :set_movie
  def create
    @comment = @movie.comments.build(comment_params)

    if user_signed_in?
      @comment.user = current_user
    else
      redirect_to new_user_session_path, alert: "Voce precisa estar logado para comentar."
      return
    end

    if @comment.save
      redirect_to @movie, notice: "Comment was successfully created."
    else
      redirect_to @movie, alert: "Failed to create comment."
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end

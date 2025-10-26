class CommentsController < ApplicationController
  def create
    @comment = @movie.comments.build(comment_params)

    if user_signed_in?
      @comment.user = current_user
      @comment.author_name = nil
    end

    if @comment.save
      redirect_to @movie, notice: "Comment was successfully created."
    else
      redirect_to @movie, alert: "Failed to create comment."
    end
  end

  private

  def set_movie
    params.require(:comment).permit(:content, :author_name)
  end

  def comment_params
    params.require(:comment).permit(:content, :author_name)
  end
end

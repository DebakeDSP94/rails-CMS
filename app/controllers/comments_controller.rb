# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    @comment.save
    redirect_to @commentable, notice: 'Your comment was successfully posted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

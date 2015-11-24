class CommentsController < ApplicationController
  before_filter :require_login
  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to goal_url(@comment.goal_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to goal_url(@comment.goal_id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to goal_url(@comment.goal_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :goal_id)
  end
end

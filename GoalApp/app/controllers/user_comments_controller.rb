class UserCommentsController < ApplicationController

  def create
    @comment = current_user.authored_user_comments.new(user_comment_params)

    if @comment.save
      redirect_to user_url(@comment.user_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to user_url(@comment.user_id)
    end
  end

  def destroy
    @comment = UserComment.find(params[:id])
    @comment.destroy
    redirect_to user_url(@comment.user_id)
  end

  private
  def user_comment_params
    params.require(:user_comment).permit(:user_id, :body)
  end
end

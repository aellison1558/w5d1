class GoalsController < ApplicationController
  before_filter :require_login
  def create
    # @goal = Goal.new(goals_params)
    # @goal.user_id = current_user.id

    @goal = current_user.goals.new(goals_params)

    if @goal.save
      redirect_to user_goals_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def new
    @goal = Goal.new
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goals_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_goals_url(@goal.user_id)
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
    @goals = @user.goals
  end

  private
  def goals_params
    params.require(:goal).permit(:body, :completed, :private)
  end
end

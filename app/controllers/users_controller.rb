class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), :notice => "Welcome to the theme park!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path unless logged_in? && session[:user_id] == @user.id
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :admin, :password)
  end
end

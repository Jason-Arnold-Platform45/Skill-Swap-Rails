class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @skills = @user.skills
    @matches = Match.for_user(@user)
  end
end

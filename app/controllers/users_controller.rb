class UsersController < ApplicationController
  before_action :set_user

  def show
    @user
  end

  def update
    redirect_to @user, notice: "User was successfully updated." if @user.update(user_params).save
    render :edit
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:github_access_token)
  end
end

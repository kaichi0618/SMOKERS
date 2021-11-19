class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @shops = @user.shops
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :nickname, :profile_image, :email)
  end

end

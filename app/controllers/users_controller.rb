class UsersController < ApplicationController
  before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @shops = @user.shops
    favorites = Favorite.where(user_id: @user.id).pluck(:shop_id)
    @favorite_shops = Shop.find(favorites)
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

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:shop_id)
    @favorite_shops = Shop.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :nickname, :profile_image, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

class UsersController < ApplicationController
  before_action :set_user, only: [:favorites, :show, :update, :edit]

  def show
    @shops = @user.shops.order(created_at: :desc)
    favorites = Favorite.where(user_id: @user.id).pluck(:shop_id)
    @favorite_shops = Shop.find(favorites)
  end

  def edit
  end

  def update
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

  def withdrawal
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :nickname, :profile_image, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

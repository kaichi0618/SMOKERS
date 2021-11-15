class ShopsController < ApplicationController
  def new
    @shop_new = Shop.new
    @shops = Shop.all
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    @shop.save
    redirect_to new_shop_path, notice: "You have created book successfully."
  end

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def edit
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def shop_params
    params.require(:shop).permit(:address, :image, :shop_name, :body, :smoke_type, :genre_id)
  end

end

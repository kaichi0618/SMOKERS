class FavoritesController < ApplicationController
  
  def create
    @shop = Shop.find_by(id: params[:shop_id])
    favorite = current_user.favorites.new(shop_id: @shop.id)
    favorite.save
    @shop.create_notification_favorite!(current_user)
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    favorite = current_user.favorites.find_by(shop_id: @shop.id)
    favorite.destroy
  end
  
end

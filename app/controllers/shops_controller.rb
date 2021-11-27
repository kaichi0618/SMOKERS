class ShopsController < ApplicationController
  def new
    @shop_new = Shop.new
    @shop = Shop.new
    @shops = Shop.all
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    @shops = Shop.all
    @shop_new = Shop.new
    if @shop.save
      redirect_to shop_path(@shop.id), notice: "You have created book successfully."
    else
      render "new"
    end

  end

  def index
    @shops = Shop.all.order(created_at: :desc)
  end

  def show
    @shop = Shop.find(params[:id])
    @shop_comment = ShopComment.new
  end

  def edit
    @shop = Shop.find(params[:id])
    if @shop.user_id == current_user.id
      render 'edit'
    else
      redirect_to shops_path
    end
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      redirect_to shop_path(@shop), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    redirect_to shops_path
  end

  private

  def shop_params
    params.require(:shop).permit(:address, :image, :shop_name, :body, :smoke_type, :genre_id, :tag_list)
  end

end

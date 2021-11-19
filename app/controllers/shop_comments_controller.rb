class ShopCommentsController < ApplicationController

  def create
    @shop = Shop.find(params[:shop_id])
    @comment = ShopComment.new(shop_comment_params)
    @comment.shop_id = @shop.id
    @comment.user_id = current_user.id
    @comment.save
    redirect_to shop_path(@shop.id)
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    @comment = ShopComment.find_by(id: params[:id])
    @comment.destroy
    redirect_to shop_path(@shop.id)
  end

  private

  def shop_comment_params
    params.require(:shop_comment).permit(:comment)
  end
end

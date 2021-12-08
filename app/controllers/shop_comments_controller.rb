class ShopCommentsController < ApplicationController

  def create
    @shop = Shop.find(params[:shop_id])
    @comment = ShopComment.new(shop_comment_params)
    @comment.shop_id = @shop.id
    @comment.user_id = current_user.id
    @comment.save
    @shop.create_notification_shop_comment!(current_user, @comment.id)
    render :index
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    @comment = ShopComment.find_by(id: params[:id])
    @comment.destroy
    render :index
  end

  private

  def shop_comment_params
    params.require(:shop_comment).permit(:comment)
  end
  
end

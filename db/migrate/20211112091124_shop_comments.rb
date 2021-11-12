class ShopComments < ActiveRecord::Migration[5.2]
  def change
    drop_table :shop_comments
  end
end

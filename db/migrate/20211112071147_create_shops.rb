class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :image_id
      t.string :shop_name
      t.string :body
      t.string :smoke_type

      t.timestamps
    end
  end
end

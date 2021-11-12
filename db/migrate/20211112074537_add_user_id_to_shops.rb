class AddUserIdToShops < ActiveRecord::Migration[5.2]
  def change
    add_reference :shops, :user, foreign_key: true
  end
end

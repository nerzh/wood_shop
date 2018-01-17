class CreateWoodShopWishlists < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_wishlists do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :sub_product_id

      t.timestamps
    end
  end
end

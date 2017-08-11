class CreateWoodShopGroupProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_group_products do |t|
      t.integer :group_id
      t.integer :product_id

      t.timestamps
    end
  end
end

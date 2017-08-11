class CreateWoodShopOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
  end
end

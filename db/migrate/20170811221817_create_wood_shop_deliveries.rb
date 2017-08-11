class CreateWoodShopDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_deliveries do |t|
      t.string :name
      t.string :delivery_type
      t.string :description
      t.string :small_description
      t.integer :price

      t.timestamps
    end
  end
end

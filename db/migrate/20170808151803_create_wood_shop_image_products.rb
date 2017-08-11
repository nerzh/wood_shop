class CreateWoodShopImageProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_image_products do |t|
      t.integer :product_id
      t.string :image
      t.string :alt
      t.boolean :primary
      t.integer :order

      t.timestamps
    end
  end
end

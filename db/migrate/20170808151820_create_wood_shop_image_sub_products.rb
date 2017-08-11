class CreateWoodShopImageSubProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_image_sub_products do |t|
      t.integer :sub_product_id
      t.string :image
      t.string :alt
      t.boolean :primary
      t.integer :order

      t.timestamps
    end
  end
end

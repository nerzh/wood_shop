class CreateWoodShopImageBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_image_brands do |t|
      t.integer :brand_id
      t.string :image
      t.string :alt
      t.boolean :primary
      t.integer :order

      t.timestamps
    end
  end
end

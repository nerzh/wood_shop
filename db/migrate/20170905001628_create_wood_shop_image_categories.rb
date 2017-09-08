class CreateWoodShopImageCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_image_categories do |t|
      t.integer :category_id
      t.string :image
      t.string :alt
      t.boolean :primary
      t.integer :order

      t.timestamps
    end
  end
end

class CreateWoodShopSubProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_sub_products do |t|
      t.boolean :exist, default: true
      t.integer :product_id
      t.integer :brand_id
      t.integer :vendor_id
      t.integer :price
      t.string :name
      t.text :text
      t.string :small_text
      t.string :title
      t.string :description
      t.string :keywords
      t.integer :filterids, array: true
      t.integer :filter_valueids, array: true

      t.timestamps
    end
  end
end

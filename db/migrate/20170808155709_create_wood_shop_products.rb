class CreateWoodShopProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_products do |t|
      t.boolean :exist
      t.integer :categoryids, array: true
      t.integer :groupids, array: true
      t.integer :brand_id
      t.string :name
      t.integer :min_price
      t.integer :max_price
      t.text :text
      t.string :small_text
      t.string :url
      t.string :slug
      t.string :title
      t.string :description
      t.string :keywords
      t.integer :filterids, array: true
      t.integer :filter_valueids, array: true

      t.timestamps
    end
  end
end

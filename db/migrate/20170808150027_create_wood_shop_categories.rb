class CreateWoodShopCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_categories do |t|
      t.string :name
      t.text :text
      t.string :small_text
      t.string :url
      t.string :slug
      t.string :title
      t.string :description
      t.string :keywords
      t.integer :filterids, array: true
      t.integer :filter_valueids, array: true
      t.integer :prod_count, default: 0

      t.timestamps
    end
  end
end

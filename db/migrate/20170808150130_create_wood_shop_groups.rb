class CreateWoodShopGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_groups do |t|
      t.integer :shop_id
      t.integer :catalog_id
      t.integer :category_id
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

      t.timestamps
    end
  end
end
